class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v#{version}/lpm-darwin-arm64"
      sha256 "PLACEHOLDER_ARM64"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v#{version}/lpm-darwin-x64"
      sha256 "PLACEHOLDER_X64"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v#{version}/lpm-linux-arm64"
      sha256 "PLACEHOLDER_LINUX_ARM64"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v#{version}/lpm-linux-x64"
      sha256 "PLACEHOLDER_LINUX_X64"
    end
  end

  def install
    binary = Dir.glob("lpm-*").first || "lpm-#{OS.kernel_name.downcase}-#{Hardware::CPU.arch == :arm64 ? "arm64" : "x64"}"
    bin.install binary => "lpm"
  end

  test do
    assert_match "lpm-rs", shell_output("#{bin}/lpm --version 2>&1", 0)
  end
end
