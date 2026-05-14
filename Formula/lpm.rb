class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.41.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.41.0/lpm-darwin-arm64"
      sha256 "45420cf9b8be3f8bcf3ee282f206515070813edca93a1a9ad96fdaff7eaef51d"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.41.0/lpm-darwin-x64"
      sha256 "f334aceb3161802832cc9b7ca268fec61c2e98ff71d59c6b3bc296933cc0e0ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.41.0/lpm-linux-arm64"
      sha256 "ac03ff13c8671a6cc30e5864bc0bf68ee5a583dad790d361587be8ebad353a76"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.41.0/lpm-linux-x64"
      sha256 "2ee2fdb162f9703e5ff8930f0287bb1e79398326fad8b204537a5e4cc49e6909"
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
