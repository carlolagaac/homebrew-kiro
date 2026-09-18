class KiroCli < Formula
  desc "Kiro CLI — agentic AI development from the terminal"
  homepage "https://kiro.dev/cli/"
  version "2.22.1"
  url "https://desktop-release.q.us-east-1.amazonaws.com/#{version}/kirocli-x86_64-linux.tar.gz"
  sha256 "02b060b989d011519c8eaacf460e28e918efd106df8c75ceb7f9c0aaed80f2fe"

  def install
    bin.install "bin/kiro-cli"
    bin.install "bin/kiro-cli-chat"
    bin.install "bin/kiro-cli-term"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiro-cli --version")
  end
end
