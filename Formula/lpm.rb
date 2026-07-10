class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.67.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.67.0/lpm-darwin-arm64"
      sha256 "4d7a590e534fb0980c08184ddeeff7adf19ecdd3ad68630970851cc3190d2149"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.67.0/lpm-darwin-x64"
      sha256 "e14dfd7356473bc2665b433da4dd7c5ec63817c89abe87360bf8ef606add1e70"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.67.0/lpm-linux-arm64"
      sha256 "46ae3acdd5306a4e36e6f396e5c7e8072367cec0dd9d03f890ca8f83e4465ce9"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.67.0/lpm-linux-x64"
      sha256 "fe2294105cdfcf56b675442ece901a4f1ff9d1497c9ed0fb2b207be8a57dcd8b"
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
