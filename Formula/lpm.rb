class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.24.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.24.0/lpm-darwin-arm64"
      sha256 "3990aa979e3a3c653bdc973745b411427d0c91305d4fb65f9ffe758e5b536cab"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.24.0/lpm-darwin-x64"
      sha256 "baa5d0c8456eeda1ce43c3e6539b0428cfb12e8aec43615d2c45029a0a0e3381"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.24.0/lpm-linux-arm64"
      sha256 "efbb08cd6940a94aaadabec936428263b579a385e90ddd0bf0c9652742dfb59b"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.24.0/lpm-linux-x64"
      sha256 "8a73cf46e891e6b7f68440a51bc6b9515ab9dc53cdb95ec86ad4a3282031cf02"
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
