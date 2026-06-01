class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.52.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.52.0/lpm-darwin-arm64"
      sha256 "3a757d4537bfaa00017a3e0deb95a77258a3cf2e40abb017f32b1267ca4ce355"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.52.0/lpm-darwin-x64"
      sha256 "f53b3f691e2363b5f0fdefd1eab28b15c3006dbea68f0425405e8c70b61095fe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.52.0/lpm-linux-arm64"
      sha256 "56d090f2a1c5a9246c5ffad3aef798787b97635514aa6c7dbc2f6b15e9b1c166"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.52.0/lpm-linux-x64"
      sha256 "2ed95b2b8cc75d1e21010b8ab5e3f8a0f1a4b557475b4ca9a56a1f16b486b4ec"
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
