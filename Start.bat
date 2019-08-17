@echo off 
title AutoMirror
color 0d
echo Pick operation
echo.
echo 1. Local Wifi Mirror
echo 2. Usb Mirror
echo 3. 32Bit Mirror
echo 4. Muilti Mirror (under dev)
echo 5. Kill all adb servers (need to run 1 or 2 first)
echo 6. Get Device SN and IP (need to run 1 or 2 first)
echo.
echo Number:


set /p a=
IF %a%==1 (PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'Files/wifi.ps1'")
IF %a%==2 (PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'Files/cable.ps1'")
IF %a%==3 (PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'Files/32bit.ps1'")
IF %a%==4 (echo under dev)
IF %a%==5 (call "Files/KillAllServers.bat")
IF %a%==6 (call "Files/showsnip.bat")

