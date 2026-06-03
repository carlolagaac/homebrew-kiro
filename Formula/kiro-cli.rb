class KiroCli < Formula
  desc "Kiro CLI — agentic AI development from the terminal"
  homepage "https://kiro.dev/cli/"
  version "2.5.1"
  url "https://desktop-release.q.us-east-1.amazonaws.com/#{version}/kirocli-x86_64-linux.tar.gz"
  sha256 "865dd2788b6c277b805ed65ea0121258902b79f5df28198b8339a758a6155f1c"

  def install
    bin.install "bin/kiro-cli"
    bin.install "bin/kiro-cli-chat"
    bin.install "bin/kiro-cli-term"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiro-cli --version")
  end
end
