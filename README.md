# Kiro — Linux Packages

Unofficial Linux packages for [Kiro IDE](https://kiro.dev/) and [Kiro CLI](https://kiro.dev/cli/).

Kiro officially provides a macOS Homebrew cask, a `.tar.gz` for Linux, and a CLI install script. This repo adds Homebrew formulae for Linuxbrew and an RPM spec for Fedora.

## Homebrew (Linuxbrew)

Works on standard Linux distros and immutable Fedora-based distros (Bazzite, Bluefin, Aurora, etc.) where `dnf install` is not available.

### Install

```bash
brew tap carlolagaac/kiro
brew install kiro          # Kiro IDE
brew install kiro-cli      # Kiro CLI (terminal agent)
```

### Upgrade

Update the `version` and `sha256` in the formula files, commit, push, then:

```bash
brew upgrade kiro
brew upgrade kiro-cli
```

## Fedora RPM (mutable Fedora only)

### Build

```bash
sudo dnf install rpm-build rpmdevtools
rpmdev-setuptree
cp kiro.spec ~/rpmbuild/SPECS/
spectool -g -R ~/rpmbuild/SPECS/kiro.spec
rpmbuild -bb ~/rpmbuild/SPECS/kiro.spec
```

### Install

```bash
sudo dnf install ~/rpmbuild/RPMS/x86_64/kiro-0.11.63-1.fc*.x86_64.rpm
```

Optionally, you can host the RPM in a [COPR](https://copr.fedorainfracloud.org/) repo for easier distribution.

## Updating to a new version

### Kiro IDE

Run the update script to automatically fetch the latest version and update `Formula/kiro.rb` and `kiro.spec`:

```bash
./update-kiro.sh
```

Or manually:

1. Check the latest version:
   ```bash
   curl -s https://prod.download.desktop.kiro.dev/stable/metadata-linux-x64-stable.json | python3 -c "import sys,json; print(json.load(sys.stdin)['currentRelease'])"
   ```

2. Download and get the new sha256:
   ```bash
   VERSION=<new-version>
   curl -sL "https://prod.download.desktop.kiro.dev/releases/stable/linux-x64/signed/${VERSION}/tar/kiro-ide-${VERSION}-stable-linux-x64.tar.gz" | sha256sum
   ```

3. Update `version` and `sha256` in both `Formula/kiro.rb` and `kiro.spec`.

### Kiro CLI

1. Check the latest version:
   ```bash
   curl -s https://desktop-release.q.us-east-1.amazonaws.com/latest/manifest.json | python3 -c "import sys,json; print(json.load(sys.stdin)['version'])"
   ```

2. Get the new sha256:
   ```bash
   VERSION=<new-version>
   curl -sL "https://desktop-release.q.us-east-1.amazonaws.com/${VERSION}/kirocli-x86_64-linux.tar.gz" | sha256sum
   ```

3. Update `version` and `sha256` in `Formula/kiro-cli.rb`.

## License

The packaging files in this repo are MIT. Kiro itself is proprietary — see [kiro.dev/license](https://kiro.dev/license/).
