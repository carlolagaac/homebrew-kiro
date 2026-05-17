class Kiro < Formula
  desc "Agent-centric IDE with spec-driven development"
  homepage "https://kiro.dev/"
  version "0.12.200"
  url "https://prod.download.desktop.kiro.dev/releases/stable/linux-x64/signed/#{version}/tar/kiro-ide-#{version}-stable-linux-x64.tar.gz"
  sha256 "f4e10c67b1688c8c89b8707010f3d809b83aa63b438c0a3947ab0527a3fc49ba"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"bin/kiro"
  end

  test do
    assert_match "kiro", shell_output("#{bin}/kiro --version", 1)
  end
end
