class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.58.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.58.0/lpm-darwin-arm64"
      sha256 "277d7bd75471385bb67e8d39bc51a020c0719d512b2885e39b787ef0a9fe5abd"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.58.0/lpm-darwin-x64"
      sha256 "f75931494c04926a031dd175901f4a85aca82d982685d4298f2578e3ba978f09"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.58.0/lpm-linux-arm64"
      sha256 "2cbea31790e802b78389ea9141a43de9f86ee13ab1d16f230f38c74008f20b2f"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.58.0/lpm-linux-x64"
      sha256 "cc55ac181b8337f0bc3537d9fb4f48bf8c7c46cbfd0be83a3377ee74de9c5f95"
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
