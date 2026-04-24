class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.25.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.25.0/lpm-darwin-arm64"
      sha256 "3f1c1f5c5c6226ede17c3d472e11b7cad638b788ab4399cf78d6a14eba844c1f"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.25.0/lpm-darwin-x64"
      sha256 "1547efe212bce11de96f7b054559ff2e1a5575b96884dfa86829d8b51a4a5ebf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.25.0/lpm-linux-arm64"
      sha256 "35b0793c3004dd119de89918154e525e5b5e86e5ab5cecf0f072ef90dc30fe53"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.25.0/lpm-linux-x64"
      sha256 "5a75b20c354e6d30e9a1d4c12556621cdd47745b76b65dcecaae992dd490096d"
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
