class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.55.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.55.0/lpm-darwin-arm64"
      sha256 "12e15ae278beafe69eceef7dececaf1a7cc735f8f39515a871c846717687a651"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.55.0/lpm-darwin-x64"
      sha256 "833cbdb2f588dfc2679132dc318d6f27758cf9a6d2f6aba41c2bd003bc6e85c2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.55.0/lpm-linux-arm64"
      sha256 "0b24b06321e0eeaef4791a32d5d803e4723e46b545a69ae7c6e47d7b02f8537a"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.55.0/lpm-linux-x64"
      sha256 "0de7863aa03661abe4f10cef6291b060680ab309ca5dd342e8067e18f3468879"
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
