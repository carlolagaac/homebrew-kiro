class Kirocrew < Formula
  desc "Persistent AI workspace that self-improves and continues beyond one session"
  homepage "https://github.com/kirodotdev/KiroCrew"
  version "0.1.3"
  url "https://download.crew.kiro.dev/desktop/stable/latest/KiroCrew-x86_64.AppImage"
  sha256 "230e724a885fbd98ccb2b5552a195533fd7108182fcc15b71ba16cae0d0f0b57"
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
