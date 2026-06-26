class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.63.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.63.0/lpm-darwin-arm64"
      sha256 "1b4eac9954f692d7db537e200cbcfd3f8244430685e2808f341e31941594db86"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.63.0/lpm-darwin-x64"
      sha256 "9aefed23d9168fa2f0635cabe4723294cf0df590047a7ddbbe024758be56f1a7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.63.0/lpm-linux-arm64"
      sha256 "431fbc5bc625b426e0aa1f48dbc2fe44354b2f4f9a8723de54b85848706e8d9b"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.63.0/lpm-linux-x64"
      sha256 "af9b53511c9aaba970077d20f5c0e398f52f05a42c34250caed96b0cf320017f"
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
