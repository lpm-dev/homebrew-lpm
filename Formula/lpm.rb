class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.35.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.35.0/lpm-darwin-arm64"
      sha256 "74cb4aef62beea48ac43ec679983a2dd2c4751701b351826ec4475d87b0b735f"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.35.0/lpm-darwin-x64"
      sha256 "15986d49e350a8dc280268362193bdc60751714cfb0b56408ac7955f28023452"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.35.0/lpm-linux-arm64"
      sha256 "474e0073a64d0423b3ba26443e6b26a2c7ea1947152297df0bd41fd7478ae307"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.35.0/lpm-linux-x64"
      sha256 "28fb466be23d0ede5f63467f28845a8e1857cf8c18c08dbf68b9f1c5b9a9d536"
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
