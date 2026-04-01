class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-darwin-arm64"
      sha256 "9e77d9467fbab7e85de26dcc726375d25d4ee9c44d17e7e1f236b22f45814c52"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-darwin-x64"
      sha256 "31876bed9dd32d91c882b2a59bb7488f9bb900ec4aefe5efdac9166cfe0db8e7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-linux-arm64"
      sha256 "12a4a56273bc60b4fb03500ee927c8526e7670e63bdbf066eed68f626cff56fb"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.6.0/lpm-linux-x64"
      sha256 "01a7fbfc48c97608df2128665de8b0f8dc37724ad6206eeb019dabd5067bc233"
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
