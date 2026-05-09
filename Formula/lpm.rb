class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.38.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.38.0/lpm-darwin-arm64"
      sha256 "85d7baf751160b8d5d157a58079c1b19413a89e7fed9f0d2d64d4e4e9c587ebd"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.38.0/lpm-darwin-x64"
      sha256 "b37530485225b230ab72153b974e16ad9dafab5d8ba9f1ffcc39c8a378ba5420"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.38.0/lpm-linux-arm64"
      sha256 "4a9f55077c57df26b5e08e3c822f8cee6c5509c57d00141307f8bb794b2c476b"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.38.0/lpm-linux-x64"
      sha256 "94106268c5ca9181dc06240ca71957d713d56a5994672a9404f85fbe1c51e106"
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
