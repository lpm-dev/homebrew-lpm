class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.16.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.16.0/lpm-darwin-arm64"
      sha256 "1b521f944f4f22552988b1eb8733f0f97fe245f3de3a40ff4237b724a061a0a7"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.16.0/lpm-darwin-x64"
      sha256 "bbde0d1401ff4a0b55f2de34541a81b9b0cc03eaf1be70a23f109eea88901416"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.16.0/lpm-linux-arm64"
      sha256 "03398bd569c716915eb91aef95f84d253a605dc336b6757de139bc12dba99fb3"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.16.0/lpm-linux-x64"
      sha256 "a1c06424fd94e21bdc382c0c0a5a5ede845d05534c29364459049f496cef08b2"
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
