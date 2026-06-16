class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.61.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.61.0/lpm-darwin-arm64"
      sha256 "c8640d899e71fcb909b0bcbc307aa74ca1c743c12421f4d44a8895eef9b0d19c"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.61.0/lpm-darwin-x64"
      sha256 "ee67b879cc9c3e735d5824e5dda1c5e7dcb57cebda7b706062e511c7f86f6b39"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.61.0/lpm-linux-arm64"
      sha256 "b56907e5d524fd702ff95c07f410af9e80191f59efa9743f9a7d2081f86bd995"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.61.0/lpm-linux-x64"
      sha256 "c5d9f81c89b66a195e17b71c81df362b506af056b95e3e8015172bfb31380b8c"
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
