class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.45.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.45.0/lpm-darwin-arm64"
      sha256 "807c3c6a746d0d9113577ce5293ec5e50fabac3defc8bf90494e5d41003864c1"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.45.0/lpm-darwin-x64"
      sha256 "0051fe8c81ca1cba484eb8f506bcfd9aaf123368d62d377eb390cfc1f2074462"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.45.0/lpm-linux-arm64"
      sha256 "e6446fb5a4958fc6051b9c65bf0529c9032e3f8e60aa8e99ed54b7fda743d130"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.45.0/lpm-linux-x64"
      sha256 "ac50eff374fe2dcb1ad5ae504cf4fe3d4aaf0ba5e51d9aabb66d752845de123f"
    end
  end

  def install
    binary = Dir.glob("lpm-*").first
    bin.install binary => "lpm"
  end

  test do
    assert_match "lpm-rs", shell_output("#{bin}/lpm --version 2>&1", 0)
  end
end
