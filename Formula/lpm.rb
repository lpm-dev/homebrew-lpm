class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.22.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.22.0/lpm-darwin-arm64"
      sha256 "9bcf57a03d5da5527f90d698c31b2c66dd66673ea3b38ec81e55da1060fe38ea"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.22.0/lpm-darwin-x64"
      sha256 "5418c056ecbe79f211b2a283504d0a69269aa56c15c6dcc04051f1340dd1612f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.22.0/lpm-linux-arm64"
      sha256 "ef294d13b250d32d31e0ea41ad1c894d1774372dc3904f1ea46d3eba2893fc4d"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.22.0/lpm-linux-x64"
      sha256 "13a48dfcaac635f097c3cda14fa0b7cb4a818e9fb25053a9c0dbe2d3031db1ba"
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
