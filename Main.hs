{-# LANGUAGE OverloadedStrings #-}
module Main where

import Development.NSIS
import Development.NSIS.Plugins.EnvVarUpdate

-- Note that it is *required* to use a NSIS compiler that supports long strings,
-- to avoid corrupting the user's $PATH.

main = writeFile "stack-install.nsi" $ nsis $ do
  _ <- constantStr "Name" "stack"

  name "$Name"
  outFile "stack-install.exe"
  installDir "$APPDATA/local/bin"
  installDirRegKey HKLM "Software/$Name" "Install_Dir"
  requestExecutionLevel User

  page Directory
  page Components
  page InstFiles

  unpage Components
  unpage InstFiles

  section "Install stack" [Required] $ do
    setOutPath "$INSTDIR"
    file [] "stack.exe"

    -- Write the installation path into the registry
    writeRegStr HKCU "SOFTWARE/$Name" "Install_Dir" "$INSTDIR"

    -- Write the uninstall keys for Windows
    writeRegStr HKCU "Software/Microsoft/Windows/CurrentVersion/Uninstall/$Name" "DisplayName" "$Name"
    writeRegStr HKCU "Software/Microsoft/Windows/CurrentVersion/Uninstall/$Name" "UninstallString" "\"$INSTDIR/uninstall.exe\""
    writeRegDWORD HKCU "Software/Microsoft/Windows/CurrentVersion/Uninstall/$Name" "NoModify" 1
    writeRegDWORD HKCU "Software/Microsoft/Windows/CurrentVersion/Uninstall/$Name" "NoRepair" 1
    writeUninstaller "uninstall-stack.exe"

  section "Add to user %PATH%"
    [ Description "Add installation directory to user %PATH% to allow running stack in the console."
    ] $ do
      setEnvVarPrepend HKCU "PATH" "$INSTDIR"

  -- Uninstallation sections. (Any section prepended with "un." is an
  -- uninstallation option.)
  section "un.Remove stack" [] $ do
    deleteRegKey HKCU "Software/Microsoft/Windows/CurrentVersion/Uninstall/$Name"
    deleteRegKey HKCU "Software/$Name"

    delete [] "$INSTDIR/stack.exe"
    delete [] "$INSTDIR/uninstall-stack.exe"
    rmdir [] "$INSTDIR" -- will not remove if not empty

  -- The description text is not actually added to the uninstaller as of
  -- nsis-0.3
  section "un.Remove from %PATH%"
    [ Unselected
    , Description "Remove $INSTDIR from the user %PATH%. There may be other programs installed in that location."
    ] $ do
      setEnvVarRemove HKCU "PATH" "$INSTDIR"

{-

-- This section involves deleting a lot of potentially-valuable data. I'm not
-- confident I'd get it right. Ideally stack's own rm/purge command should handle
-- this.

  section "un.Delete compiler installations and cached snapshots"
    [ Unselected
    , Description "Remove compilers that have been installed by stack, downloaded build plans, and cached snapshots"
    ] $ do
      -- should delete $APPDATA/stack/build-plan,
      --  $APPDATA/stack/build-plan-cache, $APPDATA/stack/snapshots, and perhaps
      --  others
-}
