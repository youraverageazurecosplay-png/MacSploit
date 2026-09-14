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
    local version=$(echo "$robloxVersionInfo" | grep -o '"clientVersionUpload":"[^"]*' | cut -d'"' -f4)

    if [ -z "$version" ]
    then
        exit 1
    fi

    [ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip
    
    if [ "$architecture" == "arm64" ]
    then
        curl -s "http://rbxcdn.com" -o "./RobloxPlayer.zip"
    else
        curl -s "http://rbxcdn.com" -o "./RobloxPlayer.zip"
    fi
    
    [ -d "/Applications/Roblox.app" ] && rm -rf "/Applications/Roblox.app"

    unzip -o -q "./RobloxPlayer.zip"
    mv ./RobloxPlayer.app /Applications/Roblox.app
    rm ./RobloxPlayer.zip
    
    exit 0
}

main
