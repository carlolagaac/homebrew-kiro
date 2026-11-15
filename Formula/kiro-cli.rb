class KiroCli < Formula
  desc "Kiro CLI — agentic AI development from the terminal"
  homepage "https://kiro.dev/cli/"
  version "3.3.0"
  url "https://desktop-release.q.us-east-1.amazonaws.com/#{version}/kirocli-x86_64-linux.tar.gz"
  sha256 "b88142aa02789504ac77fdf6ee829f0f4bdc9ce2e5dd0cc73084e105003c8fc3"

  def install
    # kiro-cli 3.0.0 consolidated the chat/term binaries into a single
    # kiro-cli executable (they are now subcommands), so only one binary ships.
    bin.install "bin/kiro-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiro-cli --version")
  end
end
