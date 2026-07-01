class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.65.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.65.0/lpm-darwin-arm64"
      sha256 "eb237caa0f473b1bc2f2b4465c9f057de752ba84e9b945211fb3139ab8aaa99e"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.65.0/lpm-darwin-x64"
      sha256 "87e9deb2fa8e51e505c08399d7f1230dcb9ef0908d8c58b9a773a39897f7b0f1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.65.0/lpm-linux-arm64"
      sha256 "298e11853e04a1096a940a47fdd35513d470df4dc4dafba22d3c3eb34208e3b0"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.65.0/lpm-linux-x64"
      sha256 "f3405e67fa55f5e5cf4c0e52223f63a134ed9496350e8fa0102c2d55731ea4d5"
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
