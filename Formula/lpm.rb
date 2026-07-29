class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  version "0.71.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.71.0/lpm-darwin-arm64"
      sha256 "20464f174b0b78f16d98b50d8307dd76c172fbff5dc33d5e519b467274913b36"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.71.0/lpm-darwin-x64"
      sha256 "195cde957059cefcc2cd1830ab63ed652fe8865ed5255f6cb6e691078fd58249"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.71.0/lpm-linux-arm64"
      sha256 "bf61b0e09583d6c88789ed4cf79384a8a9dae242424a89746c6c843d42dd0417"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.71.0/lpm-linux-x64"
      sha256 "15415fdb6394b332d160f485f1906d02c2f8e91c16fadc129e17893313670109"
    end
  end

  def install
    binary = Dir.glob("lpm-*").first
    bin.install binary => "lpm"
  end

  test do
    assert_match "lpm #{version}", shell_output("#{bin}/lpm --version 2>&1")
  end
end
