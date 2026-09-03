class KiroCli < Formula
  desc "Kiro CLI — agentic AI development from the terminal"
  homepage "https://kiro.dev/cli/"
  version "2.21.0"
  url "https://desktop-release.q.us-east-1.amazonaws.com/#{version}/kirocli-x86_64-linux.tar.gz"
  sha256 "d46c4821be2ef0664662a1ec8ec57f1a5444b184010f5252a45d325b76bd35fe"

  def install
    bin.install "bin/kiro-cli"
    bin.install "bin/kiro-cli-chat"
    bin.install "bin/kiro-cli-term"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiro-cli --version")
  end
end
