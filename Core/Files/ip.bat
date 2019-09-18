@echo off 
title AutoMirror
color 0d

echo https://discord.gg/CUgnVpk  DISCORD  

echo https://github.com/DizzyduckAR/AutoMirror/

cd Core/Files/scrcpy
adb kill-server
adb -d devices
echo Waiting for device to reconnect
timeout 3
FOR /F "tokens=2" %%G IN ('adb shell ip addr show wlan0 ^|find "inet "') DO set ipfull=%%G
FOR /F "tokens=1 delims=/" %%G in ("%ipfull%") DO set ip=%%G
echo Connecting to device with IP %ip%
echo %ip%:5555|clip
adb tcpip 5555
timeout 3
adb connect  %ip%:5555
#scrcpy-noconsole --window-title Mirror1 -s %ip%:5555 
