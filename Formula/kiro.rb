class Kiro < Formula
  desc "Agent-centric IDE with spec-driven development"
  homepage "https://kiro.dev/"
  version "1.1.14"
  url "https://prod.download.desktop.kiro.dev/releases/stable/linux-x64/signed/#{version}/tar/kiro-ide-#{version}-stable-linux-x64.tar.gz"
  sha256 "9a827336407cf5028dcd34d5cd436fcca4b9599d6a90cf5cc38f9631e56d58fd"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"bin/kiro"
  end

  test do
    assert_match "kiro", shell_output("#{bin}/kiro --version", 1)
  end
end
