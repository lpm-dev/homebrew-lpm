class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.27.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.27.0/lpm-darwin-arm64"
      sha256 "d33069f8a748f65ccfd68516a7d4530eca14e1f2b358d964b85f16f17b58cb2d"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.27.0/lpm-darwin-x64"
      sha256 "29a07b3d46a6d72b304dc720ecbf106624c831f7ffb668f6d345f3c9729ff0a9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.27.0/lpm-linux-arm64"
      sha256 "28d62cd8ef629c2835175d28efb2200f2ea07662b313d178c964fbb092a16d0f"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.27.0/lpm-linux-x64"
      sha256 "26b1eeed5a05be761bf8f79bb8adeb2fe8926e9f90960bdb5c32512f0d0b6a67"
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
