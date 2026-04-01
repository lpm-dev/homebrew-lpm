class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-darwin-arm64"
      sha256 "ce97027820d7bef9484a4835a8077e60035478de908dce2f4183e8682fce7884"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-darwin-x64"
      sha256 "77b654f5da8e3def4b4272d16ff8d7e7cfd27c5ee11746c7b09b47f989edfb68"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-linux-arm64"
      sha256 "67c908cce7f28e738210fedc127ee7d84360895a190e52d1aa3172944c40106f"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-linux-x64"
      sha256 "57a9585688f7ef7f934c8d9e181ae5c16becc5044442a74477e271a2df27e99d"
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
