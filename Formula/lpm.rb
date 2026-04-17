class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.19.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.19.1/lpm-darwin-arm64"
      sha256 "3d19de171d161b9c04c7ed069eb3017b4c737525101e7b5947830f28e52e25e6"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.19.1/lpm-darwin-x64"
      sha256 "cde06b5e0db868524168de8653390a515286664eb42baa45eade07f357786dc4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.19.1/lpm-linux-arm64"
      sha256 "74f54af88c9c5fefbcb7d1916e0cc468250c99f0f0fbba7e9472e46ce227f7c9"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.19.1/lpm-linux-x64"
      sha256 "bb079a8c41eadd53d9c4f41ca790e3f5c07f5d60f325f2a8add5931076ea4295"
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
