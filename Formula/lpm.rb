class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.42.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.42.0/lpm-darwin-arm64"
      sha256 "eda81b0610327825a7d4d5509bfac9b1f14f8774d67da4f48d597e4396fb01c4"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.42.0/lpm-darwin-x64"
      sha256 "f3f7c5bc910330f784b608e5dcb93ddde84f16d0f8538e906945e847523c600c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.42.0/lpm-linux-arm64"
      sha256 "a12f3e2a0b30b66b4ba647fea7a559e126987b8270edf2b589ada0c273a8bc24"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.42.0/lpm-linux-x64"
      sha256 "0fd01b6eb26f0ed61c83a1ce134a2d851eabaa02e7eebe6af9f1e0d8c381a236"
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
