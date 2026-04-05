class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.9.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.1/lpm-darwin-arm64"
      sha256 "d95b3a68449cda94550d6b24d322e68355da102146321a268b343034a9e3bdba"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.1/lpm-darwin-x64"
      sha256 "774c4a3d911084f85dd98458e44f6f59716123b44968d38bc15a7d512022f570"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.1/lpm-linux-arm64"
      sha256 "5b9e8ebc1551edc84e580b759e55df29d67af6fbcbdca77d9e6fb867285b12df"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.1/lpm-linux-x64"
      sha256 "eb1b298ccf14d97ba02cf0db18f227058ec0221bef1f6427318d1586341ebb47"
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
