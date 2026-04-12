class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.15.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.15.0/lpm-darwin-arm64"
      sha256 "8fe1b6524423f82ea71b2231740de8f29e2aca12d5ad93ee71f639b420daf2aa"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.15.0/lpm-darwin-x64"
      sha256 "16a23283509789ae06f3f2f8177ce3789def5d9cf2538e4d9d9730f59047f2be"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.15.0/lpm-linux-arm64"
      sha256 "960608efe8c9c7167c239d1ad9fd00c15ed42fa51b70a9d95abdb9948f0435ff"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.15.0/lpm-linux-x64"
      sha256 "7841be772e1b4a8efe39ae9dceb4c61522ed81636b1d2edf66077a9812f57a29"
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
