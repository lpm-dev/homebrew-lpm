class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.68.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-darwin-arm64"
      sha256 "7d6645f3e0ba0ac2d497cf3c03e6d371704c4f37768d22fcba2861ed5e151763"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-darwin-x64"
      sha256 "4fdb92da068f46c2227830943de83537ba318c2b656b3bdb8f61f1b893ffc8b9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-linux-arm64"
      sha256 "efba1b85489de119990adfc330548dec4547271c6e736d015c35b56d2a1e6f34"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-linux-x64"
      sha256 "981fc282108f4c396d4b5e040dfbf3468ae4021fafc2bcdab7fe2dd1bc474aa3"
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
