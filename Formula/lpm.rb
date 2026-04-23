class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.23.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.23.0/lpm-darwin-arm64"
      sha256 "14944bc31c3bf3ed7a0c226cb87516377f768457b3e47d8deb5ed6e2f2c91b55"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.23.0/lpm-darwin-x64"
      sha256 "285d1beee2f7b58c774477729e16d9ba20c7e3dd2496b2f47abfb7b65cef8e06"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.23.0/lpm-linux-arm64"
      sha256 "daad2696238c05455e9bc3840caddd74874a5dac72b333e77990493c8f551c09"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.23.0/lpm-linux-x64"
      sha256 "f83fd54309f81911900af172f1f3e6162bd5485cd16b866a1284ebd3f8af36b6"
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
