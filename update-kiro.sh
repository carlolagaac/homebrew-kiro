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
