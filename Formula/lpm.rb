class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.33.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.33.0/lpm-darwin-arm64"
      sha256 "0246716db482e2d4e32b434a0b8f56cd4ccbcaa54d91e53db76e25e89e036f66"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.33.0/lpm-darwin-x64"
      sha256 "28e188950a77d0c199a5fea1fd4b32c75ade3d9c4421e61f15462ffa5a37756a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.33.0/lpm-linux-arm64"
      sha256 "33273d9d1477ea5a781331974a512a08070d478de2999e0eeaf80911dd694471"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.33.0/lpm-linux-x64"
      sha256 "fc4ae4c0936651ff638893a7e52ebb969c4c8cde84c2dc513b49d3d1ac39eb8c"
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
