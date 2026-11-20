class KiroCli < Formula
  desc "Kiro CLI — agentic AI development from the terminal"
  homepage "https://kiro.dev/cli/"
  version "3.5.0"
  url "https://desktop-release.q.us-east-1.amazonaws.com/#{version}/kirocli-x86_64-linux.tar.gz"
  sha256 "98f016b746b342d8337a0e937cabecc381037e2e920ea0ffaae649e51ef59d4e"

  def install
    # kiro-cli 3.0.0 consolidated the chat/term binaries into a single
    # kiro-cli executable (they are now subcommands), so only one binary ships.
    bin.install "bin/kiro-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiro-cli --version")
  end
end
