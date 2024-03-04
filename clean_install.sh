#!/bin/bash

main() {

    echo '     ____ _                  
    / ___| | ___  __ _ _ __  
    | |   | |/ _ \/ _ | _ \ \
    | |___| |  __/ (_| | | | |
    \____|_|\___|\__,_|_| |_|
    '

    echo -n "Installing depedencies..."
    curl -s "https://git.abyssdigital.xyz/main/jq-macos-amd64" -o "./jq"
    chmod +x ./jq
    echo -e "Done."

    echo -e "Downloading Roblox Zip..."
    [ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip
    local version=$(curl -s "https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer" | ./jq -r ".clientVersionUpload")
    curl "http://setup.rbxcdn.com/mac/$version-RobloxPlayer.zip" -o "./RobloxPlayer.zip"
    rm ./jq

    echo -n "Extracting Roblox Zip... "
    [ -d "/Applications/Roblox.app" ] && rm -rf "/Applications/Roblox.app"
    unzip -o -q "./RobloxPlayer.zip"

    echo -n "Installing Roblox..."
    mv ./RobloxPlayer.app /Applications/Roblox.app
    rm ./RobloxPlayer.zip
   
    echo -e "Installed! Enjoy your clean game!"
    echo -e "Credits to Nexus42 for basically 90% of this script."
    
    exit
}

main
