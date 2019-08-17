@echo off 
title AutoMirror
color 0d

cd Files/scrcpy

echo Kill All open ADB servers

timeout 3

adb kill-server

echo ALL BEARS ARE DOWN
pause
