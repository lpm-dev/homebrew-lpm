class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.11.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.11.0/lpm-darwin-arm64"
      sha256 "fb0ed4b897dbe5dfeed38c0e522c22cbb9c5a0dac33092d83090150a29af03b3"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.11.0/lpm-darwin-x64"
      sha256 "ad24228ab94295f200c33f2492ed2c5ea9a4cc4572058d2844a94e4d773e5db2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.11.0/lpm-linux-arm64"
      sha256 "4f0bc65edc51677f8b7166be2ebad0fb2e0e34ec19dc7917215c92dd13fb5be0"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.11.0/lpm-linux-x64"
      sha256 "71791a8732799ac99e08bf676a59ebc5bc4e0a157a9efd963030b9dd49a5e164"
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
