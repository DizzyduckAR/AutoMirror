

#NoEnv
SetBatchLines, -1
OnExit, OnExit

SetWorkingDir %A_ScriptDir%
; Include the Neutron library
#Include <Neutron>
#Include <tf>


global helpindex:=1
global version:="1.0.2"

; Create a new NeutronWindow and navigate to our HTML page
neutron := new NeutronWindow()
neutron.Load("login/login.html")
;for i, elem in neutron.Each(neutron.qsa(".neutron"));
;	elem.classList.remove("neutron")
neutron.Gui("+LabelNeutron")
neutron.Show("w450 h860")
return

; FileInstall all your dependencies, but put the FileInstall lines somewhere
; they won't ever be reached. Right below your AutoExecute section is a great
; location!

{
	;html
	FileInstall, login/login.html, *
	;css
	FileInstall, login/vendors.min.css, *
	FileInstall, login/bootstrap.css, *
	FileInstall, login/bootstrap-extended.css, *
	FileInstall, login/colors.css, *
	FileInstall, login/components.css, *
	FileInstall, login/dark-layout.css, *
	FileInstall, login/bordered-layout.css, *
	FileInstall, login/vertical-menu.css, *
	FileInstall, login/form-validation.css, *
	FileInstall, login/page-auth.css, *
	;FileInstall, login/style.css, *
	;js
	FileInstall, login/vendors.min.js, *
	FileInstall, login/jquery.validate.min.js, *
	;FileInstall, login/app.js, *
	FileInstall, login/page-auth-login.js, *

	;media
	FileInstall, login/icon.png, *

	;FileInstall, login/ip.txt, %A_ScriptDir%/Mirror/ip.txt

	;media
	FileInstall, login/record.svg, *
	FileInstall, login/touch.svg, *
	FileInstall, login/smarton.svg, *
	FileInstall, login/smartoff.svg, *
	FileInstall, login/picture.svg, *
	FileInstall, login/user-interface.svg, *
	FileInstall, login/android.svg, *
	FileInstall, login/wifi.svg, *
	FileInstall, login/layers.svg, *
	FileInstall, login/discord.svg, *
	FileInstall, login/youtube.svg, *
	FileInstall, login/github.svg, *
	FileInstall, login/webpages.svg, *
	FileInstall, login/devices.svg, *
	FileInstall, login/help.svg, *
	
}
; The built in GuiClose, GuiEscape, and GuiDropFiles event handlers will work
; with Neutron GUIs. Using them is the current best practice for handling these
; types of events. Here, we're using the name NeutronClose because the GUI was
; given a custom label prefix up in the auto-execute section.
NeutronClose:
ExitApp
return

OnExit:
ExitApp
return


startup(neutron)
{
	IfNotExist, Mirror\version.ini
	{
		msgbox,,,Core Missing Self Deploy Started,1
		url := "https://github.com/Genymobile/scrcpy/releases/download/v1.19/scrcpy-win64-v1.19.zip"
		
		Download("Core.zip", url)
		zipname=Core.zip
		zipFolder=%A_ScriptDir%\Mirror
		SmartZip(zipname,zipFolder)
		FileDelete,%A_ScriptDir%\Core.zip
		IniWrite, 1.19,  Mirror\version.ini, version, my
		; IniWrite, Pairs, Mirror\version.ini, Section
	}
	IfExist, Mirror\version.ini
	{
		IniRead, myvekr, Mirror\version.ini,version,my
		;  msgbox, %myvekr%
		if (myvekr!= 1.19)
		{
			msgbox,,,Core Missing Self Deploy Started,1
			url := "https://github.com/Genymobile/scrcpy/releases/download/v1.19/scrcpy-win64-v1.19.zip"
		
			Download("Core.zip", url)
			zipname=Core.zip
			zipFolder=%A_ScriptDir%\Mirror
			SmartZip(zipname,zipFolder)
			FileDelete,%A_ScriptDir%\Core.zip
			IniWrite, 1.19,  Mirror\version.ini, version, my
			}
	}
	;check Core
	IfNotExist, Mirror\adb.exe
	{
		msgbox,,,Core Missing Self Deploy Started,2
		url := "https://github.com/Genymobile/scrcpy/releases/download/v1.19/scrcpy-win64-v1.19.zip"
		
		Download("Core.zip", url)
		zipname=Core.zip
		zipFolder=%A_ScriptDir%\Mirror
		SmartZip(zipname,zipFolder)
		FileDelete,%A_ScriptDir%\Core.zip
	}
	
	IfNotExist, Mirror\ip.bat
	{
		url := "https://raw.githubusercontent.com/DizzyduckAR/AutoMirror/master/lib/ip.bat"
		
		Download("Mirror/ip.bat", url)
	}
	
	test := neutron.doc.getElementById("mainselect")
        test2 := neutron.doc.createElement("option")
        looper := "800"
        test2.text := looper
        test.add(test2)
        test2 := neutron.doc.createElement("option")
        looper := "960"
        test2.text := looper
        test.add(test2)
        test2 := neutron.doc.createElement("option")
        looper := "NoLimit"
        test2.text := looper
        test.add(test2)
}

helpbtnn(neutron)
{
	helpindex:=helpindex+1

	if (helpindex=2)
	{
		neutron.doc.getElementById("helpname").innerHTML := "Developer mode unlock"
		neutron.doc.getElementById("helpimg").src:="https://raw.githubusercontent.com/DizzyduckAR/AutoMirror/master/HelpGifs/DevMode.gif"
		return

	}
	
	if (helpindex>=3)
	{
		helpindex:=3
		neutron.doc.getElementById("helpname").innerHTML := "Connect Phone"
		neutron.doc.getElementById("helpimg").src:="https://raw.githubusercontent.com/DizzyduckAR/AutoMirror/master/HelpGifs/phone2pc.png"
		return
	}
	
	;msgbox,next index %helpindex%
}

helpbtnb(neutron)
{
	helpindex:=helpindex-1
	if (helpindex=2)
	{
		neutron.doc.getElementById("helpname").innerHTML := "Developer mode unlock"
		neutron.doc.getElementById("helpimg").src:="https://raw.githubusercontent.com/DizzyduckAR/AutoMirror/master/HelpGifs/DevMode.gif"
		return

	}

	if (helpindex<=1)
	{
		neutron.doc.getElementById("helpname").innerHTML := "RSA Allow"
		neutron.doc.getElementById("helpimg").src := "https://raw.githubusercontent.com/DizzyduckAR/AutoMirror/master/HelpGifs/RSA.png"
		helpindex:=1
		return
	}
	;msgbox,back index %helpindex%
	
}


lcdon(neutron)
{
	menuChoicename := neutron.doc.getElementById("mainselect2").value
	
	WinActivate, %menuChoicename%
	Send !+o
}

lcdoff(neutron)
{
	menuChoicename := neutron.doc.getElementById("mainselect2").value
	
	WinActivate, %menuChoicename%
	Send !o
}

getip(neutron)
{
	barstate +=0
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	barstate +=25
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,250
	RunWait Mirror\ip.bat ,,Hide
	barstate +=25
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,250
	buildname := "adb tcpip 5555"
	;msgbox,%buildname%
	;runwait %comspec% /c Mirror\adb.exe %buildname%
	;RunWait, %comspec% /c Mirror\adb.exe %buildname%
	;Send, %buildname%{enter}
	FileDelete, Mirror\connect.bat
	FileAppend,
	(
@echo off
cd Mirror
%buildname%
timeout 1
	), Mirror\connect.bat
	RunWait Mirror\connect.bat ,,Hide
	;RunWait Mirror\hook.bat ,,Hide
	barstate +=25
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,250
	buildname := "adb connect " Clipboard
	;msgbox,%buildname%
	;runwait %comspec% /c Mirror\adb.exe %buildname%
	;RunWait, %comspec% /c Mirror\adb.exe %buildname%
	;Send, %buildname%{enter}
	FileDelete, Mirror\connect.bat
	FileAppend,
	(
@echo off
cd Mirror
%buildname%
timeout 1
	), Mirror\connect.bat
	RunWait Mirror\connect.bat ,,Hide
	barstate +=25
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,250
	deviceupdate(neutron)
}

killadb(neutron)
{
	barstate +=0
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,100
	FileDelete, Mirror\connect.bat
	FileAppend,
	(
@echo off
cd Mirror
adb kill-server
timeout 1
	), Mirror\connect.bat
	barstate +=50
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	RunWait Mirror\connect.bat ,,Hide
	barstate +=50
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,250
	selectme := neutron.doc.getElementById("mainselect2")
    while (selectme.firstChild) {
           selectme.removeChild(selectme.firstChild)
          }
	;deviceupdate(neutron)
	
}

connectip(neutron)
{
	barstate +=0
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	menuChoicetmp3 := neutron.doc.getElementById("targetname").value
	buildname := "adb connect " menuChoicetmp3 ":5555"
	FileDelete, Mirror\connect.bat
	FileAppend,
	(
@echo off
cd Mirror
%buildname%
timeout 1
	), Mirror\connect.bat
	barstate +=50
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,250
	RunWait Mirror\connect.bat ,,Hide
	barstate +=50
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)

	deviceupdate(neutron)
}

deviceupdate(neutron)
{
	barstate +=0
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,100
	FileDelete, Mirror\connect.bat
	FileAppend,
	(
@echo off
cd Mirror
del Adbdevices.txt
adb devices >>Adbdevices.txt
timeout 1
	), Mirror\connect.bat
	barstate +=25
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	RunWait Mirror\connect.bat ,,Hide
	barstate +=25
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,250
	boxupdate(neutron)
	barstate +=50
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,250
}


boxupdate(neutron)
{
	selectme := neutron.doc.getElementById("mainselect2")
    while (selectme.firstChild) {
           selectme.removeChild(selectme.firstChild)
          }

	FileRead, ADBDevices , Mirror\Adbdevices.txt
	;GuiControl,, Terminal , %ADBDevices%
	
	TF_RemoveLines("!Mirror\Adbdevices.txt", 0, 1)
	TF_Replace("!Mirror\Adbdevices.txt","device","")
	TF_RemoveBlankLines("!Mirror\Adbdevices.txt")
	TF_ReadLines("!Mirror\Adbdevices.txt")
	TF_Save("!Mirror\Adbdevices.txt" ,"!Mirror\Adbdevices.txt", OverWrite = 1)
	Lines:=TF_CountLines("Mirror\Adbdevices.txt")
	;GuiControl,, menuChoice, |
	loop,%Lines%
	{	
	FileReadLine, device1 , Mirror\Adbdevices.txt, 1
	test := neutron.doc.getElementById("mainselect2")
    test2 := neutron.doc.createElement("option")
    looper := device1
    test2.text := looper
    test.add(test2)
	
	;GuiControl,, menuChoice, %device1%|
	TF_Save("!Mirror\Adbdevices.txt" ,"!Mirror\Adbdevices.txt", OverWrite = 1)
	TF_RemoveLines("!Mirror\Adbdevices.txt", 0, 1)
	}
	neutron.doc.getElementById("mainselect2").focus()
	
}

startmirror(neutron)
{
	barstate +=0
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,100
	menuChoiceres := neutron.doc.getElementById("mainselect").value
	menuChoicename := neutron.doc.getElementById("mainselect2").value
	if (menuChoiceres="NoLimit")
	{
		buildname := "scrcpy -s " menuChoicename " --window-title " menuChoicename
	}
	else
	{
		buildname := "scrcpy -s " menuChoicename " -m " menuChoiceres " --window-title " menuChoicename
	}
	
	FileDelete, Mirror\connect.bat
	barstate +=50
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,250
	FileAppend,
	(
@echo off
cd Mirror
%buildname%
timeout 1
	), Mirror\connect.bat
	barstate +=50
	neutronjswrap("botststusbar","progbar",barstate "%",neutron)
	sleep,250
	Run Mirror\connect.bat ,,Hide
}

discordlink(neutron)
{
	Neutron := "https://discord.com/invite/ggRCXS2"
	run,%Neutron%
}

youtubelink(neutron)
{
	Neutron := "https://www.youtube.com/channel/UC5OzmTUVUxZAPTRJwpwHCYg"
	run,%Neutron%
}

githublink(neutron)
{
	Neutron := "https://github.com/DizzyduckAR/AutoMirror"
	run,%Neutron%
}

weblink(neutron)
{
	Neutron := "https://botplace.hopto.org/"
	run,%Neutron%
}


neutronjswrap(element,mode,var,neutron)
{
	;Element ID   / Element mode / Element var / neutron(must)

	;neutronjswrap("usernickfield","value",Nickname,neutron)
	if (mode = "value") ;push field data
	{
		neutron.doc.getElementById(element).value := var
		Return
	}


	;neutronjswrap("noxchk","checked","op1",neutron)  ;op1 is the box value=op1 in order to control it value must be set!
	if (mode = "checked") ; control radio/checkbox
	{
		neutron.doc.getElementById(element).checked := var
		Return
	}

	;neutronjswrap("lodertoptext","innerHTML","Loading User Token",neutron)
	if (mode = "innerHTML") ;control text data
	{
		neutron.doc.getElementById(element).innerHTML := var
		Return
	}

	;neutronjswrap("usertokenbar","progbar","100%",neutron)
	if (mode = "progbar") ; push prog bar
	{
		neutron.doc.getElementById(element).style.width := var
		Return
	}

	;neutronjswrap("gameimg","src",thumburl,neutron)
	if (mode = "src") ;push image
	{
		neutron.doc.getElementById(element).src := var
		Return
	}

	
	
	

	
}


SetTitle(neutron)
{
   
	neutron.doc.getElementById("titlebar123").innerHTML := "Auto Mirror  V" version
	
}



Neutron(neutron, event)
{
	; event.target will contain the HTML Element that fired the event.
	; Show a message box with its inner text.
	Neutron := "https://github.com/G33kDude/Neutron.ahk"
	run,%Neutron%
	;MsgBox, % "You clicked: " event.target.innerText
}

arazu(neutron, event)
{
	; event.target will contain the HTML Element that fired the event.
	; Show a message box with its inner text.
	Neutron := "https://github.com/DizzyduckAR"
	run,%Neutron%
	;MsgBox, % "You clicked: " event.target.innerText
}




AnimatedGifControl(GuiNameOrHwnd, GifFilePath, ControlOptions="") {
	Static
	Static CallCount := 0
	Local pos, ObjectName, bgColor
	; Create a variable name for ActiveX Object 
	ObjectName := "WB" ++CallCount
	
	; Retrieve the given image dimenstions
	AnimatedGifControl_GetImageDimensions(GifFilePath, GifWidth, GifHeight)
	if RegExMatch(ControlOptions, "O)(\s|^)(w(\d+))(\s|$)", oM) {
		GifWidth := oM.Value(3)
		StringReplace, ControlOptions, ControlOptions, % oM.Value(2),		; Remove the found option
	}
	if pos := RegExMatch(ControlOptions, "O)(\s|^)(h(\d+))(\s|$)", oM) {
		GifHeight := oM.Value(3)
		StringReplace, ControlOptions, ControlOptions, % oM.Value(2),		; Remove the found option
	}
	; Retrieve the background color option
	if RegExMatch(ControlOptions, "O)(\s|^)(bgc(\w{6}))(\s|$)", oM) {
		bgColor := oM.Value(3)
		StringReplace, ControlOptions, ControlOptions, % oM.Value(2),		; Remove the found option
	} else 
		bgColor := AnimatedGifControl_GetSysColor(15) ;COLOR_3DFACE :Face color for three-dimensional display elements and for dialog box backgrounds.
	
	; Add the Gif Animation Control
	Gui, %GuiNameOrHwnd%: Add, ActiveX, % "v" ObjectName " w" GifWidth " h" GifHeight " Disabled " ControlOptions , Shell.Explorer ;Mozilla.Browser
	%ObjectName%.Navigate("about:blank")
	;How Do you Stretch a Background Image in a Web Page
	;http://webdesign.about.com/od/css3/f/blfaqbgsize.htm	
	%ObjectName%.Document.Write("
	(Ltrim
		<html>
		<header>
			<style type='text/css'>
				img#bg {
					position:fixed;
					top:0;
					left:0;
					width:100%;
					height:100%;
				} 
			</style>
			<!--[if IE 6]>
			<![endif]-->
			<!--[if IE 6]>
				<style type='text/css'>
				html { overflow-y: hidden; }
				body { overflow-y: hidden; }
				img#bg { position:absolute; z-index:-1; }
				#content { position:static; }
				</style>
			<![endif]--> 			
		</header>
		<body style='height: 100%; width: 100%; margin: 0; padding: 0; overflow-x: hidden; overflow-y: hidden; background-color: #" bgColor ";' />
		<img src='" GifFilePath "' id='bg'  />
		</body>
		</html>
	)")
	
	%ObjectName%.Document.close
	%ObjectName% := ""	;release the object
	Return
}
AnimatedGifControl_GetImageDimensions(ImgPath, Byref width, Byref height) {
	DHW := A_DetectHiddenWIndows
	DetectHiddenWindows, ON
	Gui, AnimatedGifControl_GetImageDimensions: Add, Picture, hwndhWndImage, % ImgPath
	GuiControlGet, Image, AnimatedGifControl_GetImageDimensions:Pos, % hWndImage
	Gui, AnimatedGifControl_GetImageDimensions: Destroy
	DetectHiddenWindows, % DHW
	width := ImageW, 	height := ImageH
}

AnimatedGifControl_GetSysColor(d_element) {
	;Thanks SKAN ;http://www.autohotkey.com/forum/post-66521.html#66521
	A_FI:=A_FormatInteger
	SetFormat, Integer, Hex
	BGR:=DllCall("GetSysColor"
	 ,Int,d_element)+0x1000000
	SetFormat,Integer,%A_FI%
	StringMid,R,BGR,8,2
	StringMid,G,BGR,6,2
	StringMid,B,BGR,4,2
	RGB := R G B
	StringUpper,RGB,RGB
	Return RGB
}

/*
	by A_Samurai 
	2012/01/25 version 1.0.5
	Added:
	- background color option: bgcNNNNNN where Ns is 6-digit RGB color value.
	2012/01/24 version 1.0.4
	Added:
	- image resize support
	2012/01/22 version 1.0.3
	Removed:
	- the ObjectName parameter
	2012/01/22 version 1.0.2
	Fixed:
	- a bug that does not retrieve image dimensions properly.
	2012/01/22 version 1.0.1
	Fixed:
	- to use IE components from Firefox.
	Changed:
	- to allow wN and hN options.
	2012/01/22 version 1.0.0
	
	Licence: Public Domain
*/
Download(path_p, dLocation_p)
		{
			global path, dLocation, FullFileName, FullSize
			path = %path_p%
			dLocation = %dLocation_p%
			SplitPath, dLocation, FullFileName ; Splits input path to get the server filename
			FullSize := HttpQueryInfo(dLocation, 5) / 1000 ; get download file size in bytes
			Progress, H80, , Downloading..., %FullFileName% Download
			SetTimer, GetSize, 100
			UrlDownloadToFile, %dLocation%, %path%
			Progress, Off
			SetTimer, GetSize, Off
			Progress, Off
			Return
		}
		
		GetSize:
		FileOpen(path, "r")
		FileGetSize, FSize, %path%, K ; Get local file size in kb
		UpdateSize := Floor((FSize / FullSize) * 100) ; get percentage
		IfEqual, FSize, FullSize, Return
		IfNotEqual, ErrorLevel, 1
		Progress, %UpdateSize%, %UpdateSize%`% Complete, Downloading..., %FullFileName% ;<< %FullSize is showing as 211532.604000 hence i would like to show in MB, the file is actuallly 201.73 MB
		Return
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; HttpQueryInfo Function ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Source: post by olfen "DllCall: HttpQueryInfo - Get HTTP headers"
;                       http://www.autohotke...4567.html#64567
;
; For flag info, see: http://msdn.microsof...351(VS.85).aspx
		
		HttpQueryInfo(URL, QueryInfoFlag=21, Proxy="", ProxyBypass="") {
			hModule := DllCall("LoadLibrary", "str", dll := "wininet.dll")
			
; Adapt for build by 0x150||ISO
			ver := ( A_IsUnicode && !RegExMatch( A_AhkVersion, "\d+\.\d+\.4" ) ? "W" : "A" )
			InternetOpen := dll "\InternetOpen" ver
			HttpQueryInfo := dll "\HttpQueryInfo" ver
			InternetOpenUrl := dll "\InternetOpenUrl" ver
			
			If (Proxy != "")
				AccessType=3
			Else
				AccessType=1
			
			io_hInternet := DllCall( InternetOpen
, "str", ""
, "uint", AccessType
, "str", Proxy
, "str", ProxyBypass
, "uint", 0) ;dwFlags
			If (ErrorLevel != 0 or io_hInternet = 0) {
				DllCall("FreeLibrary", "uint", hModule)
				return, -1
			}
			
			iou_hInternet := DllCall( InternetOpenUrl
, "uint", io_hInternet
, "str", url
, "str", ""
, "uint", 0
, "uint", 0x80000000
, "uint", 0)
			If (ErrorLevel != 0 or iou_hInternet = 0) {
				DllCall("FreeLibrary", "uint", hModule)
				return, -1
			}
			
			VarSetCapacity(buffer, 1024, 0)
			VarSetCapacity(buffer_len, 4, 0)
			
			Loop, 5
			{
				hqi := DllCall( HttpQueryInfo
  , "uint", iou_hInternet
  , "uint", QueryInfoFlag
  , "uint", &buffer
  , "uint", &buffer_len
  , "uint", 0)
				If (hqi = 1) {
					hqi=success
					break
				}
			}
			
			IfNotEqual, hqi, success, SetEnv, res, timeout
			
			If (hqi = "success") {
				p := &buffer
				Loop
				{
					l := DllCall("lstrlen", "UInt", p)
					VarSetCapacity(tmp_var, l+1, 0)
					DllCall("lstrcpy", "Str", tmp_var, "UInt", p)
					p += l + 1
					res := res . tmp_var
					If (*p = 0)
						Break
				}
			}
			
			DllCall("wininet\InternetCloseHandle",  "uint", iou_hInternet)
			DllCall("wininet\InternetCloseHandle",  "uint", io_hInternet)
			DllCall("FreeLibrary", "uint", hModule)
			
			return, res
		}

SmartZip(s, o, t = 0x14)
{
	IfNotExist, %s%
		return, -1        ; The souce is not exist. There may be misspelling.
	
	oShell := ComObjCreate("Shell.Application")
	
	if (SubStr(o, -3) = ".zip")	; Zip
	{
		IfNotExist, %o%        ; Create the object ZIP file if it's not exist.
			CreateZip(o)
		
		Loop, %o%, 1
			sObjectLongName := A_LoopFileLongPath
		
		oObject := oShell.NameSpace(sObjectLongName)
		
		Loop, %s%, 1
		{
			if (sObjectLongName = A_LoopFileLongPath)
			{
				continue
			}
			ToolTip, Zipping %A_LoopFileName% ..
			oObject.CopyHere(A_LoopFileLongPath, t)
			SplitPath, A_LoopFileLongPath, OutFileName
			Loop
			{
				oObject := "", oObject := oShell.NameSpace(sObjectLongName)	; This doesn't affect the copyhere above.
				if oObject.ParseName(OutFileName)
					break
			}
		}
		ToolTip
	}
	else if InStr(FileExist(o), "D") or (!FileExist(o) and (SubStr(s, -3) = ".zip"))	; Unzip
	{
		if !o
			o := A_ScriptDir        ; Use the working dir instead if the object is null.
		else IfNotExist, %o%
			FileCreateDir, %o%
		
		Loop, %o%, 1
			sObjectLongName := A_LoopFileLongPath
		
		oObject := oShell.NameSpace(sObjectLongName)
		
		Loop, %s%, 1
		{
			oSource := oShell.NameSpace(A_LoopFileLongPath)
			oObject.CopyHere(oSource.Items, t)
		}
	}
}

CreateZip(n)	; Create empty Zip file
{
	ZIPHeader1 := "PK" . Chr(5) . Chr(6)
	VarSetCapacity(ZIPHeader2, 18, 0)
	ZIPFile := FileOpen(n, "w")
	ZIPFile.Write(ZIPHeader1)
	ZIPFile.RawWrite(ZIPHeader2, 18)
	ZIPFile.close()
}
;; ---------    FUNCTION END   ------------------------------------
