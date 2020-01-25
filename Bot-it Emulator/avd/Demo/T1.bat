echo off

cd emulator
set ANDROID_AVD_HOME=..\avd
start  emulator.exe @Name -writable-system  -no-window