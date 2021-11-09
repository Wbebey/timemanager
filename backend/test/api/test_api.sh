#!/bin/bash

displayHello() {
    printf "#\tTimeManager API testing script. \n"
    printf "#\n#\n#\tStarting...\n#\n"
}

## NEWMAN FUNCTIONS ##
checkNewMan() {
    printf "#\tChecking newman\n"
    HAS_NEWMAN=$(command -v newman)
    HAS_NPM=$(command -v npm)
    if [ -z "$HAS_NEWMAN" ]; then
        printf "#\tNewman not found, installing...\n"
        if [ -z "$HAS_NPM" ]; then
            printf "! NPM not found.. can't install\n"
            printf "! Stopping tests\n#\n#\n#"
            exit 1
        else
            sudo npm install -g newman
        fi
    else
        printf "#\tNewman found in $HAS_NEWMAN\n"
    fi
}

runNewman() {
    newman run ./piscine_msc_pro_phoenix.postman_collection_2.json --timeout 1800000 --timeout-request 1800000 --timeout-script 1800000 --bail
    status=$?
    exit $status
}

## MAIN FUNCTION ##
main() {
    printf "#\n#\n#\n"
    displayHello
    checkNewMan
    runNewman
}
main