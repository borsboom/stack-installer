setlocal
SET STACKVER=%1

stack --install-ghc build
@if errorlevel 1 exit /b
stack exec build-stack-installer
@if errorlevel 1 exit /b

copy /y c:\stack\_release\\stack-%STACKVER%-windows-x86_64.exe stack.exe
@if errorlevel 1 exit /b
"c:\Program Files (x86)\NSIS\Unicode\makensis.exe" -V3 stack-install.nsi
@if errorlevel 1 exit /b
if exist stack-install-%STACKVER%-windows-x86_64.exe del stack-install-%STACKVER%-windows-x86_64.exe
ren stack-install.exe stack-install-%STACKVER%-windows-x86_64.exe
@if errorlevel 1 exit /b
signtool sign /v /n "FP Complete, Corporation" /t "http://timestamp.verisign.com/scripts/timestamp.dll" stack-install-%STACKVER%-windows-x86_64.exe
@if errorlevel 1 exit /b

copy /y c:\stack\_release\\stack-%STACKVER%-windows-i386.exe stack.exe
@if errorlevel 1 exit /b
"c:\Program Files (x86)\NSIS\Unicode\makensis.exe" -V3 stack-install.nsi
@if errorlevel 1 exit /b
if exist stack-install-%STACKVER%-windows-i386.exe del stack-install-%STACKVER%-windows-i386.exe
ren stack-install.exe stack-install-%STACKVER%-windows-i386.exe
@if errorlevel 1 exit /b
signtool sign /v /n "FP Complete, Corporation" /t "http://timestamp.verisign.com/scripts/timestamp.dll" stack-install-%STACKVER%-windows-x86_64.exe
@if errorlevel 1 exit /b
