class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-darwin-arm64"
      sha256 "b600ce44e07fdcfa9d17c404db20d38f00a7ebc8d53dc565e58ee8dffd3e7282"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-darwin-x64"
      sha256 "b0fa789bf8e7da09424a765f9d9200ff2a2fa03eb7e5f3796a373eec10bec982"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-linux-arm64"
      sha256 "392ce05243e72bb253117c6105935e6b11ab4fc9975617aa1a6cf28dcd8e535b"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.7.0/lpm-linux-x64"
      sha256 "d6e8c7afdf123f620c01ab4b6a52ad95ad2bb49aae2db6c811c10c57cf1174f6"
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
