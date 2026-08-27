#!/usr/bin/env ruby

require "erb"
require "fileutils"
require "optparse"
require "uri"

repo_root = File.expand_path("..", __dir__)
options = {
  output: File.join(repo_root, "Formula", "lpm.rb"),
  release_base_url: nil,
}

OptionParser.new do |parser|
  parser.on("--output PATH") { |path| options[:output] = File.expand_path(path) }
  parser.on("--release-base-url URL") { |url| options[:release_base_url] = url }
end.parse!

version = ENV.fetch("VERSION")
unless version.match?(/\A(?:0|[1-9]\d*)\.(?:0|[1-9]\d*)\.(?:0|[1-9]\d*)\z/)
  abort "VERSION must be a stable semantic version without a leading v"
end

hash_names = %w[
  SHA_DARWIN_ARM64
  SHA_DARWIN_X64
  SHA_LINUX_ARM64
  SHA_LINUX_X64
]
hashes = hash_names.to_h do |name|
  value = ENV.fetch(name)
  abort "#{name} must be a lowercase SHA-256" unless value.match?(/\A[0-9a-f]{64}\z/)
  [name, value]
end

release_base_url = options[:release_base_url] ||
                   "https://github.com/lpm-dev/rust-client/releases/download/v#{version}"
if options[:release_base_url]
  uri = URI.parse(release_base_url)
  loopback_http = uri.scheme == "http" && %w[127.0.0.1 localhost ::1].include?(uri.host)
  local_file = uri.scheme == "file" && uri.path.start_with?("/")
  abort "local release base must be a loopback HTTP URL or an absolute file URL" unless loopback_http || local_file
end
release_base_url = release_base_url.delete_suffix("/")

template_path = File.join(repo_root, "templates", "lpm.rb.erb")
template = ERB.new(File.read(template_path), trim_mode: "-")
formula = template.result_with_hash(
  version:,
  release_base_url:,
  sha_darwin_arm64: hashes.fetch("SHA_DARWIN_ARM64"),
  sha_darwin_x64: hashes.fetch("SHA_DARWIN_X64"),
  sha_linux_arm64: hashes.fetch("SHA_LINUX_ARM64"),
  sha_linux_x64: hashes.fetch("SHA_LINUX_X64"),
)

FileUtils.mkdir_p(File.dirname(options[:output]))
File.write(options[:output], formula)
