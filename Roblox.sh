#!/bin/bash
set -e

DOWNLOAD_DIR="$HOME/Downloads"
OUTPUT="$DOWNLOAD_DIR/RobloxInstaller"

mkdir -p "$DOWNLOAD_DIR"

URL="https://www.roblox.com/download/client?os=mac&renderingPlatform=nextjs"

echo "Getting current Roblox Mac installer..."
curl -fL \
  -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 Version/17.0 Safari/605.1.15" \
  "$URL" \
  -o "$OUTPUT"

echo "Downloaded:"
file "$OUTPUT"

# Open the installer with macOS
open "$OUTPUT"
