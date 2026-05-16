class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.41.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.41.1/lpm-darwin-arm64"
      sha256 "18f81b9e5692fa4d62e56754191a6a9954462a9313caebcac930f8b0fcdb66aa"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.41.1/lpm-darwin-x64"
      sha256 "20fb397dc66187de5fa29b84363e8a3e230c31a3566788f02099861deec34e06"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.41.1/lpm-linux-arm64"
      sha256 "3cea94b7fbc73022f0ec24237cab9cad92cd2913c305bf49355831dc3286f195"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.41.1/lpm-linux-x64"
      sha256 "72435626befe17dfdc4f2415063133f37a78a16e98fa606c3a9a0557e00b87cd"
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
