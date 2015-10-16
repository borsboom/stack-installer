From https://github.com/commercialhaskell/stack/issues/613:

To make an actual installer from the source code, you need to compile and run the Haskell program, which will generate an NSIS script that must in turn be compiled. I used the unicode NSIS compiler available at http://www.scratchpaper.com/. If using a non-unicode version, be sure to use a "long strings" build to avoid corrupting the user's %PATH%. The .nsi script expects stack.exe to be in the same directory.

`make-installers.bat` will build the installer.

To upload to Github release, set `GITHUB_AUTH_TOKEN` and run this to get the upload URL for the current release:

```
curl -H "Authorization: token $GITHUB_AUTH_TOKEN" https://api.github.com/repos/commercialhaskell/stack/releases
```

Then update below with the upload URL and new version, and run:


```
curl -X POST --data-binary '@stack-0.1.6.0-windows-i386-installer.exe' -H "Content-type: application/octet-stream" -H "Authorization: token $GITHUB_AUTH_TOKEN" 'https://uploads.github.com/repos/commercialhaskell/stack/releases/1950291/assets?name=stack-0.1.6.0-windows-i386-installer.exe&label=Windows+32-bit+Installer+(EXPERIMENTAL)'

curl -X POST --data-binary '@stack-0.1.6.0-windows-x86_64-installer.exe' -H "Content-type: application/octet-stream" -H "Authorization: token $GITHUB_AUTH_TOKEN" 'https://uploads.github.com/repos/commercialhaskell/stack/releases/1950291/assets?name=stack-0.1.6.0-windows-x86_64-installer.exe&label=Windows+64-bit+Installer+(EXPERIMENTAL)'
```

