class Kirocrew < Formula
  desc "Persistent AI workspace that self-improves and continues beyond one session"
  homepage "https://github.com/kirodotdev/KiroCrew"
  version "0.12.2"
  url "https://github.com/kirodotdev/KiroCrew/releases/download/v#{version}/KiroCrew-#{version}-x86_64.AppImage"
  sha256 "10fc90f0d0b23a71295d5af2bcb83646ab89954791a4980e1fc3f520276b4b7f"
  license "Apache-2.0"

  depends_on :linux

  def install
    libexec.install "KiroCrew-#{version}-x86_64.AppImage" => "KiroCrew.AppImage"
    chmod 0755, libexec/"KiroCrew.AppImage"

    # Wrapper: stable entry point for terminals, launchers and the dock.
    # - adds linuxbrew to PATH (GUI sessions don't source /etc/profile.d/brew.sh,
    #   so spawned sessions otherwise can't find kiro-cli)
    # - runs the AppImage with --appimage-extract-and-run unless an explicit
    #   --appimage-* flag is given (FUSE is unavailable on Bazzite/immutable Fedora)
    (bin/"kirocrew-desktop").write <<~SH
      #!/bin/sh
      export PATH="#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/sbin:$PATH"
      appimage="#{opt_libexec}/KiroCrew.AppImage"
      case "$1" in
        --appimage-*) exec "$appimage" "$@" ;;
        *) exec "$appimage" --appimage-extract-and-run "$@" ;;
      esac
    SH
    chmod 0755, bin/"kirocrew-desktop"

    (share/"applications").mkpath
    (share/"applications/kirocrew-desktop.desktop").write <<~DESKTOP
      [Desktop Entry]
      Name=KiroCrew
      Comment=Kiro Crew - AI agent desktop app
      Exec=#{opt_bin}/kirocrew-desktop
      Terminal=false
      Type=Application
      Icon=kirocrew-desktop
      StartupWMClass=kirocrew-desktop
      Categories=Development;
      Keywords=kiro;ai;agent;crew;
    DESKTOP
  end

  def caveats
    <<~EOS
      KiroCrew Desktop is installed as an AppImage.

      Run it with:
        kirocrew-desktop

      On first launch it will install kiro-cli if needed and guide
      Kiro device-code sign-in. The web dashboard opens at
      http://localhost:5476.

      The kirocrew-desktop wrapper already passes --appimage-extract-and-run
      (needed on Bazzite/immutable Fedora where FUSE is unavailable) and
      adds Homebrew to PATH so sessions can find kiro-cli.

      To add the app-menu / dock launcher (one time, survives upgrades):
        mkdir -p ~/.local/share/applications
        ln -sf #{opt_share}/applications/kirocrew-desktop.desktop \\
          ~/.local/share/applications/kirocrew-desktop.desktop
        update-desktop-database ~/.local/share/applications

      For the CLI-only install (no desktop app), use:
        curl -fsSL https://download.crew.kiro.dev/cli.sh | sh
    EOS
  end

  test do
    assert_predicate bin/"kirocrew-desktop", :exist?
    assert_predicate bin/"kirocrew-desktop", :executable?
    assert_predicate libexec/"KiroCrew.AppImage", :executable?
    assert_match "--appimage-extract-and-run", (bin/"kirocrew-desktop").read
    assert_match "Exec=#{opt_bin}/kirocrew-desktop", (share/"applications/kirocrew-desktop.desktop").read
  end
end
