class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.47.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.47.0/lpm-darwin-arm64"
      sha256 "175cf6a0fd3994572e79706372f157c053f46cdeaa6b9459ba9b756a2706fbc7"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.47.0/lpm-darwin-x64"
      sha256 "403d9b79241f8271f9112bf2b6d701c108f2ddd16aae379b9c047a95e49ee17a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.47.0/lpm-linux-arm64"
      sha256 "a5c08da078375de042c32d6099d8ef299bd1bbc43fcd47a9f2eeb72e405ac357"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.47.0/lpm-linux-x64"
      sha256 "f5ee0051dd551f5c35a8977fe95334a969e597ed49bd15ac9278e1a0eee08127"
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
