class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.43.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.43.0/lpm-darwin-arm64"
      sha256 "4c970b1c2a96e3d9e8553f9ee6aa52760f03c68da87940b771c2577f127b638e"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.43.0/lpm-darwin-x64"
      sha256 "78851b9dc19ed46e0e623e6c5cd782d5498a649862ce0fb1afafd9557d2718f9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.43.0/lpm-linux-arm64"
      sha256 "bbbde8920c93441e274ae13da8c3414abc64e8e28219e2b4d90867b158222ead"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.43.0/lpm-linux-x64"
      sha256 "08f7b2657b102e9eda638428d6df8b874b688307f668166d029447ccbbabcde8"
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
