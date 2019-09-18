@echo off 
title AutoMirror
color 0d

cd Core/Files/scrcpy

echo Kill All open ADB servers


adb kill-server

echo ALL BEARS ARE DOWN
timeout 3
