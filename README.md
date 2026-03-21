# Kiro IDE — Linux Packages

Unofficial Linux packages for [Kiro](https://kiro.dev/), the agent-centric IDE with spec-driven development.

Kiro officially provides a macOS Homebrew cask and a `.tar.gz` for Linux. This repo adds a Homebrew formula for Linuxbrew and an RPM spec for Fedora.

## Homebrew (Linuxbrew)

### Setup

Create a [Homebrew tap](https://docs.brew.sh/Taps) so you can install with `brew install`:

```bash
# Create a new repo named "homebrew-kiro" on GitHub under your account.
# The repo name MUST start with "homebrew-" for taps to work.
#
# Then structure it as:
#   homebrew-kiro/
#   └── Formula/
#       └── kiro.rb
```

Push the formula:

```bash
mkdir -p Formula
cp kiro.rb Formula/
git init
git remote add origin git@github.com:<your-username>/homebrew-kiro.git
git add .
git commit -m "Add kiro formula 0.11.63"
git push -u origin main
```

### Install

```bash
brew tap <your-username>/kiro
brew install kiro
```

### Upgrade

Update the `version` and `sha256` in `Formula/kiro.rb`, commit, push, then:

```bash
brew upgrade kiro
```

## Fedora RPM

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

1. Check the latest version:
   ```bash
   curl -s https://prod.download.desktop.kiro.dev/stable/metadata-linux-x64-stable.json | python3 -c "import sys,json; print(json.load(sys.stdin)['currentRelease'])"
   ```

2. Download and get the new sha256:
   ```bash
   VERSION=<new-version>
   curl -sL "https://prod.download.desktop.kiro.dev/releases/stable/linux-x64/signed/${VERSION}/tar/kiro-ide-${VERSION}-stable-linux-x64.tar.gz" | sha256sum
   ```

3. Update `version` and `sha256` in both `kiro.rb` and `kiro.spec`.

## License

The packaging files in this repo are MIT. Kiro itself is proprietary — see [kiro.dev/license](https://kiro.dev/license/).
