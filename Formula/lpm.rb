class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.68.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-darwin-arm64"
      sha256 "d796d6f08087c14538e6f6e8c14b97711306d1dc4be67e332257d1fdb3858ce7"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-darwin-x64"
      sha256 "0f7118246ab2e0a59976bbf1d115375695013424405baef1d633043c5f965126"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-linux-arm64"
      sha256 "a9a0e196b6fc1de49743594a7a934c330ea7637cc1402f414abf10e2f7d39a67"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.68.0/lpm-linux-x64"
      sha256 "7adbfa620c6cb26778a643e8a73f60d371a86ad330141a2959517e63a0d543ed"
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
