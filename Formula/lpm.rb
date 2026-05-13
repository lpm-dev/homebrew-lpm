class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.40.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.40.0/lpm-darwin-arm64"
      sha256 "f4182627ba29326344cb91c3fa3415120c0b852e7b13c9e3090604a8a95d3dbe"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.40.0/lpm-darwin-x64"
      sha256 "6484671120b788c48867f79f7633595b79caa038856c2332e424f2718b8446d6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.40.0/lpm-linux-arm64"
      sha256 "3d74fa2edd13c7c1e3111bf3ce22bfb6b7a659dc92dd48597546df8e390fcd17"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.40.0/lpm-linux-x64"
      sha256 "60a054b068735cbdaeb909911c098b696ac2d016911dd156835e2e055179cdbe"
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
