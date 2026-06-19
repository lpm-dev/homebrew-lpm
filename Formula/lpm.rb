class Lpm < Formula
  desc "Fast package manager for lpm.dev — written in Rust"
  homepage "https://lpm.dev"
  license "MIT"
  version "0.62.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.62.0/lpm-darwin-arm64"
      sha256 "a6ed625c188da83bac9332c9adc196102612fd91e562f901de60a6d3afc98226"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.62.0/lpm-darwin-x64"
      sha256 "47e14f371e3ce6b725af4a5ae2c5b841ec168bda36add83ba8b42a28828f7086"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.62.0/lpm-linux-arm64"
      sha256 "504241a323518b471a9808531cd72bd291c64877e04fcc74165d095539673f7a"
    else
      url "https://github.com/lpm-dev/rust-client/releases/download/v0.62.0/lpm-linux-x64"
      sha256 "958ba53d86bfefcc242970f17c71956788d0169cfaedd58587a2bd3cf3882f4a"
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
