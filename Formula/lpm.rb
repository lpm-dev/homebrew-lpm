class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.66.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.66.0/lpm-darwin-arm64"
      sha256 "ad339591f42de9f337a539d0d92cfce912341541a27b4454a1827dfac7815109"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.66.0/lpm-darwin-x64"
      sha256 "c97a31b3776910a6fd8d36e9ef301565b03f70c804745bfcd5e73878b825083b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.66.0/lpm-linux-arm64"
      sha256 "662eb52d968e839a753069d11e720ec06e5c691c670dca8a1ad2aa888d2fc12d"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.66.0/lpm-linux-x64"
      sha256 "2c8150b3180abc3506f3038eb1f80ba0666a4ef574fa6c7e47a09b6700cfb732"
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
