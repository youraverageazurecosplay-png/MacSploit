#!/bin/bash

local architecture=$(arch)

    if [ "$architecture" == "arm64" ]
    then
        echo -e "Detected ARM64 Architecture."
        if [ ! -f /Library/Apple/usr/libexec/oah/libRosettaRuntime ]
        then # install rosetta if not available
            echo -e "Prompting Rosetta (Not Installed)"
            softwareupdate --install-rosetta --agree-to-license
        fi
    fi
