class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.56.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.56.0/lpm-darwin-arm64"
      sha256 "9f560af1f681651b00c76c9a3502f6e8ffa254353ce7a93e60c8812b3a2ae7ec"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.56.0/lpm-darwin-x64"
      sha256 "29431f9e7c4dd448b20d3b66e1f49b8d8e3fd0dfe0ae3bc323dc9d077972b863"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.56.0/lpm-linux-arm64"
      sha256 "22896343b68e56600b80d3bc470caca2ef0d1e2f57365d2a9ffef8694386d2a2"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.56.0/lpm-linux-x64"
      sha256 "356ba9b2f9950329308f66f7b37d9414d7b1d301f701b4ac40dacb7b5a6223b9"
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
