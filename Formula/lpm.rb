class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.64.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.64.0/lpm-darwin-arm64"
      sha256 "cc19abc4aeb8300774551d7ff74907625aa1bbf27a441784af254937ec0a1ef8"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.64.0/lpm-darwin-x64"
      sha256 "07fd7fd5c4d67393f9500b61e51e3c81b7b2db8a1490d6b4ff28a7c969ffbe81"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.64.0/lpm-linux-arm64"
      sha256 "357daeb07c5b1d4d2f5766643bcdb87c61576b9ae91db8534f0c16abeaecef42"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.64.0/lpm-linux-x64"
      sha256 "a592cb75cd3256beef477256b9f502784e020292a48959e9feb4aab75ff6d08e"
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
