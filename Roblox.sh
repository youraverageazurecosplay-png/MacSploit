#!/bin/bash
set -euo pipefail

# 1. Architecture Check
architecture=$(arch)

# 2. Version Fetching
robloxVersionInfo=$(curl -s "https://roblox.com")
version=$(echo "$robloxVersionInfo" | grep -o '"clientVersionUpload":"[^"]*' | grep -o '[^"]*$')

if [ -z "$version" ]; then
    exit 1
fi

# 3. Payload Download
[ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip

if [ "$architecture" == "arm64" ]; then
    curl -s "http://rbxcdn.com" -o "./RobloxPlayer.zip"
else
    curl -s "http://rbxcdn.com" -o "./RobloxPlayer.zip"
fi

# 4. Clean and Deploy
[ -d "/Applications/Roblox.app" ] && rm -rf "/Applications/Roblox.app"

unzip -oq "./RobloxPlayer.zip"
mv ./RobloxPlayer.app /Applications/Roblox.app
rm ./RobloxPlayer.zip
