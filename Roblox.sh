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

    local robloxVersion=$(curl -s "https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer" | awk -F'"clientVersionUpload":"' '{print $2}' | awk -F'"' '{print $1}')

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
