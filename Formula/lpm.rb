class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-darwin-arm64"
      sha256 "cf85f0a6bdfa27bf972775e5219f95b89a82793776a45a3c8499baf0618ec0a1"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-darwin-x64"
      sha256 "a86cf0cbf2a4c7856feeddcba6f93e59ae7797fe4252302b82cbb2d30914ebcb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-linux-arm64"
      sha256 "d522a4824d884b9e8c71e9f226f562d2fa14503929d7dc1599764790af6a4fc9"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-linux-x64"
      sha256 "e8f0ea2ae16ed8fc70deb3e2280b6bc44c232b0e11fe80eeaf08789b3a408316"
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
