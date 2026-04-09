class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.13.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.13.0/lpm-darwin-arm64"
      sha256 "4084451e0db6d1585a4da156ef5582775ecc86f5ca7439ea55a03fefaa90589b"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.13.0/lpm-darwin-x64"
      sha256 "378eae5b5ce91c2f08226439f8889f51b5bdf1842e2e34421926bd5671f4cdfe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.13.0/lpm-linux-arm64"
      sha256 "e6371b1c9dd4e88caccda2b18c3390bf0b55e07befdf2e308b56081fa910fc6f"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.13.0/lpm-linux-x64"
      sha256 "84507de02cda808c5dc762e6790ba3ee4ae2057556437ac0c1e492751ef9e278"
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
