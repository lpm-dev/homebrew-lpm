class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-darwin-arm64"
      sha256 "30552f952012e2f9c60a322b0f30faa73880afe33d8db10b16d76d02de5504ab"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-darwin-x64"
      sha256 "b2d4f2373566a4c19e2b9bd10acfaa4c3bdbab53c4d0fd2170965c410321b3c0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-linux-arm64"
      sha256 "7b742ec6edf01e58cb5b20b7e30c8fa009e3fa5ca32860b9e5cd2c8b920a9cc8"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-linux-x64"
      sha256 "ed1a47b9919e1f63df5cfa1677f836b2b33d0f22b5b5fc7c1381f32a437879b3"
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
