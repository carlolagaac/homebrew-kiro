class KiroCli < Formula
  desc "Kiro CLI — agentic AI development from the terminal"
  homepage "https://kiro.dev/cli/"
  version "2.2.2"
  url "https://desktop-release.q.us-east-1.amazonaws.com/#{version}/kirocli-x86_64-linux.tar.gz"
  sha256 "414f1a90363456b34cadcc2e4091d9214889ac29e3633b219ac6aabe2634f8f6"

  def install
    bin.install "bin/kiro-cli"
    bin.install "bin/kiro-cli-chat"
    bin.install "bin/kiro-cli-term"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiro-cli --version")
  end
end
