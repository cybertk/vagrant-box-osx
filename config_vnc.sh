#!/usr/bin/env bash

forward_vnc() {
    declare host="$1" key="$2"

    openssl rsa -in "$key" -pubout -outform DER | openssl md5 -c
    ssh -nNT \
        -f \
        -R 5900:localhost:5900 \
        -i "$key" \
        -o "IdentitiesOnly yes" \
        -o "UserKnownHostsFile /dev/null" \
        -o "CheckHostIP no" \
        -o "StrictHostKeyChecking no" \
        "root@$host"
}

setup_vnc() {
    declare password="$1"

    sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
        -activate -configure -access -on -restart -agent -privs -all \
        -clientopts -setvnclegacy -vnclegacy yes -setvncpw -vncpw "$password"
}


main() {
    setup_vnc 0
    forward_vnc 107.170.213.32 debug.key

    echo "VNC server is ready, connect at $host with password"
    while true; do sleep 30; echo .; done
}
