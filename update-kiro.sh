#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Fetching latest Kiro IDE version..."
VERSION=$(curl -s https://prod.download.desktop.kiro.dev/stable/metadata-linux-x64-stable.json | python3 -c "import sys,json; print(json.load(sys.stdin)['currentRelease'])")
echo "Latest version: $VERSION"

echo "Downloading tarball and computing sha256..."
SHA256=$(curl -sL "https://prod.download.desktop.kiro.dev/releases/stable/linux-x64/signed/${VERSION}/tar/kiro-ide-${VERSION}-stable-linux-x64.tar.gz" | sha256sum | awk '{print $1}')
echo "SHA256: $SHA256"

# Update Formula/kiro.rb
sed -i "s/^  version \".*\"/  version \"${VERSION}\"/" Formula/kiro.rb
sed -i "s/^  sha256 \".*\"/  sha256 \"${SHA256}\"/" Formula/kiro.rb

# Update kiro.spec
sed -i "s/^Version:        .*/Version:        ${VERSION}/" kiro.spec

echo "Updated Formula/kiro.rb and kiro.spec to version ${VERSION}"

echo ""
echo "Fetching latest Kiro CLI version..."
CLI_VERSION=$(curl -s https://desktop-release.q.us-east-1.amazonaws.com/latest/manifest.json | python3 -c "import sys,json; print(json.load(sys.stdin)['version'])")
echo "Latest version: $CLI_VERSION"

echo "Downloading tarball and computing sha256..."
CLI_SHA256=$(curl -sL "https://desktop-release.q.us-east-1.amazonaws.com/${CLI_VERSION}/kirocli-x86_64-linux.tar.gz" | sha256sum | awk '{print $1}')
echo "SHA256: $CLI_SHA256"

# Update Formula/kiro-cli.rb
sed -i "s/^  version \".*\"/  version \"${CLI_VERSION}\"/" Formula/kiro-cli.rb
sed -i "s/^  sha256 \".*\"/  sha256 \"${CLI_SHA256}\"/" Formula/kiro-cli.rb

echo "Updated Formula/kiro-cli.rb to version ${CLI_VERSION}"
