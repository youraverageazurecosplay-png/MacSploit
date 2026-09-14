#!/bin/bash

# 1. Download the Roblox DMG file
echo "Downloading Roblox..."
curl -L -o roblox.dmg "https://roblox.com"

# 2. Mount the DMG file and capture the exact mount point path
echo "Mounting DMG..."
MOUNT_DIR=$(hdiutil attach roblox.dmg | grep -o '/Volumes/.*' | head -n 1)

# Check if the mount was successful
if [ -z "$MOUNT_DIR" ]; then
    echo "Error: Failed to mount the DMG file."
    rm -f roblox.dmg
    exit 1
fi

echo "Successfully mounted to: $MOUNT_DIR"

# 3. Extract the .app file to your User Applications folder
echo "Extracting RobloxPlayerInstaller.app..."
mkdir -p "$HOME/Applications"
cp -R "$MOUNT_DIR/RobloxPlayerInstaller.app" "$HOME/Applications/"

# 4. Unmount the DMG volume safely
echo "Unmounting volume..."
hdiutil detach "$MOUNT_DIR"

# 5. Clean up the downloaded DMG file
echo "Cleaning up installer files..."
rm -f roblox.dmg

echo "Done! RobloxPlayerInstaller.app is now in your Applications folder."
