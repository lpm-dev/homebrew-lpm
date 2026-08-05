class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.73.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.73.0/lpm-darwin-arm64"
      sha256 "ceff821bd0c65e2d7033ee54fa4d15af96ce6a90939c48d352051ba56a0ca4ea"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.73.0/lpm-darwin-x64"
      sha256 "6fa5434edaaca4584b5fb23c0c35e4006056f0caa085681c409da16d6ff0d3c1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.73.0/lpm-linux-arm64"
      sha256 "8d4034c32746ed04bfa9f171fb17271129460f7f7d41d05113f5abdf4f8489ae"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.73.0/lpm-linux-x64"
      sha256 "12df45e0d13c0f3846651d25f9ce005f6ee985127f4a770464502fba72462d7a"
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
