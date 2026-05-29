class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.49.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.49.0/lpm-darwin-arm64"
      sha256 "b4afcee86f4b5cf7ba62b32dfca34cff171ea45839a651dbbbbb4b20e40cd113"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.49.0/lpm-darwin-x64"
      sha256 "eb82e0a0b1a6c50763593107619cf79bb1321fda81dbdbc9fdaee55cbbee654e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.49.0/lpm-linux-arm64"
      sha256 "f5ee73f44533cc08c492ce2953177bcf97c0e0de34629aec6f9666460bfbfdcf"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.49.0/lpm-linux-x64"
      sha256 "e3227d5b29ef9f03ee8062de058c5fccf06c743e3a88954d7bcd2579652e4736"
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
