class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.5.0/lpm-darwin-arm64"
      sha256 "44b7bcb8927e7dc6228edeae148e8f4beea4f34c6989e786419209eee46eb00f"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.5.0/lpm-darwin-x64"
      sha256 "8f1cf5e83125c4b6bdd5f547595a1486c91ed275bd4e77cecc7c465baaa98954"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.5.0/lpm-linux-arm64"
      sha256 "79ef60a5d70939bc462ed80f89f1e9562b66d968ebd5165c3cfbe37c2dbb6ce2"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.5.0/lpm-linux-x64"
      sha256 "64c62365a7a379346d7a22acd9b062666aeb5c77e46a7b22b9c19156a6d6f60c"
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
