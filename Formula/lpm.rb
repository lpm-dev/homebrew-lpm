class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-darwin-arm64"
      sha256 "491a02bb6881dfa46a39335366a138f259e22f562e9e20b0389fc2e1c1d67b7d"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-darwin-x64"
      sha256 "c5cf224cb1b59b9224653383c736107fc6df10ba9c33cd8d055aa5e272c56b4b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-linux-arm64"
      sha256 "7eacf32248ab24fd53ffe8025d43cdf5ea36cb8488096f8926474f0982b98a28"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-linux-x64"
      sha256 "34c26a1f01643a33c126e0d2466a0c9853aa3398ec37d107c07029be70d9726a"
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
