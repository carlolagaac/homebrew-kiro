%global debug_package %{nil}
%global __strip /bin/true

Name:           kiro
Version:        0.11.132
Release:        1%{?dist}
Summary:        Agent-centric IDE with spec-driven development
License:        Proprietary
URL:            https://kiro.dev/
Source0:        https://prod.download.desktop.kiro.dev/releases/stable/linux-x64/signed/%{version}/tar/kiro-ide-%{version}-stable-linux-x64.tar.gz

ExclusiveArch:  x86_64
AutoReqProv:    no

Requires:       gtk3
Requires:       libnotify
Requires:       nss
Requires:       libXScrnSaver
Requires:       alsa-lib
Requires:       libdrm
Requires:       mesa-libgbm

%description
Kiro is an agentic AI IDE that helps you go from prototype to production
with spec-driven development.

%prep
%setup -q -n Kiro

%install
install -d %{buildroot}/opt/%{name}
cp -a . %{buildroot}/opt/%{name}

install -d %{buildroot}%{_bindir}
ln -s /opt/%{name}/bin/kiro %{buildroot}%{_bindir}/%{name}

install -d %{buildroot}%{_datadir}/applications
cat > %{buildroot}%{_datadir}/applications/%{name}.desktop << 'EOF'
[Desktop Entry]
Name=Kiro
Comment=Agent-centric IDE with spec-driven development
Exec=/opt/kiro/kiro %F
Icon=kiro
Type=Application
StartupNotify=true
Categories=Development;IDE;
MimeType=text/plain;inode/directory;
StartupWMClass=Kiro
EOF

install -d %{buildroot}%{_datadir}/pixmaps
install -m 644 resources/app/resources/linux/code.png %{buildroot}%{_datadir}/pixmaps/%{name}.png

%files
/opt/%{name}
%{_bindir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/pixmaps/%{name}.png

%changelog
* Tue Mar 18 2026 Carlo <carlo@localhost> - 0.11.63-1
- Initial RPM package
