class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.34.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.34.0/lpm-darwin-arm64"
      sha256 "0acd0cbc8d625d5840976b105f6b020857fa7bb21a6e258572d38e9e0098ffb1"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.34.0/lpm-darwin-x64"
      sha256 "bfea22c701c99b969ef9f4ec089878ec9c44638c1c60f107e9fe4aa1304dcf00"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.34.0/lpm-linux-arm64"
      sha256 "7ad9eb44eb069fe18f920ae6f42f9f756f6da4248a201cf34051238a9b5903d3"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.34.0/lpm-linux-x64"
      sha256 "3c03f110d10bf180eb83098411f2c73b385d989b24eeb9a24c0d6a84b83a1db7"
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
