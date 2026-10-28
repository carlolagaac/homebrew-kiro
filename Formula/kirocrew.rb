class Kirocrew < Formula
  desc "Persistent AI workspace that self-improves and continues beyond one session"
  homepage "https://github.com/kirodotdev/KiroCrew"
  version "0.10.0"
  url "https://github.com/kirodotdev/KiroCrew/releases/download/v#{version}/KiroCrew-#{version}-x86_64.AppImage"
  sha256 "094df999ae787bcb2ee63165d5a4808cfec7c5591c034de914cc011942ef4915"
  license "Apache-2.0"

  depends_on :linux

  def install
    bin.install "KiroCrew-x86_64.AppImage" => "kirocrew-desktop"
    chmod 0755, bin/"kirocrew-desktop"
  end

  def caveats
    <<~EOS
      KiroCrew Desktop is installed as an AppImage.

      Run it with:
        kirocrew-desktop

      On first launch it will install kiro-cli if needed and guide
      Kiro device-code sign-in. The web dashboard opens at
      http://localhost:5476.

      If FUSE is not available (e.g., on Bazzite/immutable Fedora),
      extract and run with:
        kirocrew-desktop --appimage-extract-and-run

      For the CLI-only install (no desktop app), use:
        curl -fsSL https://download.crew.kiro.dev/cli.sh | sh
    EOS
  end

  test do
    assert_predicate bin/"kirocrew-desktop", :exist?
    assert_predicate bin/"kirocrew-desktop", :executable?
  end
end
