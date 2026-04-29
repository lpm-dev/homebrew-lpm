class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.28.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.28.0/lpm-darwin-arm64"
      sha256 "52628252c35ffa3a6525c9c5fc80ed118407f8895fb3a0c0e6886e7bfaa1df4f"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.28.0/lpm-darwin-x64"
      sha256 "cc9c79521794d21a92f68e6400e6e8670e547a729c6aeab1e20369ca00871c01"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.28.0/lpm-linux-arm64"
      sha256 "67e9793d1db0317636247975a505a3f20822ee0f51a67d7d8904cc18d13feed6"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.28.0/lpm-linux-x64"
      sha256 "433fffd9726ef260084ac5598e6f7eec8821faa5c6108a07ff096d7825f5a81d"
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
