From https://github.com/commercialhaskell/stack/issues/613:

To make an actual installer from the source code, you need to compile and run the Haskell program, which will generate an NSIS script that must in turn be compiled. I used the unicode NSIS compiler available at http://www.scratchpaper.com/. If using a non-unicode version, be sure to use a "long strings" build to avoid corrupting the user's %PATH%. The .nsi script expects stack.exe to be in the same directory.

`make-installers.bat <STACK-VERSION>` will do all the above.

To upload to the latest Github release, set `GITHUB_AUTH_TOKEN` and run `upload-installers.sh <STACK-VERSION>`.
