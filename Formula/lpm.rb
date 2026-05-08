class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.37.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.37.0/lpm-darwin-arm64"
      sha256 "36bb34a669cbb1adbb8ece9c964b8d23c698394cf38bf3d401509180c656b7f1"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.37.0/lpm-darwin-x64"
      sha256 "7d9fae561e249eb12a0ed4ff7dc2684b8410eef6671e52e097ed4917f9e7347a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.37.0/lpm-linux-arm64"
      sha256 "2b390907f405391f36579dd723f2c8878ac88ddecd6a2bd42a1aea903c35c1f7"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.37.0/lpm-linux-x64"
      sha256 "73c1885575ade1a9a7f65fa0605dd723bfb36157298ce1250ed4bc1952026349"
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
