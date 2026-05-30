class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.50.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.50.0/lpm-darwin-arm64"
      sha256 "28c4eea7647c7d8c70f3e5e2f0b5840634e35cd8a74b24a0e8c7f13e8effa226"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.50.0/lpm-darwin-x64"
      sha256 "681dec282b6bb0f5493f6f957c3229a3e3f18778eeb7c02e766786e2be10952d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.50.0/lpm-linux-arm64"
      sha256 "ac1f1327e68e0d9ba0b0e89328082f35540b7a8f5a322e74494fb553eee61a7b"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.50.0/lpm-linux-x64"
      sha256 "ee4eb9c392d3e2e37d7df2fdac701ca491164df083fa27d1d2c5384ed7dfd9f7"
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
