class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.26.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.26.0/lpm-darwin-arm64"
      sha256 "79f97cf7d0a38523449b91bafc7fb69b4ba2b69bc68db0cc570e1e679f373e06"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.26.0/lpm-darwin-x64"
      sha256 "819bcb60b05048ad3c917c4b228f5901330a35d2287d99efb21b138ffcc85994"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.26.0/lpm-linux-arm64"
      sha256 "aadb630b51981fa663b03b972e8f43ef4680661cbd87ef75527c566bc1884476"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.26.0/lpm-linux-x64"
      sha256 "ad6a71e912970880fb85af39a1c53dfe504b84f5f862644ecf7b7b2a97fc838f"
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
