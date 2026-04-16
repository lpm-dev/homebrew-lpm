class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.17.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.17.1/lpm-darwin-arm64"
      sha256 "92366af7e81c35f971ef81ddc73d403efec89033cffdee7837a90b95703d5125"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.17.1/lpm-darwin-x64"
      sha256 "c18c10ea30b8313aa4dc00b279e795e721944bde026084bd9038364b2227a044"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.17.1/lpm-linux-arm64"
      sha256 "f8646845550d0046f5ec18ba51d6d085d0289ee705a8e780828765d08b42406c"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.17.1/lpm-linux-x64"
      sha256 "fb8f4937a78bc3cef566a8fd2c951d9dc1f2f46a8100efeac7d255441f92e4c4"
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
