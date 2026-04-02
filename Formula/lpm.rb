class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.9.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.0/lpm-darwin-arm64"
      sha256 "6811b06c78d12156622290c591d35029d2767425857f67dab5c56b77af836b2e"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.0/lpm-darwin-x64"
      sha256 "5edef65edd8379796ab5a53c3d01615913993de9ad97d48b0a1ffb768a5e8e07"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.0/lpm-linux-arm64"
      sha256 "8652eed56da4d9adeb70b4083b207eaa48e1c1dbf529934801e151a962a6bbfb"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.0/lpm-linux-x64"
      sha256 "e52dfaa0eda5debd44858c94203470bfb55dd2efb6b99c8a7d9a947073afff2f"
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
