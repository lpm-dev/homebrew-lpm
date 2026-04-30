class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.29.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.29.0/lpm-darwin-arm64"
      sha256 "44e74bfc1dcaddbb783ed070961f8600d526c02c45bb67372529054f175a80f2"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.29.0/lpm-darwin-x64"
      sha256 "a534141fc379db3d90e0be7a4261b8a6311aa284387c638a91d2876882c5b592"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.29.0/lpm-linux-arm64"
      sha256 "0092045739c831e76b94867a76281c3f78105e25711f5e531cf47137a32c7ac2"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.29.0/lpm-linux-x64"
      sha256 "ad480dc449c176e85a402a597669187640d275af45642eddafaa73c8222a5472"
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
