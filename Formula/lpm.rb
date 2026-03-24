class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.4.0/lpm-darwin-arm64"
      sha256 "0529212b074760238051a347517f013de0233bdbbf75b4e38d611490c8bd4a97"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.4.0/lpm-darwin-x64"
      sha256 "02eea7f599bcbe9abd0bca3e43a4a8d4a48c408865158584e99e790291bbb3a1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.4.0/lpm-linux-arm64"
      sha256 "476ca3fc8c3b6785995fade690d444fcc2e23453335edf049f818afa880216e4"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.4.0/lpm-linux-x64"
      sha256 "2fd6659abf5cac29eb33638f670f450f899eb12deb14b3035643a55bc2985131"
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
