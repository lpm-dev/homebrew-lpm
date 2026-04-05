class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.9.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.1/lpm-darwin-arm64"
      sha256 "d1f0773cb631cb7787627dd616a28e02891aac1c9711e81f9e2a4208e470ad00"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.1/lpm-darwin-x64"
      sha256 "e73430b242046d53124daaa877ae4b313480ed6b168118b99d4d9951714375a8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.1/lpm-linux-arm64"
      sha256 "34510dcce85c6306915d235e86569e78bfde597016d9aabeffb7db836879b0aa"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.1/lpm-linux-x64"
      sha256 "76c22f5c0bd8126589a1ca9fff37fd2be4551e6785c75aefcee47e2e4ca8533c"
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
