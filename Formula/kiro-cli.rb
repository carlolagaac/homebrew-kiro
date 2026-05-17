class KiroCli < Formula
  desc "Kiro CLI — agentic AI development from the terminal"
  homepage "https://kiro.dev/cli/"
  version "2.3.0"
  url "https://desktop-release.q.us-east-1.amazonaws.com/#{version}/kirocli-x86_64-linux.tar.gz"
  sha256 "ccb8b32bfd26f4f748ccde0832272aefff799566a18fbb1d2f3104629bffa3e1"

  def install
    bin.install "bin/kiro-cli"
    bin.install "bin/kiro-cli-chat"
    bin.install "bin/kiro-cli-term"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiro-cli --version")
  end
end
