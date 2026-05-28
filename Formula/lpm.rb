class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.48.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.48.2/lpm-darwin-arm64"
      sha256 "69af33f29bcde0e6eedbcc8f7cc741d4df41a386293c6d0b25db2e16e8e28838"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.48.2/lpm-darwin-x64"
      sha256 "d8d8dada90a838b9bed7555452b19537763b717dce9d5f198784b5967afc8e79"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.48.2/lpm-linux-arm64"
      sha256 "284ddc4395a7c94d39342b1efce7bed8fd1211b3e590f732eb6664011c842252"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.48.2/lpm-linux-x64"
      sha256 "5eaf38fc4f6e1ec4b117a8c03cb40f5b88a225e3d746250f3522ca1840af4985"
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
