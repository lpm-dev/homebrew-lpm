class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.31.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.31.0/lpm-darwin-arm64"
      sha256 "92fa1c5f2cd5d4dd85b6ebd1897cb553a59c6061880968ab8aab1779199f1099"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.31.0/lpm-darwin-x64"
      sha256 "ed2d3b5bf96e9d4da9b2af895f87da35ee54ff52d2ab136cadbda7fde401295a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.31.0/lpm-linux-arm64"
      sha256 "004d280fdd46a292ecb6f4ed1d56f71c285db8bd1b7ce11c3cd1415311abedb1"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.31.0/lpm-linux-x64"
      sha256 "35dde224f84b33e982369d80a68f4dc3060cbe28b083928d932eebe55cf6ed35"
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
