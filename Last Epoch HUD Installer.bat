@echo off
setlocal enabledelayedexpansion
title "Last Epoch Mod Installer"

set "MOD_ZIP=https://github.com/Syncingoutt/LastEpoch_Mods/releases/latest/download/LastEpoch_Hud.zip"
set "MOD_DLL=https://github.com/Syncingoutt/LastEpoch_Mods/releases/latest/download/UnityEngine.CoreModule.dll"
set "MELON_URL=https://github.com/LavaGang/MelonLoader/releases/download/v0.7.3/MelonLoader.x64.zip"
set "GAME_DIR=%~dp0"
set "TEMP_DIR=%TEMP%\LEMODFILES"

:: Makes sure it's in the Last Epoch root folder


if not exist "%GAME_DIR%Last Epoch.exe" (
    echo ====================================================================================================
    echo.
    echo 	[ERROR] Last Epoch was not found in this folder
    echo 	[ERROR] Please move this batch file inside your root Last Epoch directory and run it again.
    echo.
    echo ====================================================================================================
    pause
    exit /b )
if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"


:: Phase 2, Installs mod and dll after making sure the game has been ran once already

if exist "%GAME_DIR%MelonLoader\Il2CppAssemblies\UnityEngine.CoreModule.dll" (
    curl -sL "%MOD_DLL%" -o "%GAME_DIR%MelonLoader\Il2CppAssemblies\UnityEngine.CoreModule.dll"
    curl -sL "%MOD_ZIP%" -o "%TEMP_DIR%\LastEpoch_Hud.zip"
    powershell -Command "Expand-Archive -Path '%TEMP_DIR%\LastEpoch_Hud.zip' -DestinationPath '%GAME_DIR%Mods\' -Force"
    rmdir /S /Q "%TEMP_DIR%"

echo =======================================================================
echo.
echo           [SUCCESS] Mod Installation COMPLETE!!! HAVE FUN!
echo.
echo.          Press F3 to open the HUD when in WORLD
echo. 
echo           Installer Created by Pi4840 on Discord!
echo. 
echo           Mod created by Ash and updated by Shadow!
echo.
echo =======================================================================

pause
exit /b
)


:: Phase 1, Installs MelonLoader and extracts

echo Installing MelonLoader...
curl -sL "%MELON_URL%" -o "%TEMP_DIR%\MelonLoader.zip"
powershell -Command "Expand-Archive -Path '%TEMP_DIR%\MelonLoader.zip' -DestinationPath '%GAME_DIR%' -Force"
rmdir /S /Q "%TEMP_DIR%"
echo.
echo =======================================================================
echo                        Step 1 Complete
echo.
echo    Please run Last Epoch ONCE, let it load to main menu,
echo    close the game and then run this script again. Thank you!
echo.
echo =======================================================================
echo.
pause
exit /b







