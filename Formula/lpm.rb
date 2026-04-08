class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.12.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.12.0/lpm-darwin-arm64"
      sha256 "a55eeace23b5bad1a036cce91b98630962211531d64b29634525ad7ba2c77a7e"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.12.0/lpm-darwin-x64"
      sha256 "81eb5d7ef1f21746ba7f8e4f1111942e115899f162c3b2b72def61fbc98811e5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.12.0/lpm-linux-arm64"
      sha256 "a5732c5c50379ff111ea8668830a53082c914d94be0d29d08336d0c5eb43b328"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.12.0/lpm-linux-x64"
      sha256 "e704ffbbebb30cad1e69dfc006b297702acbe2a6c75a09a4b95a0ab3e47b5844"
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
