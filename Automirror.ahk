SetWorkingDir %A_ScriptDir%
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SendMode Input
;SetTitleMatchMode 2
SetTitleMatchMode Fast
#WinActivateForce
SetControlDelay 1
SetWinDelay 1
SetKeyDelay -1
SetMouseDelay -1
;DetectHiddenWindows,On
;#SingleInstance force
;#SingleInstance ignore
#SingleInstance off
#NoTrayIcon

TF("Core\Files\scrcpy\Adbdevices.txt", CreateGlobalVar="T")
targetwindow := "Mirror1" ;Window name

Menu, Tray, Icon, Core\hoticon.png
Gui Add, Text, x60 y40 h20 +0x200, Mirror Window Name:
Gui, Add, Edit, x180 y40 w100 h20 +0x200 vtargetwindow gsubmit_all, %targetwindow%
Gui Add, DropDownList, x50 y200 w120  vmenuChoice gDevice , No Device||
Gui Add, DropDownList, x370 y200 w120 vReschoice gRes , 640|800|960|Free Resolution|
Gui Add, Text, x10 y200 w36 h20 +0x200, Device
Gui Add, Text, x310 y200  h20 +0x200, Resolution
Gui Add, Button, x320 y30 w49 h31 , &Start
Gui Add, Button, x10 y100  h31 , &Grab IP And PORT 5555
Gui Add, Button, x215 y100  h31 , &Kill ADB Server
Gui Add, Button, x380 y100  h31 , &Turn Phone LCD Off
Gui Add, Button, x380 y140  h31 , &Turn Phone LCD On
Gui Add, Button, x180 y200 w49 h20 , &Update
Gui Add, Button, x400 y30 w49 h31, &Restart
Gui Add, Link, x270 y425 w47 h19, <a href="https://discord.gg/CUgnVpk">Discord</a>
Gui Add, Picture, x230 y415 w32 h32, Core\2.png
Gui Add, Link, x170 y425 w47 h19, <a href="https://www.patreon.com/AutoMirror">Patreon</a>
Gui Add, Picture, x130 y415 w32 h32, Core\patreon.png
Gui Add, Link, x360 y425 w47 h19, <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=65VHM2EKXZ8E6">Donate</a>
Gui Add, Picture, x320 y410 w32 h32, Core\PPlogo.png
Gui, Add, Edit, x10 y260 w480 h100 vTerminal ReadOnly, Download Auto-Mirror First! you got a button
Gui Add, Button, x410 y420 w80 h23, Crop Screen
Gui Add, Button, x10 y420  h23, Download Auto-Mirror
Gui, Add, Edit, x180 y370 w100 h20 +0x200 vadbconnect gsubmit_all, 192.168.0.0
Gui Add, Button, x295 y370 w49 h20 , &Connect
Gui Show, w500 h450, Auto-Mirror v0.3
Menu, Tray, Icon, Core\hoticon.png
Return



IsPaused := false

ButtonGrabIPAndPORT5555:
GuiControl,, Terminal,Start Grab IP And PORT 5555 please wait 10-30 seconds
RunWait, Core\Files\ip.bat,,Hide
IP := clipboard
GuiControl,, menuChoice, |
GuiControl,, menuChoice,%IP%||
GuiControl,, Terminal,IP Grab Success %IP%


return

ButtonStart:
if ( Reschoice = "Free Resolution" )
{
	GuiControl,, Terminal,Starting Mirror please wait
	Batit = scrcpy-noconsole --window-title %targetwindow% -s %menuChoice%
	FileDelete Core\Files\scrcpy\temp.bat
	FileAppend %Batit% , Core\Files\scrcpy\temp.bat
	Sleep, 1000
	GuiControl,, Terminal,Pushing The Next Step
	Sleep, 1000
	GuiControl,, Terminal,Pushing The Next Step...Converting vegetarians
	Run temp.bat, Core\Files\scrcpy\, Hide
	sleep, 4000
	if WinExist(%targetwindow%)
	{
		
		GuiControl,, Terminal,Mirror Device: %menuChoice%  Resolution:%Reschoice%  Mirror Name:%targetwindow%
		
	}
	return
	
}

	else
	{
		GuiControl,, Terminal,Starting Mirror please wait
		Batit = scrcpy-noconsole --window-title %targetwindow% -m %Reschoice% -s %menuChoice%
		FileDelete Core\Files\scrcpy\temp.bat
		FileAppend %Batit% , Core\Files\scrcpy\temp.bat
		Sleep, 1000
		GuiControl,, Terminal,Pushing The Next Step
		Sleep, 1000
		GuiControl,, Terminal,Pushing The Next Step...Converting vegetarians
		Sleep, 2000
		Run temp.bat, Core\Files\scrcpy\, Hide
		sleep, 4000
		if WinExist(%targetwindow%)
		{
			GuiControl,, Terminal,Mirror Device: %menuChoice%  Resolution:%Reschoice%  Mirror Name:%targetwindow%
	     }
		return
}

ButtonTurnPhoneLCDOff:
WinActivate, %targetwindow%
Send ^o
return

ButtonTurnPhoneLCDOn:
WinActivate, %targetwindow%
Send ^p
return


ButtonDownloadAuto-Mirror:
FileRemoveDir, Core\Files\Scrcpy\ 
FileDelete Core\Files\scrcpy\Scrcpy.zip
GuiControl,, Terminal,Downloading please wait 20
UrlDownloadToFile, https://github.com/DizzyduckAR/AutoMirror/raw/master/ScrcpyAutoMirror.zip , Core\Files\Scrcpy.zip
sleep, 2000
GuiControl,, Terminal,Expending please wait 10
Run Expend.bat, Core\Files\, Hide
sleep, 2000
GuiControl,, Terminal,Download Fin

ButtonKillADBServer:
Run, Core\Files\KillAllServers.bat,,Hide
return

Buttonupdate:
;GuiControl,, Terminal,Updating ADB Devices please wait
Run Adbdevices.bat, Core\Files\scrcpy\, Hide
Sleep, 1000
FileRead, ADBDevices , Core\Files\scrcpy\Adbdevices.txt
GuiControl,, Terminal , %ADBDevices%

TF_RemoveLines("!Core\Files\scrcpy\Adbdevices.txt", 0, 1)
TF_Replace("!Core\Files\scrcpy\Adbdevices.txt","device","")
TF_RemoveBlankLines("!Core\Files\scrcpy\Adbdevices.txt")
TF_ReadLines("!Core\Files\scrcpy\Adbdevices.txt")
TF_Save("!Core\Files\scrcpy\!Adbdevices.txt" ,"!Core\Files\scrcpy\!Adbdevices.txt", OverWrite = 1)
Lines:=TF_CountLines("Core\Files\scrcpy\Adbdevices.txt")
GuiControl,, menuChoice, |
loop,%Lines%
{	
FileReadLine, device1 , Core\Files\scrcpy\Adbdevices.txt, 1
GuiControl,, menuChoice, %device1%|
TF_Save("!Core\Files\scrcpy\!Adbdevices.txt" ,"!Core\Files\scrcpy\!Adbdevices.txt", OverWrite = 1)
TF_RemoveLines("!Core\Files\scrcpy\Adbdevices.txt", 0, 1)
}
return


ButtonConnect:
GuiControl,, Terminal,Connecting to IP please wait
Batit2 = adb tcpip %adbconnect%`nadb connect %adbconnect%:5555
FileDelete Core\Files\scrcpy\iptemp.bat
FileDelete Core\Files\scrcpy\Adbdevices.txt
FileAppend %Batit2% , Core\Files\scrcpy\iptemp.bat
Sleep,1000
Run iptemp.bat, Core\Files\scrcpy\, Hide
Sleep,4000
Run Adbdevices.bat, Core\Files\scrcpy\, Hide
Sleep,2000
FileRead, ADBDevices , Core\Files\scrcpy\Adbdevices.txt
GuiControl,, Terminal , %ADBDevices%
return

ButtonRestart:
Reload
return

ButtonPause:

if IsPaused
{
	Pause off
	IsPaused := false
	GuiControl,, PauseButton, Pause
}

else
	SetTimer, Pause, 10
return

Pause:
SetTimer, Pause, off
IsPaused := true
GuiControl,, PauseButton, Unpause
Pause, on
return


















Res:
Gui, Submit, NoHide
if (Reschoice = 640)
	
{
	res := 640
		;msgbox, %res%
	Gui, Submit, NoHide
}

else if (Reschoice = 800)
	
{
	res := 800
     ;msgbox, %res%
	Gui, Submit, NoHide
}	
else if (Reschoice = 960)
	
{
	res := 960
     ;msgbox, %res%
	Gui, Submit, NoHide
}

else if (Reschoice = "Free Resolution")
	
{
	res := 
     ;msgbox, %res%
	Gui, Submit, NoHide
}


Device:
Gui, Submit, NoHide


submit_all:
Gui, Submit, Nohide
return

GuiEscape:
GuiClose:
ExitApp

F8::ExitApp

ButtonCropScreen:
ScreenCapture(location:="clipboard")

IfNotExist, img\BotitCrop1.png
{
	SaveClipImgToFile("img\BotitCrop1.png")
	Sleep, 1000
	MsgBox, Saved BotitCrop1.png
	return
}

IfNotExist, img\BotitCrop2.png
{
	SaveClipImgToFile("img\BotitCrop2.png")
	Sleep, 1000
	MsgBox, Saved BotitCrop2.png
	return
}

IfNotExist, img\BotitCrop3.png	
{
	SaveClipImgToFile("img\BotitCrop3.png")
	Sleep, 1000
	MsgBox, Saved BotitCrop3.png
	return
}

IfNotExist, img\BotitCrop4.png
{
	SaveClipImgToFile("img\BotitCrop4.png")
	Sleep, 1000
	MsgBox, Saved BotitCrop4.png
	return
}

IfNotExist, img\BotitCrop5.png	
{
	SaveClipImgToFile("img\BotitCrop5.png")
	Sleep, 1000
	MsgBox, Saved BotitCrop5.png
	return
}

IfNotExist, img\BotitCrop6.png	
{
	SaveClipImgToFile("img\BotitCrop6.png")
	Sleep, 1000
	MsgBox, Saved BotitCrop6.png
	return
}

IfNotExist, img\BotitCrop7.png	
{
	SaveClipImgToFile("img\BotitCrop7.png")
	Sleep, 1000
	MsgBox, Saved BotitCrop7.png
	return
}

IfNotExist, img\BotitCrop8.png	
{
	SaveClipImgToFile("img\BotitCrop8.png")
	Sleep, 1000
	MsgBox, Saved BotitCrop8.png
	return
}

IfNotExist, img\BotitCrop9.png	
{
	SaveClipImgToFile("img\BotitCrop9.png")
	Sleep, 1000
	MsgBox, Saved BotitCrop9.png
	return
}
MsgBox, All botit Randoms are Full
return

SaveClipImgToFile(FileName) {
	pToken := Gdip_Startup()
	pBitmap := Gdip_CreateBitmapFromClipboard()
	Gdip_SaveBitmapToFile(pBitmap, FileName)
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
}

#Include Core\Clipper.ahk
#Include Core\tf.ahk
