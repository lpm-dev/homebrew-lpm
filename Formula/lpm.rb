class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.8.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.8.0/lpm-darwin-arm64"
      sha256 "b5f15d0b628d94b79f0bd17c0f344bc371b5e851c33a4c5da5d823cb58793ecf"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.8.0/lpm-darwin-x64"
      sha256 "46af64d35ed1b07d76f7eda13f9887fb7281d3b80d3257ee314fc11d7b06e92e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.8.0/lpm-linux-arm64"
      sha256 "c5fe8afbad9ffa1b5c9a10c4f1561668b259f5a7857af70c05c7701ad5d6cd3b"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.8.0/lpm-linux-x64"
      sha256 "62fde56424d7ac23b7796e88eba51cc2eb26eb0f04242d77ba5f87ebeed4e434"
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
