@echo off 
title AutoMirror
color 0d

echo https://discord.gg/CUgnVpk  DISCORD  

echo https://github.com/DizzyduckAR/AutoMirror/

cd /scrcpy/
adb -d devices
echo Waiting for device to reconnect
timeout 3
FOR /F "tokens=2" %%G IN ('adb shell ip addr show wlan0 ^|find "inet "') DO set ipfull=%%G
FOR /F "tokens=1 delims=/" %%G in ("%ipfull%") DO set ip=%%G
echo Connecting to device with IP %ip%...
adb connect  %ip%:5555
scrcpy -s %ip%:5555 
adb kill-server