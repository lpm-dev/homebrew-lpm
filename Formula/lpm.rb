class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.57.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.57.0/lpm-darwin-arm64"
      sha256 "25e8234aab45979ced650b5899cddf6076388ff60664334cac06a3f7b0a7f80e"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.57.0/lpm-darwin-x64"
      sha256 "18a932474882bcf94991a4323850e8fc0e52d2418e61615b81fece416765ccba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.57.0/lpm-linux-arm64"
      sha256 "ecdbe4126bb3e0235b5d645f71c6d57228db9e7d85204d15a97d300830281713"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.57.0/lpm-linux-x64"
      sha256 "34cb7d77c9fd16aef4abe9bcd83d0a92326336f70cfa0f6b0ae6a59ee95a36b7"
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
