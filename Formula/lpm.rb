class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.44.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.44.0/lpm-darwin-arm64"
      sha256 "e9461b417610ac884024faceeb76f263386863f17b85a2ef74a4bea9e166ed29"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.44.0/lpm-darwin-x64"
      sha256 "ed45679378b908551243e78a5ce4b7f4fca0b90d26b5d32b394e0f5f89237298"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.44.0/lpm-linux-arm64"
      sha256 "ef93ad3cb87571955176b161561a9006ffaba4d233ef1cf62810edb74957c833"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.44.0/lpm-linux-x64"
      sha256 "5730d2a66e5d5df8c0c831cbe33267f9a85dbb587ec51e6e17ec844cb03725f8"
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
