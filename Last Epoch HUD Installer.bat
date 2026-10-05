@echo off
setlocal enabledelayedexpansion
title "Last Epoch Mod Installer"

set "MOD_ZIP=https://github.com/Syncingoutt/LastEpoch_Mods/releases/latest/download/LastEpoch_Hud.zip"
set "MOD_DLL=https://github.com/Syncingoutt/LastEpoch_Mods/releases/latest/download/UnityEngine.CoreModule.dll"
set "MELON_URL=https://github.com/LavaGang/MelonLoader/releases/download/v0.7.3/MelonLoader.x64.zip"
set "GAME_DIR=%~dp0"
set "TEMP_DIR=%TEMP%\LEMODFILES"

:: ANSI Colors 
for /f "delims=" %%A in ('powershell -NoProfile -Command "[char]27"') do set "ESC=%%A"
set "RESET=%ESC%[0m"
set "RED=%ESC%[91m"
set "GREEN=%ESC%[92m"


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
    set "ERROR_TYPE=HUD"
    curl -sfL "%MOD_DLL%" -o "%GAME_DIR%MelonLoader\Il2CppAssemblies\UnityEngine.CoreModule.dll" || goto :ERROR_CHECK
    curl -sfL "%MOD_ZIP%" -o "%TEMP_DIR%\LastEpoch_Hud.zip" || goto :ERROR_CHECK
    mkdir "%GAME_DIR%Mods" 2>nul
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
set "ERROR_TYPE=Melon"
curl -sfL "%MELON_URL%" -o "%TEMP_DIR%\MelonLoader.zip" || goto :ERROR_CHECK
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


:ERROR_CHECK
echo.
echo =======================================================================
echo.
echo                      [%RED%ERROR%RESET%] !ERROR_TYPE! Download failed!
echo    Check your internet connection or verify that %RED%GitHub%RESET% is online.
echo.
echo =======================================================================
echo.
if exist "%TEMP_DIR%" rmdir /S /Q "%TEMP_DIR%"
pause
exit /b 1


