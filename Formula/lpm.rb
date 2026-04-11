class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.14.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.14.0/lpm-darwin-arm64"
      sha256 "8c2dc2b9d78cf3497f860228ede91b59c4e6467a45b529d4d464f7a4dca77550"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.14.0/lpm-darwin-x64"
      sha256 "d501c6e1b150cb192952a6ed8a7c9abc00f3a01afc087e156059bfd1357b99b2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.14.0/lpm-linux-arm64"
      sha256 "fbe1e934d15195d31ea81f34ca371e8706feb5ff12f1283c59f43d4ebe352494"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.14.0/lpm-linux-x64"
      sha256 "9ef5abc6cec124af6ce0c2ed20f96b95fd4511a16204943c9a7d8c3e80b305af"
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
