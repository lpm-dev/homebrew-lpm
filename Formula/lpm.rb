class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.36.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.36.0/lpm-darwin-arm64"
      sha256 "4d840b3df0cf8bd1a36bb0f121fb0dd1e686679396b66e1eda9070d4033772bd"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.36.0/lpm-darwin-x64"
      sha256 "47a36f34e4ed4c03394e6d47f42ea3e78367c58cd10aeb388673fd25726d0c99"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.36.0/lpm-linux-arm64"
      sha256 "c05952a7e44be85de37685b5391590d10e7f5b6513809ff826c4d4b9b261f2ef"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.36.0/lpm-linux-x64"
      sha256 "e6031237807daeecd2cd48ec7ac7d66b48e6645118ed44e8565532181cd37b4d"
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
