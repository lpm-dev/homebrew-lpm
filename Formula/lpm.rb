class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.30.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.30.0/lpm-darwin-arm64"
      sha256 "33c6f3583721eca258fa60d32cb02fe321a6606d859aaf148fb681051c1fe80f"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.30.0/lpm-darwin-x64"
      sha256 "4c46e25e81c825538de0ea9efb9409a10a08a79fac8979903f708a47a83e3881"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.30.0/lpm-linux-arm64"
      sha256 "fa9659a683fdfff347c95da65d62d88cf7ec5f95fc627268324c9b0f0fd5572f"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.30.0/lpm-linux-x64"
      sha256 "d059dc8663d63b9a4798b87ee42eb18f1429dd5145c8f292b4f18c50ecdad4df"
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
