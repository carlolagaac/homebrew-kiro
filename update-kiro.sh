#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if sed --version &>/dev/null; then
  sedi() { sed -i "$@"; }
else
  sedi() { sed -i '' "$@"; }
fi

if command -v sha256sum &>/dev/null; then
  sha256cmd() { sha256sum | awk '{print $1}'; }
else
  sha256cmd() { shasum -a 256 | awk '{print $1}'; }
fi

KIRO_UPDATED=""
CLI_UPDATED=""
CREW_UPDATED=""

echo "Fetching latest Kiro IDE version..."
VERSION=$(curl -s https://prod.download.desktop.kiro.dev/stable/metadata-linux-x64-stable.json | python3 -c "import sys,json; print(json.load(sys.stdin)['currentRelease'])")
echo "Latest version: $VERSION"

CURRENT_SHA256=$(grep 'sha256 "' Formula/kiro.rb | sed 's/.*sha256 "//;s/"//')

echo "Downloading tarball and computing sha256..."
SHA256=$(curl -sL "https://prod.download.desktop.kiro.dev/releases/stable/linux-x64/signed/${VERSION}/tar/kiro-ide-${VERSION}-stable-linux-x64.tar.gz" | sha256cmd)
echo "SHA256: $SHA256"

if [ "$SHA256" = "$CURRENT_SHA256" ]; then
  echo "Formula/kiro.rb is already up to date."
else
  sedi "s/^  version \".*\"/  version \"${VERSION}\"/" Formula/kiro.rb
  sedi "s/^  sha256 \".*\"/  sha256 \"${SHA256}\"/" Formula/kiro.rb
  sedi "s/^Version:        .*/Version:        ${VERSION}/" kiro.spec
  echo "Updated Formula/kiro.rb and kiro.spec to version ${VERSION}"
  KIRO_UPDATED="$VERSION"
fi

echo ""
echo "Fetching latest Kiro CLI version..."
CLI_VERSION=$(curl -s https://desktop-release.q.us-east-1.amazonaws.com/latest/manifest.json | python3 -c "import sys,json; print(json.load(sys.stdin)['version'])")
echo "Latest version: $CLI_VERSION"

CURRENT_CLI_SHA256=$(grep 'sha256 "' Formula/kiro-cli.rb | sed 's/.*sha256 "//;s/"//')

echo "Downloading tarball and computing sha256..."
CLI_SHA256=$(curl -sL "https://desktop-release.q.us-east-1.amazonaws.com/${CLI_VERSION}/kirocli-x86_64-linux.tar.gz" | sha256cmd)
echo "SHA256: $CLI_SHA256"

if [ "$CLI_SHA256" = "$CURRENT_CLI_SHA256" ]; then
  echo "Formula/kiro-cli.rb is already up to date."
else
  sedi "s/^  version \".*\"/  version \"${CLI_VERSION}\"/" Formula/kiro-cli.rb
  sedi "s/^  sha256 \".*\"/  sha256 \"${CLI_SHA256}\"/" Formula/kiro-cli.rb
  echo "Updated Formula/kiro-cli.rb to version ${CLI_VERSION}"
  CLI_UPDATED="$CLI_VERSION"
fi

echo ""
echo "Fetching latest KiroCrew version..."
CREW_CURRENT_SHA256=$(grep 'sha256 "' Formula/kirocrew.rb | sed 's/.*sha256 "//;s/"//')

echo "Downloading AppImage and computing sha256..."
CREW_SHA256=$(curl -sL "https://download.crew.kiro.dev/desktop/stable/latest/KiroCrew-x86_64.AppImage" | sha256cmd)
echo "SHA256: $CREW_SHA256"

if [ "$CREW_SHA256" = "$CREW_CURRENT_SHA256" ]; then
  echo "Formula/kirocrew.rb is already up to date."
else
  # Try to get version from GitHub releases API
  CREW_VERSION=$(curl -s "https://api.github.com/repos/kirodotdev/KiroCrew/releases/latest" | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'].lstrip('v'))" 2>/dev/null || echo "")
  if [ -n "$CREW_VERSION" ]; then
    sedi "s/^  version \".*\"/  version \"${CREW_VERSION}\"/" Formula/kirocrew.rb
  fi
  sedi "s/^  sha256 \".*\"/  sha256 \"${CREW_SHA256}\"/" Formula/kirocrew.rb
  echo "Updated Formula/kirocrew.rb${CREW_VERSION:+ to version ${CREW_VERSION}}"
  CREW_UPDATED="${CREW_VERSION:-new-sha256}"
fi

# Commit and push if anything changed
if [ -n "$KIRO_UPDATED" ] || [ -n "$CLI_UPDATED" ] || [ -n "$CREW_UPDATED" ]; then
  echo ""
  PARTS=()
  [ -n "$KIRO_UPDATED" ] && PARTS+=("kiro $KIRO_UPDATED")
  [ -n "$CLI_UPDATED" ] && PARTS+=("kiro-cli $CLI_UPDATED")
  [ -n "$CREW_UPDATED" ] && PARTS+=("kirocrew $CREW_UPDATED")
  COMMIT_MSG=$(IFS=', '; echo "${PARTS[*]}")

  git add .
  git commit -m "$COMMIT_MSG"
  git push
  echo ""
  echo "Pushed: $COMMIT_MSG"
else
  echo ""
  echo "Nothing to update."
fi
