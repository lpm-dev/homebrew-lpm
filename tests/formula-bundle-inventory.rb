#!/usr/bin/env ruby

require "fileutils"
require "pathname"
require "tmpdir"

class InventoryRejected < StandardError; end

class FormulaInventoryHarness
  class << self
    def desc(*); end
    def homepage(*); end
    def version(*); end
    def license(*); end
    def url(*); end
    def sha256(*); end
    def on_linux; end
    def test; end

    def on_macos(&block)
      class_eval(&block)
    end
  end

  attr_reader :buildpath, :cached_download

  def initialize(buildpath)
    @buildpath = buildpath
    @cached_download = buildpath/"release.zip"
  end

  def odie(message)
    raise InventoryRejected, message
  end

  def system(*arguments)
    return if arguments == ["/usr/bin/ditto", "-x", "-k", cached_download, buildpath/"macos-bundle"]

    expected = ["/usr/bin/codesign", "--verify", "--strict", "--verbose=4", buildpath/"macos-bundle/LPM CLI.app"]
    raise "unexpected command before signature verification: #{arguments.inspect}" unless arguments == expected

    throw :signature_verification_reached, true
  end
end

module MacOSInventoryHost
  def self.mac?
    true
  end
end

module ArmInventoryHardware
  module CPU
    def self.arm?
      true
    end
  end
end

def load_formula(path)
  namespace = Module.new
  namespace.const_set(:Formula, FormulaInventoryHarness)
  namespace.const_set(:OS, MacOSInventoryHost)
  namespace.const_set(:Hardware, ArmInventoryHardware)
  namespace.module_eval(File.read(path), path)
  namespace.const_get(:Lpm)
end

def build_bundle(app)
  %w[
    Contents/Info.plist
    Contents/CodeResources
    Contents/embedded.provisionprofile
    Contents/MacOS/lpm-rs
    Contents/_CodeSignature/CodeResources
  ].each do |entry|
    file = app/entry
    file.dirname.mkpath
    file.write("fixture")
  end
  (app/"Contents/MacOS/lpm-rs").chmod(0o755)
end

def add_icon(app)
  resources = app/"Contents/Resources"
  resources.mkpath
  (resources/"LPMCLI.icns").write("icns fixture")
end

cases = [
  ["iconless bundle reaches signature verification", nil, ->(_app) {}],
  ["bundle with the release icon reaches signature verification", nil, ->(app) { add_icon(app) }],
  ["empty resources directory is rejected", /unexpected file inventory/, ->(app) {
    (app/"Contents/Resources").mkpath
  }],
  ["unrecognized icon filename is rejected", /unexpected file inventory/, ->(app) {
    add_icon(app)
    File.rename(app/"Contents/Resources/LPMCLI.icns", app/"Contents/Resources/other.icns")
  }],
  ["additional resource file is rejected", /unexpected file inventory/, ->(app) {
    add_icon(app)
    (app/"Contents/Resources/extra.txt").write("unexpected")
  }],
  ["symbolic link icon is rejected", /symbolic link/, ->(app) {
    add_icon(app)
    (app/"Contents/Resources/LPMCLI.icns").unlink
    File.symlink("../Info.plist", app/"Contents/Resources/LPMCLI.icns")
  }],
  ["directory in place of the icon is rejected", /unexpected file inventory/, ->(app) {
    (app/"Contents/Resources/LPMCLI.icns").mkpath
  }],
]

abort "usage: #{$PROGRAM_NAME} FORMULA [FORMULA ...]" if ARGV.empty?

ARGV.each do |path|
  formula = load_formula(path)
  cases.each do |name, expected_error, mutate|
    Dir.mktmpdir("lpm-formula-inventory-") do |root|
      buildpath = Pathname(root)
      app = buildpath/"macos-bundle/LPM CLI.app"
      build_bundle(app)
      mutate.call(app)
      begin
        accepted = catch(:signature_verification_reached) { formula.new(buildpath).install }
        raise "#{name}: inventory was accepted" if expected_error
        raise "#{name}: signature verification was not reached" unless accepted == true
      rescue InventoryRejected => e
        raise "#{name}: #{e.message}" unless expected_error&.match?(e.message)
      end
      puts "PASS: #{File.basename(path)}: #{name}"
    end
  end
end
