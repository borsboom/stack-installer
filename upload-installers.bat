REM TODO: move this logic to stack/etc/scripts/release.hs
setlocal
set STACKDIR=%1
set STACKVER=%2
cd %STACKDIR%
stack ../stack/etc/scripts/release.hs _release\stack-%STACKVER%-windows-x86_64-installer.exe.upload _release\stack-%STACKVER%-windows-x86_64-installer.exe.sha256.upload _release\stack-%STACKVER%-windows-x86_64-installer.exe.asc.upload
stack ../stack/etc/scripts/release.hs _release\stack-%STACKVER%-windows-i386-installer.exe.upload _release\stack-%STACKVER%-windows-i386-installer.exe.sha256.upload _release\stack-%STACKVER%-windows-i386-installer.exe.asc.upload
