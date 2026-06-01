class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.51.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.51.0/lpm-darwin-arm64"
      sha256 "6617b5eca393ae75788ca27d33ca6491f335556f771cd41565381622e9e82e49"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.51.0/lpm-darwin-x64"
      sha256 "934ea23493b2c04f043974dc5ae15f072bfc86e379d6dd1f3d7386d812f2abc5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.51.0/lpm-linux-arm64"
      sha256 "aec25c51ad85cc6544e003c97b088c36ce395476c1c1a8fe73e8315012148777"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.51.0/lpm-linux-x64"
      sha256 "83335be2c6c69823fd237b89e28cf416d96aa33342da8b5589b1051def6b1a55"
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
