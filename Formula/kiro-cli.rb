class KiroCli < Formula
  desc "Kiro CLI — agentic AI development from the terminal"
  homepage "https://kiro.dev/cli/"
  version "3.2.0"
  url "https://desktop-release.q.us-east-1.amazonaws.com/#{version}/kirocli-x86_64-linux.tar.gz"
  sha256 "98a5c8b1fd8d46a4b96fc20ffef7ba6a0740772e725b77a641a2dde1a9bb8638"

  def install
    # kiro-cli 3.0.0 consolidated the chat/term binaries into a single
    # kiro-cli executable (they are now subcommands), so only one binary ships.
    bin.install "bin/kiro-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiro-cli --version")
  end
end
