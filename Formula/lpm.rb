class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.60.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.60.0/lpm-darwin-arm64"
      sha256 "41dcaf171cb8f13a31e34d71b6e349cf24a3c2cf0e83e7a4c9f69a8ed5f37c85"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.60.0/lpm-darwin-x64"
      sha256 "138558b1f303d533f4de401c1c79e1cf02cf517771a391fb6ee7f53994c9be61"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.60.0/lpm-linux-arm64"
      sha256 "d370cb4c92e69208979552b90b1025dfbf48e336e79354ec0a0096b939736b78"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.60.0/lpm-linux-x64"
      sha256 "da3607b5ea5aa908ea5ace64ab62e837653032fdbcaddb85a623b90ca0a3b5a3"
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
