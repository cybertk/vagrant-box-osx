#!/usr/bin/env bash

forward_port() {
    declare local_port="$1" remote_port="$2" host="$3" key="$4"

    openssl rsa -in "$key" -pubout -outform DER | openssl md5 -c
    ssh -nNT \
        -f \
        -R "$remote_port":localhost:"$local_port" \
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
    forward_port 5900 5900 107.170.213.32 debug.key

    forward_port 22 5922 107.170.213.32 debug.key

    echo "VNC server is ready, connect at 107.170.213.32 with password"
}

main "$@"
