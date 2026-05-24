class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.46.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.46.0/lpm-darwin-arm64"
      sha256 "9fec214492cd127cf1ec3c7d7ccc54d2a872fb6715b4a8de32b42989d4504c6c"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.46.0/lpm-darwin-x64"
      sha256 "339f0921187ddd51d8081fe8ef746bf6a447db02f54a209db3e27ee9cfb76089"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.46.0/lpm-linux-arm64"
      sha256 "d626e2814c1191174a33b884416251ba6004f0146694c09c8c4082d644b0a4d8"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.46.0/lpm-linux-x64"
      sha256 "12db520d24465f72cc9f65b1ed3dbd1f6bcec63ebfa375ec68cfd9294a2d07ea"
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
