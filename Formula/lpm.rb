class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.68.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-darwin-arm64"
      sha256 "59d839bfdba870377184c4b89665aaa36b4c9049afb3addd18a003c431e791cb"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-darwin-x64"
      sha256 "0832a4c9e34a776c2ba042e1a283eac6a4fa2b5b4d2ea1b087e021a3722157b3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-linux-arm64"
      sha256 "612e2e92f718022793198ad9aedf04171edb78dac90867fd2fedfc070b9f3bde"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-linux-x64"
      sha256 "73cabe5b723521a8f46fe3bd93fa04333df862b419f2d18c2540f87eb26ba7cf"
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
