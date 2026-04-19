class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.21.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.21.0/lpm-darwin-arm64"
      sha256 "4674c3912ef684c4a7f9fe185b2e5082e2116dcb773d5af877dd54d54078bfde"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.21.0/lpm-darwin-x64"
      sha256 "dbf36dc5db18da0450d3ef253db331b0010f79112f68e8930a45b0e88e0d4a34"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.21.0/lpm-linux-arm64"
      sha256 "2404c23d28b79d87f65457fd52000c6252e6cb1555037ea77dcce965d992a822"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.21.0/lpm-linux-x64"
      sha256 "759c80885233b0f0ea533a5e8652dde991ee8bd7f2d503eb910fb0f7fd758434"
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
