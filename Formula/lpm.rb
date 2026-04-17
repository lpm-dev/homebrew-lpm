class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.20.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.20.0/lpm-darwin-arm64"
      sha256 "5ce4cc8bdd998bdf7db8dc8d3197024f989e191a71d32570ca455f26be259d63"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.20.0/lpm-darwin-x64"
      sha256 "2ceef61f433fc1d0ca16fdf63a2d49c5246701bf78bee480cb7fafd57583f1d7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.20.0/lpm-linux-arm64"
      sha256 "fe7153115cf660d3fc3c9f51b6236adf2baed05908bde0373c57845022ee05f8"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.20.0/lpm-linux-x64"
      sha256 "3be33dce15ac38dcf49fca4366ec013c34a0b2d653fae3f1b9bd2502c8cd63e0"
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
