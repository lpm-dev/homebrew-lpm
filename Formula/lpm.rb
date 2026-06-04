class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.54.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.54.0/lpm-darwin-arm64"
      sha256 "d7e4ce061cc34b854ae4cc490410ff2bafb8f6887b52625bf13fd853482f76b9"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.54.0/lpm-darwin-x64"
      sha256 "2596ab845f1f8f49e8ca8cc2f1b77011aa57d4d59c36edead30f43d85cca7fef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.54.0/lpm-linux-arm64"
      sha256 "8b125c574d87709576811040aa97b816fbb649d4837bd8adb1b663ad2f9340a5"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.54.0/lpm-linux-x64"
      sha256 "6990861c29d264182ac78be026ae20d2f706afc87141fd45dc244bd2cd052a11"
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
