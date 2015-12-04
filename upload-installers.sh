#!/usr/bin/env bash

set -xe

STACKVER=$1

UPLOAD_URL=$(curl -sSLH "Authorization: token $GITHUB_AUTH_TOKEN" https://api.github.com/repos/commercialhaskell/stack/releases |grep upload_url |head -1 |sed 's/.*"\(https.*assets\){.*/\1/')

gpg --detach-sig --armor -u 9BEFB442 stack-$STACKVER-windows-i386-installer.exe

curl -X POST --data-binary "@stack-$STACKVER-windows-i386-installer.exe" -H "Content-type: application/octet-stream" -H "Authorization: token $GITHUB_AUTH_TOKEN" "$UPLOAD_URL?name=stack-$STACKVER-windows-i386-installer.exe&label=Windows+32-bit+Installer"

curl -X POST --data-binary "@stack-$STACKVER-windows-i386-installer.exe.asc" -H "Content-type: application/octet-stream" -H "Authorization: token $GITHUB_AUTH_TOKEN" "$UPLOAD_URL?name=stack-$STACKVER-windows-i386-installer.exe.asc&label=Windows+32-bit+Installer+(GPG+Signature)"

gpg --detach-sig --armor -u 9BEFB442 stack-$STACKVER-windows-x86_64-installer.exe

curl -X POST --data-binary "@stack-$STACKVER-windows-x86_64-installer.exe" -H "Content-type: application/octet-stream" -H "Authorization: token $GITHUB_AUTH_TOKEN" "$UPLOAD_URL?name=stack-$STACKVER-windows-x86_64-installer.exe&label=Windows+64-bit+Installer"

curl -X POST --data-binary "@stack-$STACKVER-windows-x86_64-installer.exe.asc" -H "Content-type: application/octet-stream" -H "Authorization: token $GITHUB_AUTH_TOKEN" "$UPLOAD_URL?name=stack-$STACKVER-windows-x86_64-installer.exe.asc&label=Windows+64-bit+Installer+(GPG+Signature)"
