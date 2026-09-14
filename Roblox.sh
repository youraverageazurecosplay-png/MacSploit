#!/bin/bash

main() {
    clear
    local architecture=$(arch)

    if [ "$architecture" == "arm64" ]
    then
        if [ ! -f /Library/Apple/usr/libexec/oah/libRosettaRuntime ]
        then
            softwareupdate --install-rosetta --agree-to-license
        fi
    fi

    local robloxVersionInfo=$(curl -s "https://roblox.com")
    local robloxVersion=$(echo "$robloxVersionInfo" | python3 -c "import sys, json; print(json.load(sys.stdin)['clientVersionUpload'])")

    if [ -z "$robloxVersion" ]; then
        exit 1
    fi

    [ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip
    
    if [ "$architecture" == "arm64" ]
    then
        curl "http://rbxcdn.com" -o "./RobloxPlayer.zip"
    else
        curl "http://rbxcdn.com" -o "./RobloxPlayer.zip"
    fi
    
    [ -d "/Applications/Roblox.app" ] && rm -rf "/Applications/Roblox.app"

    unzip -o -q "./RobloxPlayer.zip"
    mv ./RobloxPlayer.app /Applications/Roblox.app
    rm ./RobloxPlayer.zip
    
    exit 0
}

main
