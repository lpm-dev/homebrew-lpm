class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.53.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.53.0/lpm-darwin-arm64"
      sha256 "b2897d7996528a6fd33df43f633408d37c8f19392c54286ae129b369b3c8160a"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.53.0/lpm-darwin-x64"
      sha256 "ebf30df3705c4724b86c92569ff7c8264f65d03ea0fcd71f509f312ea0a0b13a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.53.0/lpm-linux-arm64"
      sha256 "f4469e916969376cde55803f64a7531603fd400e3fee1711ed99f51d4b51b570"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.53.0/lpm-linux-x64"
      sha256 "99c01467ffae0bd66b60e73fc1271ca71987e122d501c721451802ab5a5f43fe"
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
