class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.9.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.2/lpm-darwin-arm64"
      sha256 "12e1fdd007db3cb171898a3871c195b1506088d0b87380dfebe02fff62481e40"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.2/lpm-darwin-x64"
      sha256 "e3d522dea56ca23754c80256faea1217b0f5d195ae2e36f4bd59998a53a780b7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.2/lpm-linux-arm64"
      sha256 "133d100a1c652463bc52d17cb7081699f978ad3872b6b2067df03eb0018e0b8b"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.9.2/lpm-linux-x64"
      sha256 "2fe839d0ca87b0b057facb42df0298cc960e51bfc322c1581446e856e76bd167"
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
