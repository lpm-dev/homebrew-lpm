class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.69.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.69.0/lpm-darwin-arm64"
      sha256 "849894eecfd7fd057bcc9bce7be176711f14998fa44884c75c53463a91f607dd"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.69.0/lpm-darwin-x64"
      sha256 "4dff1017ab9cfb431069321bd2205f463ef22acc5ef0b82a8d5ac0932e4afe60"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.69.0/lpm-linux-arm64"
      sha256 "4eb856d6b3cd963239baa5e0ffe672cacdb9107fee48a4710bb77fea605c62a8"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.69.0/lpm-linux-x64"
      sha256 "d765ac6e87f43b3a2c9c52c1d49671e132fda2d1bd677610667e9b5bb45bdbbe"
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
