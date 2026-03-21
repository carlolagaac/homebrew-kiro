class Kiro < Formula
  desc "Agent-centric IDE with spec-driven development"
  homepage "https://kiro.dev/"
  version "0.11.63"
  url "https://prod.download.desktop.kiro.dev/releases/stable/linux-x64/signed/#{version}/tar/kiro-ide-#{version}-stable-linux-x64.tar.gz"
  sha256 "639c82dbc86a566e6b0bf4f3d721cb524f4d3047ac2d0a79bd879de2da7f00fe"

  def install
    libexec.install Dir["Kiro/*"]
    bin.write_exec_script libexec/"bin/kiro"
  end

  test do
    assert_match "kiro", shell_output("#{bin}/kiro --version", 1)
  end
end
