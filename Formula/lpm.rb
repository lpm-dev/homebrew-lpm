class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  version "0.75.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.75.0/lpm-darwin-arm64"
      sha256 "36ef125a009d5d3eeaaff206589abe01d3b13ead7612bc3dfe50b01afa26523c"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.75.0/lpm-darwin-x64"
      sha256 "c25ebd94e08f17c01a342978b164ec976f0d1e01fc53fe77f59025b5990e62ee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.75.0/lpm-linux-arm64"
      sha256 "043aa02c2f6daae51e1bb9e997d6959bf7892b4aa9628d47467c93b4f029c9a0"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.75.0/lpm-linux-x64"
      sha256 "834f6daf5d65e352d86525e8763b0954140af185cce6298b4655a0e527ce1fa8"
    end
  end

  def install
    binary = Dir.glob("lpm-*").first
    bin.install binary => "lpm"
    bin.install_symlink "lpm" => "lpx"
  end

  test do
    assert_match "lpm #{version}", shell_output("#{bin}/lpm --version 2>&1")
  end
end
