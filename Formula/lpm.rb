class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.10.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.10.0/lpm-darwin-arm64"
      sha256 "5a16ba454e2cbe236f408c35aa1673d829ffa73095cd65c163a8423a08ef7104"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.10.0/lpm-darwin-x64"
      sha256 "54079f86b68f54e10a6aea12f295f957a16a0e1336e9a934f3eb8719d7394fee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.10.0/lpm-linux-arm64"
      sha256 "af93169e0aa503260f4083d59b55e4f3f0bdd8370cbd03f8f430f08a0f33dffc"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.10.0/lpm-linux-x64"
      sha256 "649179af64b9b2279612fd2d25e4e893394201bc481b2a416d0535c292f96e76"
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
