class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.39.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.39.0/lpm-darwin-arm64"
      sha256 "3e8d89311dd997f33735cffe238a47e825eae1e902288120f0fa6bf8809c079a"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.39.0/lpm-darwin-x64"
      sha256 "139e3e7703c4c912e85edb9163621401ee3bb563e40237c37a61ce4828aad5e1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.39.0/lpm-linux-arm64"
      sha256 "1bd9f2bd9f4c4796fced45768c25651b887dfe9c11fd9a98c041c5a458230901"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.39.0/lpm-linux-x64"
      sha256 "9d3a87934d46169a11539687ef59823f4c2c872b9bc62c2d2bf6433e5dd9fd9d"
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
