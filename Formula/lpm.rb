class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.72.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.72.0/lpm-darwin-arm64"
      sha256 "2b3ea2789763e6c29397fd9dcc34a3b1ab2be51570d743b3297261262195ea09"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.72.0/lpm-darwin-x64"
      sha256 "6e05418709aa994ce85b9201779997842382b1f7a454784d35399c985d6ccbde"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.72.0/lpm-linux-arm64"
      sha256 "c4c89269d6125cf574f45fc56c03a6c106b7afa04104df23407f1b830fa2f7a3"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.72.0/lpm-linux-x64"
      sha256 "e6b8186bc2c315386ea96794412573bf2d53882ae7cd66c6edb0db16e8cba7d1"
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
