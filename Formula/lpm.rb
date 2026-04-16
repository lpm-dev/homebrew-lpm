class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.18.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.18.0/lpm-darwin-arm64"
      sha256 "38d1fffebcb58ab7b69dccae99906cff5615ac1678906fef9d0ce6315952994b"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.18.0/lpm-darwin-x64"
      sha256 "98d50686d73fc0c12ed07e3154f2132f4a2e4c4b7a4221020faafb4b13071bd3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.18.0/lpm-linux-arm64"
      sha256 "78ffb1c11b395b8eb627b82d18926ffe9921b9f9e0b5a494c7134c7ffcbbf024"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.18.0/lpm-linux-x64"
      sha256 "034c7f70065c51cfbee9e77de93a10d6946d59b3b374a8ae06d51eb69de4a528"
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
