class Kiro < Formula
  desc "Agent-centric IDE with spec-driven development"
  homepage "https://kiro.dev/"
  version "0.12.155"
  url "https://prod.download.desktop.kiro.dev/releases/stable/linux-x64/signed/#{version}/tar/kiro-ide-#{version}-stable-linux-x64.tar.gz"
  sha256 "1c998494222c79e2dd18738536d683ab2a5836a0067cf02b75d601313694cdb6"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"bin/kiro"
  end

  test do
    assert_match "kiro", shell_output("#{bin}/kiro --version", 1)
  end
end
