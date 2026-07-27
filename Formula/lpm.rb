class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.70.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.70.0/lpm-darwin-arm64"
      sha256 "b778c2ca762da8128cf43d6f3b67407cde1a8eea38380070dc20cde14f0e8fc8"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.70.0/lpm-darwin-x64"
      sha256 "4061332a2c87860c8384e8290029c5d62e8a33efed519f1e53b4bcbdad26576c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.70.0/lpm-linux-arm64"
      sha256 "577a653bc63a421bb3cb52a23665e27aa11ebebd34f05d393bee76187a424bfc"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.70.0/lpm-linux-x64"
      sha256 "0f4dedc98f25d4b8a3d85d9527edf6872210478a6b523a6f57bb9da2dd647be6"
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
