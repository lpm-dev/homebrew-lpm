class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.32.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.32.0/lpm-darwin-arm64"
      sha256 "89a5fd71521dce1daf0ff7d3dda53cd1e094dc5ed6f83b55479b10ebf40ecb4e"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.32.0/lpm-darwin-x64"
      sha256 "53061197f1b1677fece1d50a5d1d5a05623d2e913a60a4381a6fefe64ab5dcf6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.32.0/lpm-linux-arm64"
      sha256 "30e850b8a0f4b865c731105372dfa9b7fdcffb2b4a349f7a90df85959a307e94"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.32.0/lpm-linux-x64"
      sha256 "0b3bda0378b7a7817a6fbfd4b656cd3039438b9c269e3b7c4f7bdc12c57d0633"
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
