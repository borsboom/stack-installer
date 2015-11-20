From https://github.com/commercialhaskell/stack/issues/613:

To make an actual installer from the source code, you need to compile and run the Haskell program, which will generate an NSIS script that must in turn be compiled. I used the unicode NSIS compiler available at http://www.scratchpaper.com/. If using a non-unicode version, be sure to use a "long strings" build to avoid corrupting the user's %PATH%. The .nsi script expects stack.exe to be in the same directory.

`make-installers.bat <STACK-VERSION>` will do all the above.

To upload to Github release, set `GITHUB_AUTH_TOKEN` and run this to get the upload URL for the current release:

```
curl -H "Authorization: token $GITHUB_AUTH_TOKEN" https://api.github.com/repos/commercialhaskell/stack/releases
```

Then update below with the upload URL and new version, and run:


```
gpg --detach-sig --armor -u 9BEFB442 stack-0.1.8.0-windows-i386-installer.exe

curl -X POST --data-binary '@stack-0.1.8.0-windows-i386-installer.exe' -H "Content-type: application/octet-stream" -H "Authorization: token $GITHUB_AUTH_TOKEN" 'https://uploads.github.com/repos/commercialhaskell/stack/releases/2155093/assets?name=stack-0.1.8.0-windows-i386-installer.exe&label=Windows+32-bit+Installer'

curl -X POST --data-binary '@stack-0.1.8.0-windows-i386-installer.exe.asc' -H "Content-type: application/octet-stream" -H "Authorization: token $GITHUB_AUTH_TOKEN" 'https://uploads.github.com/repos/commercialhaskell/stack/releases/2155093/assets?name=stack-0.1.8.0-windows-i386-installer.exe.asc&label=Windows+32-bit+Installer+(GPG+Signature)'

gpg --detach-sig --armor -u 9BEFB442 stack-0.1.8.0-windows-x86_64-installer.exe

curl -X POST --data-binary '@stack-0.1.8.0-windows-x86_64-installer.exe' -H "Content-type: application/octet-stream" -H "Authorization: token $GITHUB_AUTH_TOKEN" 'https://uploads.github.com/repos/commercialhaskell/stack/releases/2155093/assets?name=stack-0.1.8.0-windows-x86_64-installer.exe&label=Windows+64-bit+Installer'

curl -X POST --data-binary '@stack-0.1.8.0-windows-x86_64-installer.exe.asc' -H "Content-type: application/octet-stream" -H "Authorization: token $GITHUB_AUTH_TOKEN" 'https://uploads.github.com/repos/commercialhaskell/stack/releases/2155093/assets?name=stack-0.1.8.0-windows-x86_64-installer.exe.asc&label=Windows+64-bit+Installer+(GPG+Signature)'

```

