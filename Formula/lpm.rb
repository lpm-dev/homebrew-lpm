class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-darwin-arm64"
      sha256 "4f12756588a49c75ced9129f920b6dc38fbbba783ba0d090b93ae451f1380afa"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-darwin-x64"
      sha256 "116be54dd6b8f6f1ccf17d26aa0a164441415796c4b10aef0e718ddc596d3ee2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-linux-arm64"
      sha256 "397be6f1cca835e45526e390cace5b112be94489cf9601c803ed5df05ea87d47"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-linux-x64"
      sha256 "7c98edf466ef254e9c8fb33a48d36394cfc679490e63ce703f9ccc8dbd22d1c4"
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
