class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.59.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.59.0/lpm-darwin-arm64"
      sha256 "b299577b4f20579e356426af8879eb6f7aab12fee1e10bbb689387d18a033840"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.59.0/lpm-darwin-x64"
      sha256 "22fade277948c3be4dc53576f4a976069fac4531b37a8f0f928ed62425b31222"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.59.0/lpm-linux-arm64"
      sha256 "2a363b1bbd536e6a0001ebc08ee1a72d8f32cc6151c57dbd6ec7575844d87d00"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.59.0/lpm-linux-x64"
      sha256 "43d11bba8c043e255824d1f1b40a9f4ddfb5ba859a5df014bbae8fb5f849b849"
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
