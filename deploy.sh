#!/bin/sh

ls -al out
dropbox_uploader.sh upload out/*.dmg install.dmg -p
