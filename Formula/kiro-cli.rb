class KiroCli < Formula
  desc "Kiro CLI — agentic AI development from the terminal"
  homepage "https://kiro.dev/cli/"
  version "3.1.0"
  url "https://desktop-release.q.us-east-1.amazonaws.com/#{version}/kirocli-x86_64-linux.tar.gz"
  sha256 "006835b2f4f433f55bb02601cd3053ccb10bd3d408478719c33d320f18e46ba5"

  def install
    # kiro-cli 3.0.0 consolidated the chat/term binaries into a single
    # kiro-cli executable (they are now subcommands), so only one binary ships.
    bin.install "bin/kiro-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiro-cli --version")
  end
end
