class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.59.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.59.1/lpm-darwin-arm64"
      sha256 "9bceaea0d0f9e05b8969b8cee13164e0780b6bd7488d0db4538b0fd7c487faab"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.59.1/lpm-darwin-x64"
      sha256 "b31988242d254e4462f4cb137b41f493bfbe63682d279616a225177b69e48da6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.59.1/lpm-linux-arm64"
      sha256 "6ada5772e13d5aa5d0ecd0f549343e81acecec855538179d2d1e322f390c24d2"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.59.1/lpm-linux-x64"
      sha256 "66d59bad77aa9a9bd36df6870665a57e99108b42aab43f122d4388690b92a44d"
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
