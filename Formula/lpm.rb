class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.74.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.74.1/lpm-darwin-arm64"
      sha256 "fdc72b0ab79ca78012e08f08792e32fb51210e303c81b891d940e5d259d19bf6"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.74.1/lpm-darwin-x64"
      sha256 "15e21f420644459653fc1402fbe01b6a60678a53e46ea8fd911e60db38df10ed"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.74.1/lpm-linux-arm64"
      sha256 "9221da4594608c4693fe9a128dfd8a906b23202ea0e807a5431be6e62b555f24"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.74.1/lpm-linux-x64"
      sha256 "d4edd1f3ed3d847e5ba6cde7b1846da2f09f2c5bbd7b08cd89929962a7fd6cf2"
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
