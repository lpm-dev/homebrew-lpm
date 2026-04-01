class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-darwin-arm64"
      sha256 "ede9067fc47ec6b370c38299daeffcaef5eb8048516622df06db08fe362b811d"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-darwin-x64"
      sha256 "7a1219becfa8f870d923b119d7e8c3a4d213975478ef357b7a1cf64be66e380f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-linux-arm64"
      sha256 "c1aba1d2b00d2005c3ef99713bbde5049c0670d7074299b557eabd44c9551bd6"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-linux-x64"
      sha256 "f6167c569c53018f83ed4451a3e34fe1f65a5be751d4cdb6e30578efb871914e"
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
