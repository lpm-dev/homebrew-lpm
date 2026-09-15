require "open3"

class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  version "0.78.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.78.0/lpm-darwin-arm64.zip", using: :nounzip
      sha256 "34e26a57cda0df57c84cf792e2cda3dcd341648f427e5ede2339b524ef41717f"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.78.0/lpm-darwin-x64.zip", using: :nounzip
      sha256 "53a2f533b3d5de672a694d024a75eda6f5b80d71dc3f799568f855715de4157d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.78.0/lpm-linux-arm64"
      sha256 "0fa7d3e145b3a8722373ea0b2a965dedf40e6acbd50e83b91687d6bb049d324a"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.78.0/lpm-linux-x64"
      sha256 "9b36ac4ff0a12094acca5c35733b89808e88a3741dff634b1a722cee4f91eb0e"
    end
  end

  def install
    if OS.mac?
      bundle_stage = buildpath/"macos-bundle"
      bundle_stage.mkpath
      system "/usr/bin/ditto", "-x", "-k", cached_download, bundle_stage
      app_bundle = bundle_stage/"LPM CLI.app"
      executable = app_bundle/"Contents/MacOS/lpm-rs"
      odie "release archive is missing LPM CLI.app" unless executable.executable?

      expected_entries = %w[
        Contents
        Contents/Info.plist
        Contents/CodeResources
        Contents/embedded.provisionprofile
        Contents/MacOS
        Contents/MacOS/lpm-rs
        Contents/_CodeSignature
        Contents/_CodeSignature/CodeResources
      ]
      if (app_bundle/"Contents/Resources/LPMCLI.icns").file?
        expected_entries.push("Contents/Resources", "Contents/Resources/LPMCLI.icns")
      end
      expected_entries.sort!
      ignored_entries = [".", ".."]
      bundle_entries = Dir.glob("#{app_bundle}/**/*", File::FNM_DOTMATCH)
                          .reject { |entry| ignored_entries.include?(File.basename(entry)) }
      bundle_entries.each do |entry|
        odie "release app contains a symbolic link: #{entry}" if File.symlink?(entry)
        odie "release app contains an unsupported entry: #{entry}" if !File.file?(entry) && !File.directory?(entry)
      end
      actual_entries = bundle_entries.map do |entry|
        Pathname(entry).relative_path_from(app_bundle).to_s
      end.sort
      odie "release app has an unexpected file inventory" if actual_entries != expected_entries

      system "/usr/bin/codesign", "--verify", "--strict", "--verbose=4", app_bundle
      signature_out, signature_err, signature_status = Open3.capture3(
        "/usr/bin/codesign", "-dvv", app_bundle.to_s
      )
      odie "could not read the release app signature" unless signature_status.success?
      signature_lines = (signature_out + signature_err).lines.map(&:strip)
      odie "release app has an unexpected bundle identifier" unless signature_lines.include?("Identifier=dev.lpm.cli")
      odie "release app has an unexpected Team ID" unless signature_lines.include?("TeamIdentifier=823S8YKMRW")

      entitlements_out, entitlements_err, entitlements_status = Open3.capture3(
        "/usr/bin/codesign", "-d", "--entitlements", ":-", app_bundle.to_s
      )
      odie "could not read the release app entitlements: #{entitlements_err}" unless entitlements_status.success?
      entitlements = buildpath/"lpm-cli-entitlements.plist"
      entitlements.write entitlements_out
      access_groups = Utils.safe_popen_read(
        "/usr/libexec/PlistBuddy", "-c", "Print :keychain-access-groups", entitlements.to_s
      )
      expected_access_group = "823S8YKMRW.dev.lpm.vault.shared"
      unless access_groups.lines.map(&:strip).include?(expected_access_group)
        odie "release app lacks the shared Keychain access group"
      end

      profile = app_bundle/"Contents/embedded.provisionprofile"
      profile_out, profile_err, profile_status = Open3.capture3(
        "/usr/bin/openssl", "smime", "-verify", "-noverify", "-inform", "DER", "-in", profile.to_s
      )
      odie "could not verify the release app provisioning profile: #{profile_err}" unless profile_status.success?
      profile_plist = buildpath/"lpm-cli-profile.plist"
      profile_plist.write profile_out
      profile_team = Utils.safe_popen_read(
        "/usr/libexec/PlistBuddy", "-c", "Print :TeamIdentifier:0", profile_plist.to_s
      ).strip
      profile_application_out, _profile_application_err, profile_application_status = Open3.capture3(
        "/usr/libexec/PlistBuddy",
        "-c",
        "Print :Entitlements:com.apple.application-identifier",
        profile_plist.to_s,
      )
      unless profile_application_status.success?
        profile_application_out, _profile_application_err, profile_application_status = Open3.capture3(
          "/usr/libexec/PlistBuddy",
          "-c",
          "Print :Entitlements:application-identifier",
          profile_plist.to_s,
        )
      end
      odie "release app profile lacks an application identifier" unless profile_application_status.success?
      profile_application = profile_application_out.strip
      profile_groups = Utils.safe_popen_read(
        "/usr/libexec/PlistBuddy",
        "-c",
        "Print :Entitlements:keychain-access-groups",
        profile_plist.to_s,
      )
      odie "release app profile has an unexpected Team ID" if profile_team != "823S8YKMRW"
      if profile_application != "823S8YKMRW.dev.lpm.cli"
        odie "release app profile has an unexpected application identifier"
      end
      authorized_profile_groups = [expected_access_group, "823S8YKMRW.*"]
      unless profile_groups.lines.map(&:strip).intersect?(authorized_profile_groups)
        odie "release app profile lacks the shared Keychain access group"
      end

      system "/usr/bin/xcrun", "stapler", "validate", app_bundle
      system "/usr/sbin/spctl", "--assess", "--type", "execute", "--verbose=4", app_bundle

      libexec.install app_bundle
      installed_executable = libexec/"LPM CLI.app/Contents/MacOS/lpm-rs"
      bin.install_symlink installed_executable => "lpm"
      bin.install_symlink installed_executable => "lpx"
    else
      binary = Dir.glob("lpm-*").first
      odie "release is missing the LPM binary" unless binary
      bin.install binary => "lpm"
      bin.install_symlink "lpm" => "lpx"
    end
  end

  test do
    assert_match "lpm #{version}", shell_output("#{bin}/lpm --version 2>&1")
  end
end
