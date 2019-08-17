
@echo off
title AutoMirror
color 0d

cd Files/scrcpy
echo Devices
adb devices
echo Setting up connected device
adb tcpip 5555
echo Waiting for device to initialize
timeout 3
FOR /F "tokens=2" %%G IN ('adb shell ip addr show wlan0 ^|find "inet "') DO set ipfull=%%G
FOR /F "tokens=1 delims=/" %%G in ("%ipfull%") DO set ip=%%G
echo Device IP  %ip%...
pause
