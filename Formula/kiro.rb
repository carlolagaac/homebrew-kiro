class Kiro < Formula
  desc "Agent-centric IDE with spec-driven development"
  homepage "https://kiro.dev/"
  version "1.0.437"
  url "https://prod.download.desktop.kiro.dev/releases/stable/linux-x64/signed/#{version}/tar/kiro-ide-#{version}-stable-linux-x64.tar.gz"
  sha256 "161dffbd04eab359cf708c467977f7f304814a9ecbbefa8bc46838697255ac24"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"bin/kiro"
  end

  test do
    assert_match "kiro", shell_output("#{bin}/kiro --version", 1)
  end
end
