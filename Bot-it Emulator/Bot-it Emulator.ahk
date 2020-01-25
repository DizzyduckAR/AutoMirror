#NoEnv 
SendMode Input  
SetWorkingDir %A_ScriptDir%  
#SingleInstance,Force
#NoEnv
ListLines,Off
SetBatchLines,-1
pToken:=Gdip_Startup()
global HB_Button := []
global HB_Switch:=[]
global HB_RadioGroup1:=[]
global HB_RadioGroup2:=[]
HB_RadioGroup3:=[]

Main := New Custom_Window( x:= "" , y:= "" , w:= 390 , h:= 320 , Name:= "1" , Options:= "+AlwaysOnTop -DPIScale" , Title:= "Bot-it Emulator" )
Gui,1:Color,3A3C40,353738
Gui,1:-SysMenu
Gui,1:Add, Tab3, x0 y0 %w% %h% -Wrap -Theme cWhite AltSubmit +Bottom -E0x200 -0x200000 , Bot-It|Options
Gui,1:Add, Edit,x5  y10 w60 vBoxname -c63db83 -Center -E0x200 -0x200000,Name
Gui Font, Bold
Gui,1:Add, text,x270 y15 cWhite ,Little Boxes
Gui,1:Add, text,x80 y15 cWhite,CPU
Gui,1:Add, text,x80 y45 cWhite,HDD GB
Gui,1:Add, text,x80 y75 cWhite,RAM MB
Gui,1:Add, text,x80 y105 cWhite,ANDROID
Gui add, ListBox,x230 y40 w150 h200 vLittleBoxes gLittleboxClick  -ReadOnly -E0x200 -0x200000 c63db83
Gui Add, Link, x300 y260 w47 h19 -c63db83, <a href="https://discord.gg/CUgnVpk">Discord</a>
IfExist,Core\hoticon.png
{
	Gui,1:Add, Picture, x260 y250 w32 h32 , Core\hoticon.png
}

OnMessage(0x404, "AHK_NOTIFYICON") ;click tray icon to show


WM_LBUTTONDOWN(){
	if (A_Gui=1){
	PostMessage, 0xA1, 2    ; movable borderless window 
	}
}

AHK_NOTIFYICON(wParam, lParam){ ;click tray icon to show
	if (lParam = 0x202) {       ; WM_LBUTTONUP
		Gui,1:Show  				
	}else if (lParam = 0x203){   ; WM_LBUTTONDBLCLK
	}
}


HB_Button.Push( New HB_Flat_Rounded_Button_Type_1( x := 10 , y := 140 , w := 50 , h := 30 , Button_Color := "C1C1C1" , Button_Background_Color := "3A3C40" , Text := "Create" , Font := "Arial" , Font_Size := 12 " Bold" , Font_Color_Top := "63db83" , Font_Color_Bottom := "111111" , Window := "1" , Label := "Create" , Default_Button := 0 , Roundness:=8 ) )
HB_Button.Push( New HB_Flat_Rounded_Button_Type_1( x +=w+5 , y , w  , h , Button_Color := "C1C1C1" , Button_Background_Color , Text := "Save" , Font := "Segoe UI" , Font_Size := 12 " Bold" , Font_Color_Top := "63db83" , Font_Color_Bottom := "111111" , Window := "1" , Label := "Save" , Default_Button := 0 , Roundness:=8 ) )
HB_Button.Push( New HB_Flat_Rounded_Button_Type_1( x +=w+5 , y , w  , h , Button_Color := "C1C1C1" , Button_Background_Color , Text := "Start" , Font := "Segoe UI" , Font_Size := 12 " Bold" , Font_Color_Top := "63db83" , Font_Color_Bottom := "111111" , Window := "1" , Label := "Start" , Default_Button := 0 , Roundness:=8 ) )
HB_Button.Push( New HB_Flat_Rounded_Button_Type_1( x +=w-160 , y+=h+10 , w  , h , Button_Color := "C1C1C1" , Button_Background_Color , Text := "Delete" , Font := "Segoe UI" , Font_Size := 12 " Bold" , Font_Color_Top := "63db83" , Font_Color_Bottom := "111111" , Window := "1" , Label := "Delete" , Default_Button := 0 , Roundness:=8 ) )
HB_Button.Push( New HB_Flat_Rounded_Button_Type_1( 5 , y +=h+35 , w  , h , Button_Color := "C1C1C1" , Button_Background_Color , Text := "Close" , Font := "Segoe UI" , Font_Size := 12 " Bold" , Font_Color_Top := "63db83" , Font_Color_Bottom := "111111" , Window := "1" , Label := "Close" , Default_Button := 0 , Roundness:=8 ) )
HB_Button.Push( New HB_Flat_Rounded_Button_Type_1( 75 , y , w+20  , h , Button_Color := "C1C1C1" , Button_Background_Color , Text := "Minimize" , Font := "Segoe UI" , Font_Size := 12 " Bold" , Font_Color_Top := "63db83" , Font_Color_Bottom := "111111" , Window := "1" , Label := "Minimize" , Default_Button := 0 , Roundness:=8 ) )



global Up_Down1:=New Flat_UpDown_Type_1(x:=150,y:=10,Window:=1,Background_Color:="0xFF3A3C40",Value:=2,Min_Range:=1,Max_Range:=4,Interval:=1)
;global ud1:=% Val1 
global Up_Down2:=New Flat_UpDown_Type_1(x,y:=40,Window:=1,Background_Color ,Value:=8,Min_Range:=2,Max_Range:=20,Interval:=1)
;global ud2:=% Val1
global Up_Down3:=New Flat_UpDown_Type_1(x,y:=70,Window:=1,Background_Color ,Value:=2000,Min_Range:=1000,Max_Range:=4000,Interval:=1000)
;global ud3:=% Val1
;Up_Down4:=New Flat_UpDown_Type_1(x,y:=100,Window:=1,Background_Color ,Value:=9,Min_Range:=7,Max_Range:=10,Interval:=1)

global Up_Down4:=New Flat_UpDown_Type_1(x,y:=100,Window:=1,Background_Color ,Value:=9,Min_Range:=9,Max_Range:=9,Interval:=1)
;global ud4:=% Val1

;msgbox, %ud1% - %ud2% - %ud3% - %ud4%

Sleep, 10
;GuiControl,1:Focus,% Up_Down1.Hwnd
SetTimer,Boxlistview,20000
Main.Show_Window()

IfNotExist,emulator/emulator.exe
{
	MsgBox 0x40034, ERROR, No Emulator Found `n Allow Download?
	IfMsgBox Yes
	{
		IfNotExist,Emulator.zip
          {			
			Download("Emulator.zip", "https://dl.google.com/android/repository/emulator-windows-6120838.zip")
			loop
			{
				IfExist,Emulator.zip
				{
					break
				}
			}
		}
		
		IfExist,Emulator.zip
		{
			zipFolder=emulator
			zipname=Emulator.zip
			
			
			
			msgbox,4096,Extrac ,Extracting,2
			SmartZip(zipname,zipFolder)
			msgbox,4096,Done,%zipname% %zipFolder%,2
			
			FileMoveDir,emulator/emulator,emulator,2
		}
	}
}	
	
	IfNotExist,system-images\9\build.prop
	{
		MsgBox 0x40034, ERROR, No Android System Found `n Allow Download?
		IfMsgBox Yes
			
		{
			IfNotExist,system-images\x86-28_r09.zip
			{			
				Download("system-images\x86-28_r09.zip", "https://dl.google.com/android/repository/sys-img/google_apis_playstore/x86-28_r09.zip")
				loop
				{
					IfExist,system-images\x86-28_r09.zip
					{
						break
					}
				}
			}
			
			IfExist,system-images\x86-28_r09.zip
			{
				zipFolder=system-images
				zipname=system-images\x86-28_r09.zip
				
				FileRemoveDir,system-images/x86/,1
				
				msgbox,4096,Extrac ,Extracting,2
				SmartZip(zipname,zipFolder)
				msgbox,4096,Done,%zipname% %zipFolder%,2
				
				FileMoveDir,system-images/x86/,system-images/9/,2
				
			;msgbox,4096,%zipFolder%,%folderchecker%,2
				
			;sleep,2500
			;FileDelete,%folderchecker%%menuChoice%.zip
			;FileDelete,%folderchecker%NewUpdate.txt
			;FileRemoveDir,%zipFolder%,1
				
			}
		}
	}
	
	
	SetTimer, HB_Button_Hover , 50
	Gosub,Boxlistview
	return
	GuiClose:
	GuiContextMenu:
	ExitApp
	
	Move_Window(){
		PostMessage,0xA1,2
	}
	
	Min_Window(){
		Gui,1:Minimize
	}
	
	
	Start(){
		ToolTip,   
		GuiControl , % HB_Button[ A_GuiControl ].Window ": Focus" , % HB_Button[ A_GuiControl ].Hwnd
		if( ! HB_Button[ A_GuiControl ].Draw_Pressed() )
			return
		SetTimer,Boxlistview,off
		IfExist,%Boxname%.bat
		{
			Runwait, %Boxname%.bat,,Min,
		}
		DetectHiddenWindows, On
		;msgbox,1
		IfWinNotActive,"Auto-Mirror"
		{	
			
			;WinActive("Auto-Mirror v0.5")
			WinSet,AlwaysOnTop,On,Auto-Mirror
			sleep,50
			;GuiControlGet, OutputVar, Focus,
			;MsgBox %OutputVar%
			WinSet,AlwaysOnTop,off,Auto-Mirror
			close()
		}	
		
		
	}
		
		close(){
			ToolTip,Close
			GuiControl , % HB_Button[ A_GuiControl ].Window ": Focus" , % HB_Button[ A_GuiControl ].Hwnd
			if( ! HB_Button[ A_GuiControl ].Draw_Pressed() )
				return
			
			ExitApp
		}
		
		Minimize(){
			ToolTip,Minimize
			GuiControl , % HB_Button[ A_GuiControl ].Window ": Focus" , % HB_Button[ A_GuiControl ].Hwnd
			if( ! HB_Button[ A_GuiControl ].Draw_Pressed() )
				return
			
			Min_Window()
		}
		
		Boxlistview:
		{
			GuiControl, , LittleBoxes,%List%
			Loop %A_ScriptDir%\*.bat
				fList .= (A_Index=1 ? "" : "`n") SubStr(A_LoopFileName Sps,1,100) "|" A_LoopFileLongPath 
			
			Sort, fList, D`n   
			Loop, Parse, fList, `n,`r
			{
				fList=
				
				StringSplit,F, A_LoopField, |, %A_Space%
				LNK%A_Index%:=F2, List.=((A_Index=1) ? "" : "|") F1
				
				
			}
			
			
			GuiControl, , LittleBoxes,|
			GuiControl, , LittleBoxes,%List%
			list=
	;msgbox,%list% %fList%
			Gui, submit, nohide
			
			Return
			
		}
		
		delete:
		GuiControlGet, ItemName, , LittleBoxes
		StringReplace,Editbox1,ItemName,.bat,,All
		
		
		BoxStart=%Boxname%.bat
		BoxPath=avd/%Boxname%.avd/
		Boxconfig=avd/%Boxname%.ini
		Boxsysconfig=%BoxPath%config.ini
		
		FileDelete,%BoxStart%
		FileDelete,%Boxconfig%
		FileRemoveDir,%BoxPath%,1
		Reload
		
		
		LittleboxClick:
		GuiControlGet, ItemName, , LittleBoxes
		StringReplace,Editbox1,ItemName,.bat,,All
		
		global Boxname:=Editbox1
		BoxStart=%Boxname%.bat
		BoxPath=avd/%Boxname%.avd/
		Boxconfig=avd/%Boxname%.ini
		Boxsysconfig=%BoxPath%config.ini
		
		
		
		GuiControl,,Boxname,%Boxname%
		
		IniRead,Boxcpu,%Boxsysconfig%,Botit Emulator,hw.cpu.ncore
		Up_Down1.Value:=Boxcpu
		GuiControl,,% Up_Down1.hwnd4,% Up_Down1.Value
;msgbox,% Up_Down1.Value
		IniRead,BoxHDD,%Boxsysconfig%,Botit Emulator,disk.dataPartition.size
		StringReplace,BoxHDD,BoxHDD,G,,All
		Up_Down2.Value:=BoxHDD
;msgbox,% Up_Down2.Value
		GuiControl,,% Up_Down2.hwnd4,% Up_Down2.Value
		
		IniRead,BoxRam,%Boxsysconfig%,Botit Emulator,hw.ramSize
		Up_Down3.Value:=BoxRam
		GuiControl,,% Up_Down3.hwnd4,% Up_Down3.Value
		
		IniRead,BoxIMG,%Boxsysconfig%,Botit Emulator,image.sysdir.1
		
;IniWrite, %Boxname%, avd\%Boxname%.avd\Config.ini,Botit Emulator,AvdId
;msgbox,Boxcpu:%Boxcpu% BoxHDD:%BoxHDD% BoxRam:%BoxRam% BoxIMG:%BoxIMG%
;MsgBox,%Boxname% %BoxPath% %Boxconfig% %Boxsysconfig% %BoxStart%
		Return
		
		gui Submit
		return
		
		
		save:
		
		
		BoxPath=avd/%Boxname%.avd/
		Boxsysconfig=%BoxPath%config.ini
		
		IfExist,%BoxPath%config.ini
		{
			Edit1:=% up_down1.value
			Edit2:=% up_down2.value
			Edit3:=% up_down3.value
			Edit4:=% up_down4.value
			
			ControlGetText, OutputVar , edit1
	;IniWrite, %Boxname%, avd\%Boxname%.avd\Config.ini,Botit Emulator,AvdId
	;IniWrite, %Boxname%, avd\%Boxname%.avd\Config.ini,Botit Emulator,avd.ini.displayname
			IniWrite, %Edit1%, avd\%Boxname%.avd\Config.ini,Botit Emulator,hw.cpu.ncore
			IniWrite, %Edit2%G, avd\%Boxname%.avd\Config.ini,Botit Emulator,disk.dataPartition.size
			IniWrite, %Edit3%, avd\%Boxname%.avd\Config.ini,Botit Emulator,hw.ramSize
			IniWrite, system-images\%Edit4%\, avd\%Boxname%.avd\Config.ini,Botit Emulator,image.sysdir.1
			
			msgbox,4096,Save Done ,Save over,2
			Reload
	;msgbox,%boxname% %Edit1%
			
	;IniWrite,..\avd\%Boxname%.avd,avd\%Boxname%.ini,Botit Emulator,path
	;IniWrite,avd\%Boxname%.avd, avd\%Boxname%.ini,Botit Emulator,path.rel
		}
		
		IfnotExist,%BoxPath%config.ini
		{
			msgbox,4096,No Box, Box INI is missing
			
		}
		
		class Flat_UpDown_Type_1    {
			__New(x,y,Window:="1",Background_Color:="0xFF36373A",Value:=0,Min_Range:=0,Max_Range:=25000,Interval:=1){
				This.Arrow_Color_Default_Saved:="0xFFB6B7B9"
				This.Arrow_Color_Default:="0xFF5bcc3f"
				This.Arrow_Color_Pressed_Saved:="0xFFa6a7a9"
				This.Arrow_Color_Pressed:="0xFF8846C2"
				This.Interval:=Interval
				This.Value:=Value
				global valOut:=0
		;valOut:=% This.Value
		;msgbox, % valOut
				This.X:=x
				This.Y:=y
				This.W:=58
				This.H:=26
				This.Min_Range:=Min_Range
				This.Max_Range:=Max_Range
				This.Background_Color:=Background_Color
				This.Window:=Window
				This.Create_Default_Bitmap()
				This.Create_Up_Bitmap()
				This.Create_Down_Bitmap()
				This.Create_Trigger()
				sleep,20
				This.Draw_Default()
			}
			Create_Trigger(){
				Gui , % This.Window ": Add" , Picture , % "x" This.X " y" This.Y " w" This.W " h" This.H " 0xE hwndHwnd"
				This.Hwnd := hwnd
				Gui , % This.Window ": Add" , Text , % "x" This.X + 43 " y" This.Y + 1 " w12 h12 BackgroundTrans hwndHwnd"  
				This.Hwnd2 := hwnd
				BD := THIS.Add_Value.BIND( THIS )
				GUICONTROL +G , % This.Hwnd2 , % BD
				Gui , % This.Window ": Add" , Text , % "x" This.X + 43 " y" This.Y + 14 " w12 h12 BackgroundTrans hwndHwnd"  
				
				This.Hwnd3 := hwnd
				
				BD := THIS.Subtract_Value.BIND( THIS )
				GUICONTROL +G , % This.Hwnd3 , % BD
				Gui , % This.Window ":Font" , cWhite s8 Bold , Segoe UI
				
				Gui , % This.Window ": Add" , Edit , % "x" This.X + 5 " y" This.Y + 5 " w37 h16 -E0x200 Center ReadOnly hwndhwnd" , % This.Value
				
				
				This.Hwnd4:=hwnd
			}
			Create_Default_Bitmap(){
        ;Bitmap Created Using: HB Bitmap Maker
				pBitmap:=Gdip_CreateBitmap( 58 , 26 )
				G := Gdip_GraphicsFromImage( pBitmap )
				Gdip_SetSmoothingMode( G , 2 )
				Brush := Gdip_BrushCreateSolid( This.Background_Color )
				Gdip_FillRectangle( G , Brush , -1 , -1 , 62 , 28 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF4B4D53" )
				Gdip_FillRoundedRectangle( G , Brush , 3 , 6 , 51 , 17 , 2 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF292B2C" )
				Gdip_FillRoundedRectangle( G , Brush , 3 , 3 , 51 , 17 , 2 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF353738" )
				Gdip_FillRoundedRectangle( G , Brush , 3 , 5 , 51 , 17 , 2 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF5F6369" )
				Gdip_FillRectangle( G , Brush , 43 , 3 , 11 , 10 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF404347" )
				Gdip_FillRectangle( G , Brush , 44 , 4 , 9 , 8 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF5F6369" )
				Gdip_FillRectangle( G , Brush , 43 , 12 , 11 , 10 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF404347" )
				Gdip_FillRectangle( G , Brush , 44 , 14 , 9 , 8 )
				Gdip_DeleteBrush( Brush )
				Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
				Gdip_DrawLine( G , Pen , 43 , 3 , 43 , 22 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
				Gdip_DrawLine( G , Pen , 43 , 13 , 53 , 13 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 46 , 9 , 51 , 9 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 47 , 8 , 50 , 8 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 48 , 7 , 49 , 7 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 46 , 17 , 51 , 17 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 47 , 18 , 50 , 18 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 48 , 19 , 49 , 19 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
				Gdip_DrawRoundedRectangle( G , Pen , 3 , 3 , 51 , 19 , 1 )
				Gdip_DeletePen( Pen )
				Gdip_DeleteGraphics( G )
				This.Default_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
				Gdip_DisposeImage(pBitmap)
			}
			Create_Up_Bitmap(){
        ;Bitmap Created Using: HB Bitmap Maker
				pBitmap:=Gdip_CreateBitmap( 58 , 26 )
				G := Gdip_GraphicsFromImage( pBitmap )
				Gdip_SetSmoothingMode( G , 2 )
				Brush := Gdip_BrushCreateSolid( This.Background_Color )
				Gdip_FillRectangle( G , Brush , -1 , -1 , 62 , 28 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF4B4D53" )
				Gdip_FillRoundedRectangle( G , Brush , 3 , 6 , 51 , 17 , 2 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF292B2C" )
				Gdip_FillRoundedRectangle( G , Brush , 3 , 3 , 51 , 17 , 2 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF353738" )
				Gdip_FillRoundedRectangle( G , Brush , 3 , 5 , 51 , 17 , 2 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_CreateLineBrushFromRect( 43 , 3 , 42 , 11 , "0xFF1E2024" , "0xFF45484D" , 1 , 1 )
				Gdip_FillRectangle( G , Brush , 43 , 3 , 11 , 10 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF5F6369" )
				Gdip_FillRectangle( G , Brush , 43 , 13 , 11 , 9 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF404347" )
				Gdip_FillRectangle( G , Brush , 44 , 14 , 9 , 8 )
				Gdip_DeleteBrush( Brush )
				Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
				Gdip_DrawLine( G , Pen , 43 , 3 , 43 , 22 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( "0xFF2A2C2F" , 1 )
				Gdip_DrawLine( G , Pen , 43 , 13 , 53 , 13 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( "0xFF2A2C2F" , 1 )
				Gdip_DrawLine( G , Pen , 43 , 12 , 43 , 3 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Pressed , 1 )
				Gdip_DrawLine( G , Pen , 46 , 9 , 51 , 9 )  
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Pressed , 1 )
				Gdip_DrawLine( G , Pen , 47 , 8 , 50 , 8 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Pressed , 1 )
				Gdip_DrawLine( G , Pen , 48 , 7 , 49 , 7 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 46 , 17 , 51 , 17 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 47 , 18 , 50 , 18 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 48 , 19 , 49 , 19 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
				Gdip_DrawRoundedRectangle( G , Pen , 3 , 3 , 51 , 19 , 1 )
				Gdip_DeletePen( Pen )
				Gdip_DeleteGraphics( G )
				This.Up_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
				Gdip_DisposeImage(pBitmap)
			}
			Create_Down_Bitmap(){
        ;Bitmap Created Using: HB Bitmap Maker
				pBitmap:=Gdip_CreateBitmap( 58 , 26 )
				G := Gdip_GraphicsFromImage( pBitmap )
				Gdip_SetSmoothingMode( G , 2 )
				Brush := Gdip_BrushCreateSolid( This.Background_Color )
				Gdip_FillRectangle( G , Brush , -1 , -1 , 62 , 28 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF4B4D53" )
				Gdip_FillRoundedRectangle( G , Brush , 3 , 6 , 51 , 17 , 2 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF292B2C" )
				Gdip_FillRoundedRectangle( G , Brush , 3 , 3 , 51 , 17 , 2 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF353738" )
				Gdip_FillRoundedRectangle( G , Brush , 3 , 5 , 51 , 17 , 2 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_CreateLineBrushFromRect( 44 , 11 , 8 , 11 , "0xFF1E2024" , "0xFF45484D" , 1 , 1 )
				Gdip_FillRectangle( G , Brush , 43 , 11 , 11 , 10 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF5F6369" )
				Gdip_FillRectangle( G , Brush , 43 , 3 , 11 , 9 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF404347" )
				Gdip_FillRectangle( G , Brush , 44 , 4 , 9 , 8 )
				Gdip_DeleteBrush( Brush )
				Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
				Gdip_DrawLine( G , Pen , 43 , 3 , 43 , 22 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( "0xFF2A2C2F" , 1 )
				Gdip_DrawLine( G , Pen , 43 , 13 , 53 , 13 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( "0xFF2A2C2F" , 1 )
				Gdip_DrawLine( G , Pen , 43 , 21 , 43 , 13 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 46 , 9 , 51 , 9 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 47 , 8 , 50 , 8 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Default , 1 )
				Gdip_DrawLine( G , Pen , 48 , 7 , 49 , 7 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Pressed , 1 )
				Gdip_DrawLine( G , Pen , 46 , 17 , 51 , 17 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Pressed , 1 )
				Gdip_DrawLine( G , Pen , 47 , 18 , 50 , 18 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( This.Arrow_Color_Pressed , 1 )
				Gdip_DrawLine( G , Pen , 48 , 19 , 49 , 19 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
				Gdip_DrawRoundedRectangle( G , Pen , 3 , 3 , 51 , 19 , 1 )
				Gdip_DeletePen( Pen )
				Gdip_DeleteGraphics( G )
				This.Down_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
				Gdip_DisposeImage(pBitmap)
			}
			Draw_Default(){
				SetImage( This.Hwnd , This.Default_Bitmap )
			}
			Draw_Up(){
				SetImage( This.Hwnd , This.Up_Bitmap )
			}
			Draw_Down(){
				SetImage( This.Hwnd , This.Down_Bitmap )
			}
			Add_Value(){
				GuiControl , % This.Window ": Focus" , % This.Hwnd
				This.Draw_Up()
				GuiControl , % This.Window ": +Redraw" ,% This.hwnd4
				While( GetKeyState( "LButton" ) )
					sleep , 10
				This.Draw_Default()
				
        ;Credit   (HB Bitmap maker)
        ;-----------------------------------------------------------------------------------
				If ((CtrlValue := This.Value) < This.Max_Range) {
					CtrlValue += This.Interval
					If CtrlValue Is Float
						CtrlValue := Format("{1:0.2f}", CtrlValue)
					
			;msgbox, % CtrlValue
					
			;msgbox, % valOut
				}else if((CtrlValue := This.Value) >= This.Max_Range) {
					If CtrlValue Is Float
						CtrlValue := Format("{1:0.2f}", CtrlValue)
					
				}
				
				GuiControl, , % This.HWND4 , % (This.Value := CtrlValue)
		;global valOut1
		;valOut1:=% This.Value
				
				
				
		;msgbox, % valOut
			}
			Subtract_Value(){
				GuiControl , % This.Window ": Focus" , % This.Hwnd
				This.Draw_Down()
				GuiControl , % This.Window ": +Redraw" ,% This.hwnd4
				While( GetKeyState( "LButton" ) )
					sleep , 10
				This.Draw_Default()
        ;Credit just me
        ;-----------------------------------------------------------------------------------
				If ((CtrlValue := This.Value) > This.Min_Range) {
					CtrlValue -= This.Interval
					If CtrlValue Is Float
						CtrlValue := Format("{1:0.2f}", CtrlValue)
				}else if((CtrlValue := This.Value) <= This.Min_Range){
					If CtrlValue Is Float
						CtrlValue := Format("{1:0.2f}", CtrlValue)
				}
				GuiControl, , % This.HWND4 , % (This.Value := CtrlValue)
			}
		}
		
		class Flat_Round_Radio_Type_1   {
			__New(x,y,w:=19,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="36373A",HighLightColor:="1A1C1F",State:=0,GroupArray:=""){
				This.State:=State
				This.X:=x
				This.Y:=y
				This.W:=W
				This.H:=19
				This.Text:=Text
				This.Font:=Font
				This.FontSize:=FontSize
				This.FontColor:="0xFF" FontColor
				This.HighLightColor:= "0xFF" HighLightColor
				This.GroupArray:=GroupArray
				This.Name:=This.GroupArray.Length()+1
				This.Background_Color:="0xFF" Background_Color
				This.Window:=Window
				Loop,% This.GroupArray.Length() {
					if(This.GroupArray[A_Index].State=1){
						This.Value:=A_Index
						break
					}
				}
				Loop,% This.GroupArray.Length() {
					GroupArray[A_Index].Value:=This.Value
				}
				This.Create_Off_Bitmap()
				This.Create_On_Bitmap()
				This.Create_Trigger()
				sleep,20
				if(This.State)
					This.Draw_On()
				else
					This.Draw_Off()
			}
			Create_Trigger(){
				Gui , % This.Window ": Add" , Picture , % "x" This.X " y" This.Y " w" This.W " h" This.H " 0xE hwndHwnd"
				This.Hwnd:=hwnd
				BD := THIS.Switch_State.BIND( THIS )
				GUICONTROL +G , % This.Hwnd , % BD
			}
			Create_Off_Bitmap(){
        ;Bitmap Created Using: HB Bitmap Maker
				pBitmap:=Gdip_CreateBitmap( This.W , 19 )
				G := Gdip_GraphicsFromImage( pBitmap )
				Gdip_SetSmoothingMode( G , 2 )
				Brush := Gdip_BrushCreateSolid( This.Background_Color )
				Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 21 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF313436" )
				Gdip_FillEllipse( G , Brush , 1 , 1 , 17 , 17 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF1A1C1F" )
				Gdip_FillEllipse( G , Brush , 1 , 0 , 17 , 17 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_CreateLineBrushFromRect( 7 , 1 , 10 , 14 , "0xFF60646A" , "0xFF393B3F" , 1 , 1 )
        ;~ Brush := Gdip_BrushCreateSolid( This.HighLightColor )
				Gdip_FillEllipse( G , Brush , 2 , 1 , 15 , 15 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_CreateLineBrushFromRect( 7 , 2 , 10 , 14 , "0xFF4A4D52" , "0xFF393B3F" , 1 , 1 )
				Gdip_FillEllipse( G , Brush , 3 , 2 , 13 , 13 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF4D5055" )
				Gdip_FillEllipse( G , Brush , 7 , 7 , 5 , 6 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF222325" )
				Gdip_FillEllipse( G , Brush , 7 , 6 , 5 , 5 )
				Gdip_DeleteBrush( Brush )
        ;Adding text
        ;-------------------------------------------------------------
				Brush := Gdip_BrushCreateSolid( This.FontColor )
				Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x23 y0" , This.Font , This.W-23, This.H )
				Gdip_DeleteBrush( Brush )
        ;-------------------------------------------------------------
				Gdip_DeleteGraphics( G )
				This.Off_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
				Gdip_DisposeImage(pBitmap)
			}
			Create_On_Bitmap(){
        ;Bitmap Created Using: HB Bitmap Maker
				pBitmap:=Gdip_CreateBitmap( This.W , 19 )
				G := Gdip_GraphicsFromImage( pBitmap )
				Gdip_SetSmoothingMode( G , 2 )
				Brush := Gdip_BrushCreateSolid( This.Background_Color )
				Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 21 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF484A4B" )
				Gdip_FillEllipse( G , Brush , 1 , 1 , 17 , 17 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF1A1C1F" )
        ;~ Brush := Gdip_BrushCreateSolid( "0xFFA866E2" )
        ;~ Brush := Gdip_BrushCreateSolid( This.HighLightColor )
				Gdip_FillEllipse( G , Brush , 1 , 0 , 17 , 17 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF29292F" )
				Gdip_FillEllipse( G , Brush , 2 , 1 , 15 , 15 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_CreateLineBrushFromRect( 5 , 1 , 10 , 14 , "0xFF2E2F31" , "0xFF333337" , 1 , 1 )
				Gdip_FillEllipse( G , Brush , 3 , 2 , 13 , 13 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF4D5055" )
				Gdip_FillEllipse( G , Brush , 7 , 7 , 5 , 5 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( This.HighLightColor )
				Gdip_FillEllipse( G , Brush , 7 , 6 , 5 , 5 )
				Gdip_DeleteBrush( Brush )
        ;Adding text
        ;-------------------------------------------------------------
				Brush := Gdip_BrushCreateSolid( This.FontColor )
				Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x23 y0" , This.Font , This.W-23, This.H )
				Gdip_DeleteBrush( Brush )
        ;-------------------------------------------------------------
				Gdip_DeleteGraphics( G )
				This.On_Bitmap := Gdip_CreateHBITMAPFromBitmap( pBitmap )
				Gdip_DisposeImage( pBitmap )
			}
			Switch_State(){
				if(This.State!=1){
					This.State:=1
					This.Draw_On()
					Loop,% This.GroupArray.Length() {
						if(This.GroupArray[A_Index].Name!=This.Name){
							This.GroupArray[A_Index].State:=0
							This.GroupArray[A_Index].Draw_Off()
						}
					}
					Loop,% This.GroupArray.Length() {
						if(This.GroupArray[A_Index].State=1){
							This.Value:=A_Index
							break
						}
					}
					Loop,% This.GroupArray.Length() {
						This.GroupArray[A_Index].Value:=This.Value
					}
				}
        ;~ ( This.State := ! This.State ) ? ( This.Draw_On() ) : ( This.Draw_Off() )
        ;~ ToolTip,% This.Value "`n" This.State "`n" GroupArray[1].Value
			}
			Draw_Off(){
				SetImage( This.Hwnd , This.Off_Bitmap )
			}
			Draw_On(){
				SetImage( This.Hwnd , This.On_Bitmap )
			}
		}
		
		class Flat_Round_Switch_Type_1  {
			__New(x,y,w:=19,Text:="Text",Font:="Arial",FontSize:= "10 Bold" , FontColor:="FFFFFF" ,Window:="1",Background_Color:="0xFF36373A",State:=0){
				This.State:=State
				This.X:=x
				This.Y:=y
				This.W:=w
				This.H:=21
				This.Text:=Text
				This.Font:=Font
				This.FontSize:=FontSize
				This.FontColor:= "0xFF" FontColor
				This.Background_Color:=Background_Color
				This.Window:=Window
				This.Create_Off_Bitmap()
				This.Create_On_Bitmap()
				This.Create_Trigger()
				sleep,20
				if(This.State)
					This.Draw_On()
				else
					This.Draw_Off()
			}
			Create_Trigger(){
				Gui , % This.Window ": Add" , Picture , % "x" This.X " y" This.Y " w" This.W " h" This.H " 0xE hwndhwnd"
				This.Hwnd:=hwnd
				BD := THIS.Switch_State.BIND( THIS )
				GUICONTROL +G , % This.Hwnd , % BD
			}
			Create_Off_Bitmap(){
        ;Bitmap Created Using: HB Bitmap Maker
				pBitmap:=Gdip_CreateBitmap( This.W , 21 )
				G := Gdip_GraphicsFromImage( pBitmap )
				Gdip_SetSmoothingMode( G , 2 )
				Brush := Gdip_BrushCreateSolid( This.Background_Color )
				Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
				Gdip_DeleteBrush( Brush )
				Pen := Gdip_CreatePen( "0xFF44474A" , 1 )
				Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( "0xFF1B1D1E" , 1 )
				Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
				Gdip_DeletePen( Pen )
				Brush := Gdip_BrushCreateSolid( "0xFF262827" )
				Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , 26 , 13 , 5 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF303334" )
				Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 24 , 11 , 5 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0x8827282B" )
				Gdip_FillEllipse( G , Brush , 0 , 0 , 18 , 18 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF1A1C1F" )
				Gdip_FillEllipse( G , Brush , 0 , 0 , 17 , 17 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFF60646A" , "0xFF393B3F" , 1 , 1 )
				Gdip_FillEllipse( G , Brush , 1 , 1 , 15 , 15 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFF4D5055" , "0xFF36383B" , 1 , 1 )
				Gdip_FillEllipse( G , Brush , 2 , 2 , 13 , 13 )
				Gdip_DeleteBrush( Brush )
        ;Adding text
        ;-------------------------------------------------------------
				Brush := Gdip_BrushCreateSolid( This.FontColor )
				Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
				Gdip_DeleteBrush( Brush )
        ;-------------------------------------------------------------
				Gdip_DeleteGraphics( G )
				This.Off_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
				Gdip_DisposeImage(pBitmap)
			}
			Create_On_Bitmap(){
        ;Bitmap Created Using: HB Bitmap Maker
				pBitmap:=Gdip_CreateBitmap( This.W , 21 )
				G := Gdip_GraphicsFromImage( pBitmap )
				Gdip_SetSmoothingMode( G , 2 )
				Brush := Gdip_BrushCreateSolid( This.Background_Color )
				Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , 23 )
				Gdip_DeleteBrush( Brush )
				Pen := Gdip_CreatePen( "0xFF44474A" , 1 )
				Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 14 , 5 )
				Gdip_DeletePen( Pen )
				Pen := Gdip_CreatePen( "0xFF1B1D1E" , 1 )
				Gdip_DrawRoundedRectangle( G , Pen , 1 , 2 , 26 , 13 , 5 )
				Gdip_DeletePen( Pen )
        ;~ Brush := Gdip_BrushCreateSolid( "0xFF1C538A" )
				Brush := Gdip_BrushCreateSolid( "0xFF20fa07" )
				Gdip_FillRoundedRectangle( G , Brush , 2 , 3 , 25 , 11 , 5 )
				Gdip_DeleteBrush( Brush )
        ;~ Brush := Gdip_BrushCreateSolid( "0xFF2672B3" )
				Brush := Gdip_BrushCreateSolid( "0xFF20fa07" )
        ;~ Brush := Gdip_BrushCreateSolid( "0xFFA866E2" )
				Gdip_FillRoundedRectangle( G , Brush , 2 , 5 , 23 , 9 , 4 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0x8827282B" )
				Gdip_FillEllipse( G , Brush , 11 , 0 , 18 , 18 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF1A1C1F" )
				Gdip_FillEllipse( G , Brush , 11 , 0 , 17 , 17 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_CreateLineBrushFromRect( 3 , 2 , 11 , 14 , "0xFF60646A" , "0xFF393B3F" , 1 , 1 )
				Gdip_FillEllipse( G , Brush , 12 , 1 , 15 , 15 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 10 , 12 , "0xFF4D5055" , "0xFF36383B" , 1 , 1 )
				Gdip_FillEllipse( G , Brush , 13 , 2 , 13 , 13 )
				Gdip_DeleteBrush( Brush )
        ;Adding text
        ;-------------------------------------------------------------
				Brush := Gdip_BrushCreateSolid( This.FontColor )
				Gdip_TextToGraphics( G , This.Text , "s" This.FontSize " vCenter c" Brush " x33 y0" , This.Font , This.W-33, This.H )
				Gdip_DeleteBrush( Brush )
        ;-------------------------------------------------------------
				Gdip_DeleteGraphics( G )
				This.On_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
				Gdip_DisposeImage(pBitmap)
			}
			Switch_State(){
				(This.State:=!This.State)?(This.Draw_On()):(This.Draw_Off())
        ;~ This.State:=!This.State
        ;~ If(This.State)
            ;~ This.Draw_On()
        ;~ else
            ;~ This.Draw_Off()
			}
			Draw_Off(){
				SetImage( This.Hwnd , This.Off_Bitmap )
			}
			Draw_On(){
				SetImage( This.Hwnd , This.On_Bitmap )
			}
		}
		
		class HB_Flat_Rounded_Button_Type_1 {
			__New( x := 10 , y := 10 , w := 150 , h := 40 , Button_Color := "FF0000" , Button_Background_Color := "222222" , Text := "Button" , Font := "Arial" , Font_Size := 16 , Font_Color_Top := "000000" , Font_Color_Bottom := "FFFFFF" , Window := "1" , Label := "" , Default_Button := 1, Roundness:=5 ){
				This.Roundness:=Roundness
				This.Text_Color_Top := "0xFF" Font_Color_Top , This.Text_Color_Bottom := "0xFF" Font_Color_Bottom , This.Font := Font , This.Font_Size := Font_Size , This.Text := Text
				This.X := x , This.Y := y , This.W := w , This.H := h , This.Button_Background_Color := "0xFF" Button_Background_Color , This.Button_Color := "0xFF" Button_Color , This.Window := Window
				This.Label := Label , This.Default_Button := Default_Button , This.Create_Default_Bitmap() , This.Create_Hover_Bitmap() , This.Create_Pressed_Bitmap() , This.Create_Trigger()
				sleep, 20
				This.Draw_Default()
			}
			Create_Trigger(){
				global
				num := HB_Button.Length()+1
				Gui , % This.Window ": Add" , Picture , % "x" This.X " y" This.Y " w" This.W " h" This.H " hwndHwnd v" Num " g" This.Label " 0xE"
				This.Number := Num , This.Hwnd := Hwnd
			}
			Create_Default_Bitmap(){
        ;Bitmap Created Using: HB Bitmap Maker
				pBitmap:=Gdip_CreateBitmap( This.W , This.H ) ;96x29
				G := Gdip_GraphicsFromImage( pBitmap )
				Gdip_SetSmoothingMode( G , 2 )
				Brush := Gdip_BrushCreateSolid( This.Button_Background_Color )
				Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , This.H+2 )
				Gdip_DeleteBrush( Brush )
        ;~ Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF61646A" , "0xFF1E1114" , 1 , 1 )
				Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF61646A" , "0xFF2E2124" , 1 , 1 )
				Gdip_FillRoundedRectangle( G , Brush , 0 , 1 , This.W , This.H-3 , This.Roundness )
				Gdip_DeleteBrush( Brush )
        ;~ if(This.Default_Button)
				Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF4C4F54" , "0xFF35373B" , 1 , 1 )
        ;~ else    
            ;~ Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF0066aa" , "0xFF35373B" , 1 , 1 )
				Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , This.W-2 , This.H-5 , This.Roundness )
				Gdip_DeleteBrush( Brush )
				Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
				Gdip_DrawRoundedRectangle( G , Pen , 0 , 0 , This.W-1 , This.H-3 , This.Roundness )
				Gdip_DeletePen( Pen )
				Brush := Gdip_BrushCreateSolid( This.Text_Color_Bottom )
				Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x1 y1 " , This.Font , This.W , This.H-1 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( This.Text_Color_Top )
				Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x0 y0 " , This.Font , This.W , This.H-1 )
				Gdip_DeleteBrush( Brush )
				Gdip_DeleteGraphics( G )
				This.Default_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
				Gdip_DisposeImage(pBitmap)
			}
			Create_Hover_Bitmap(){
        ;Bitmap Created Using: HB Bitmap Maker
				pBitmap:=Gdip_CreateBitmap( This.W , This.H ) ;96x29
				G := Gdip_GraphicsFromImage( pBitmap )
				Gdip_SetSmoothingMode( G , 2 )
				Brush := Gdip_BrushCreateSolid( This.Button_Background_Color )
				Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , This.H+2 )
				Gdip_DeleteBrush( Brush )
        ;~ Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF61646A" , "0xFF1E1114" , 1 , 1 )
				Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF61646A" , "0xFF2E2124" , 1 , 1 )
				Gdip_FillRoundedRectangle( G , Brush , 0 , 1 , This.W , This.H-3 , This.Roundness )
				Gdip_DeleteBrush( Brush )
				if(This.Default_Button)
					Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF55585D" , "0xFF3B3E41" , 1 , 1 )
            ;~ Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xaa0066aa" , "0xFF3B3E41" , 1 , 1 )
				else
					Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0x44A826A2" , "0xFF3B3E41" , 1 , 1 )
            ;~ Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF75787D" , "0xFF3B3E41" , 1 , 1 )
				Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , This.W-2 , This.H-5 , This.Roundness )
				Gdip_DeleteBrush( Brush )
				Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
				Gdip_DrawRoundedRectangle( G , Pen , 0 , 0 , This.W-1 , This.H-3 , This.Roundness )
				Gdip_DeletePen( Pen )
				Brush := Gdip_BrushCreateSolid( This.Text_Color_Bottom )
				Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x1 y1" , This.Font , This.W , This.H-1 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( This.Text_Color_Top )
				Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x0 y0" , This.Font , This.W , This.H-1 )
				Gdip_DeleteBrush( Brush )
				Gdip_DeleteGraphics( G )
				This.Hover_Bitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
				Gdip_DisposeImage(pBitmap)
			}
			Create_Pressed_Bitmap(){
				pBitmap:=Gdip_CreateBitmap( This.W , This.H ) ;96x29
				G := Gdip_GraphicsFromImage( pBitmap )
				Gdip_SetSmoothingMode( G , 2 )
				Brush := Gdip_BrushCreateSolid( This.Button_Background_Color )
				Gdip_FillRectangle( G , Brush , -1 , -1 , This.W+2 , This.H+2 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , "0xFF2A2C2E" , "0xFF45474E" , 1 , 1 )
				Gdip_FillRoundedRectangle( G , Brush , 0 , 1 , This.W , This.H-3 , This.Roundness )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF2A2C2E" )
				Gdip_FillRoundedRectangle( G , Brush , 0 , 0 , This.W , This.H-8 , This.Roundness )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( "0xFF46474D" )
				Gdip_FillRoundedRectangle( G , Brush , 0 , 7 , This.W , This.H-8 , This.Roundness )
				Gdip_DeleteBrush( Brush )
        ;~ if(This.Default_Button)
            ;~ Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 87 , 22 , "0xFF333639" , "0xFF43474B" , 1 , 1 )
				Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , This.W ,This.H-7 , "0xFF333639" , "0xFF43474B" , 1 , 1 )
            ;~ Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , 96 , 29 , "0xFF232629" , "0xFF53575B" , 1 , 1 )
        ;~ else
            ;~ Brush := Gdip_CreateLineBrushFromRect( 5 , 3 , 87 , 22 , "0xFF333639" , "0xFF0066aa" , 1 , 1 )
        ;~ Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , This.W-3 , This.H-6 , 5 )
				Gdip_FillRoundedRectangle( G , Brush , 1 , 2 , This.W-3 , This.H-6 , This.Roundness )
				Gdip_DeleteBrush( Brush )
				Pen := Gdip_CreatePen( "0xFF1A1C1F" , 1 )
				Gdip_DrawRoundedRectangle( G , Pen , 0 , 0 , This.W-1 , This.H-3 , This.Roundness )
				Gdip_DeletePen( Pen )
				Brush := Gdip_BrushCreateSolid( This.Text_Color_Bottom )
				Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x1 y2" , This.Font , This.W , This.H-1 )
				Gdip_DeleteBrush( Brush )
				Brush := Gdip_BrushCreateSolid( This.Text_Color_Top )
				Gdip_TextToGraphics( G , This.Text , "s" This.Font_Size " Center vCenter c" Brush " x0 y1" , This.Font , This.W , This.H-1 )
				Gdip_DeleteBrush( Brush )
				Gdip_DeleteGraphics( G )
				This.Pressed_Bitmap := Gdip_CreateHBITMAPFromBitmap( pBitmap )
				Gdip_DisposeImage( pBitmap )
			}
			Draw_Default(){
				SetImage( This.Hwnd , This.Default_Bitmap )
			}
			Draw_Hover(){
				SetImage( This.Hwnd , This.Hover_Bitmap )
			}
			Draw_Pressed(){
				SetImage( This.Hwnd , This.Pressed_Bitmap )
				SetTimer , HB_Button_Hover , Off
				While( GetKeyState( "LButton" ) )
					sleep , 10
				SetTimer , HB_Button_Hover , On
				MouseGetPos,,,, ctrl , 2
				if( This.Hwnd != ctrl ){
					This.Draw_Default()
					return False
				}else   {
					This.Draw_Hover()
					return true
				}
			}
		}
		
		HB_Button_Hover(){
			Static Index , Hover_On
			MouseGetPos,,,, ctrl , 2
			if( ! Hover_On && ctrl ){
				loop , % HB_Button.Length()
					if( ctrl = HB_Button[ A_Index ].hwnd )
						HB_Button[ A_Index ].Draw_Hover() , Index := A_Index , Hover_On := 1 , break
			}else if( Hover_On = 1 )
				if( ctrl != HB_Button[ Index ].Hwnd )
					HB_Button[ Index ].Draw_Default() , Hover_On := 0
		}
		
		Class Custom_Window {
			__New(x:="",y:="",w:=300,h:=200,Name:=1,Options:="+AlwaysOnTop -Caption -DPIScale",Title:="",Background_Bitmap:=""){
				This.X:=x
				This.Y:=y
				This.W:=w
				This.H:=h
				This.Name:=Name
				This.Title:=Title
				This.Options:=Options
				This.Background_Bitmap:=Background_Bitmap
				This.Create_Window()
			}
			Create_Window(){
				Gui,% This.Name ":New",%  This.Options " +LastFound"
				This.Hwnd:=WinExist()
				if(This.Background_Bitmap)
					This.Draw_Background_Bitmap()
			}
			Draw_Background_Bitmap(){
				This.Bitmap:=Gdip_CreateHBITMAPFromBitmap(This.Background_Bitmap)
				Gdip_DisposeImage(This.Background_Bitmap)
				Gui,% This.Name ":Add",Picture,% "x0 y0 w" This.W " h" This.H " 0xE"
				GuiControlGet,hwnd,% This.Name ":hwnd",Static1
				This.Background_Hwnd:=hwnd
				SetImage(This.Background_Hwnd,This.Bitmap)
			}
			Show_Window(){
				if(This.X&&This.Y)
					Gui,% This.Name ":Show",% "x" This.X " y" This.Y " w" This.W " h" This.H,% This.Title
				else if(This.X&&!This.Y)
					Gui,% This.Name ":Show",% "x" This.X  " w" This.W " h" This.H,% This.Title
				else if(!This.X&&This.Y)
					Gui,% This.Name ":Show",% "y" This.Y  " w" This.W " h" This.H,% This.Title
				else
					Gui,% This.Name ":Show",% " w" This.W " h" This.H,% This.Title
			}
		}
		
		
;######################################################################################################################################
;#####################################################                          #######################################################
;#####################################################        Gdip LITE         #######################################################
;#####################################################                          #######################################################
;######################################################################################################################################
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
		BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster=""){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdi32\BitBlt", Ptr, dDC, "int", dx, "int", dy, "int", dw, "int", dh, Ptr, sDC, "int", sx, "int", sy, "uint", Raster ? Raster : 0x00CC0020)
		}
		Gdip_DrawImage(pGraphics, pBitmap, dx="", dy="", dw="", dh="", sx="", sy="", sw="", sh="", Matrix=1){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			if (Matrix&1 = "")
				ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
			else if (Matrix != 1)
				ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
			if(sx = "" && sy = "" && sw = "" && sh = ""){
				if(dx = "" && dy = "" && dw = "" && dh = ""){
					sx := dx := 0, sy := dy := 0
					sw := dw := Gdip_GetImageWidth(pBitmap)
					sh := dh := Gdip_GetImageHeight(pBitmap)
				}else   {
					sx := sy := 0,sw := Gdip_GetImageWidth(pBitmap),sh := Gdip_GetImageHeight(pBitmap)
				}
			}
			E := DllCall("gdiplus\GdipDrawImageRectRect", Ptr, pGraphics, Ptr, pBitmap, "float", dx, "float", dy, "float", dw, "float", dh, "float", sx, "float", sy, "float", sw, "float", sh, "int", 2, Ptr, ImageAttr, Ptr, 0, Ptr, 0)
			if ImageAttr
				Gdip_DisposeImageAttributes(ImageAttr)
			return E
		}
		Gdip_SetImageAttributesColorMatrix(Matrix){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			VarSetCapacity(ColourMatrix, 100, 0)
			Matrix := RegExReplace(RegExReplace(Matrix, "^[^\d-\.]+([\d\.])", "$1", "", 1), "[^\d-\.]+", "|")
			StringSplit, Matrix, Matrix, |
			Loop, 25
			{
				Matrix := (Matrix%A_Index% != "") ? Matrix%A_Index% : Mod(A_Index-1, 6) ? 0 : 1
				NumPut(Matrix, ColourMatrix, (A_Index-1)*4, "float")
			}
			DllCall("gdiplus\GdipCreateImageAttributes", A_PtrSize ? "UPtr*" : "uint*", ImageAttr)
			DllCall("gdiplus\GdipSetImageAttributesColorMatrix", Ptr, ImageAttr, "int", 1, "int", 1, Ptr, &ColourMatrix, Ptr, 0, "int", 0)
			return ImageAttr
		}
		Gdip_GetImageWidth(pBitmap){
			DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Width)
			return Width
		}
		Gdip_GetImageHeight(pBitmap){
			DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Height)
			return Height
		}
		Gdip_DeletePen(pPen){
			return DllCall("gdiplus\GdipDeletePen", A_PtrSize ? "UPtr" : "UInt", pPen)
		}
		Gdip_DeleteBrush(pBrush){
			return DllCall("gdiplus\GdipDeleteBrush", A_PtrSize ? "UPtr" : "UInt", pBrush)
		}
		Gdip_DisposeImage(pBitmap){
			return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
		}
		Gdip_DeleteGraphics(pGraphics){
			return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
		}
		Gdip_DisposeImageAttributes(ImageAttr){
			return DllCall("gdiplus\GdipDisposeImageAttributes", A_PtrSize ? "UPtr" : "UInt", ImageAttr)
		}
		Gdip_DeleteFont(hFont){
			return DllCall("gdiplus\GdipDeleteFont", A_PtrSize ? "UPtr" : "UInt", hFont)
		}
		Gdip_DeleteStringFormat(hFormat){
			return DllCall("gdiplus\GdipDeleteStringFormat", A_PtrSize ? "UPtr" : "UInt", hFormat)
		}
		Gdip_DeleteFontFamily(hFamily){
			return DllCall("gdiplus\GdipDeleteFontFamily", A_PtrSize ? "UPtr" : "UInt", hFamily)
		}
		CreateCompatibleDC(hdc=0){
			return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
		}
		SelectObject(hdc, hgdiobj){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
		}
		DeleteObject(hObject){
			return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
		}
		GetDC(hwnd=0){
			return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
		}
		GetDCEx(hwnd, flags=0, hrgnClip=0){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("GetDCEx", Ptr, hwnd, Ptr, hrgnClip, "int", flags)
		}
		ReleaseDC(hdc, hwnd=0){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
		}
		DeleteDC(hdc){
			return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
		}
		Gdip_SetClipRegion(pGraphics, Region, CombineMode=0){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdiplus\GdipSetClipRegion", Ptr, pGraphics, Ptr, Region, "int", CombineMode)
		}
		CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			hdc2 := hdc ? hdc : GetDC()
			VarSetCapacity(bi, 40, 0)
			NumPut(w, bi, 4, "uint"), NumPut(h, bi, 8, "uint"), NumPut(40, bi, 0, "uint"), NumPut(1, bi, 12, "ushort"), NumPut(0, bi, 16, "uInt"), NumPut(bpp, bi, 14, "ushort")
			hbm := DllCall("CreateDIBSection", Ptr, hdc2, Ptr, &bi, "uint", 0, A_PtrSize ? "UPtr*" : "uint*", ppvBits, Ptr, 0, "uint", 0, Ptr)
			if !hdc
				ReleaseDC(hdc2)
			return hbm
		}
		Gdip_GraphicsFromImage(pBitmap){
			DllCall("gdiplus\GdipGetImageGraphicsContext", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
			return pGraphics
		}
		Gdip_GraphicsFromHDC(hdc){
			DllCall("gdiplus\GdipCreateFromHDC", A_PtrSize ? "UPtr" : "UInt", hdc, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
			return pGraphics
		}
		Gdip_GetDC(pGraphics){
			DllCall("gdiplus\GdipGetDC", A_PtrSize ? "UPtr" : "UInt", pGraphics, A_PtrSize ? "UPtr*" : "UInt*", hdc)
			return hdc
		}
		
		
		Gdip_Startup(){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
				DllCall("LoadLibrary", "str", "gdiplus")
			VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
			DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
			return pToken
		}
		Gdip_TextToGraphics(pGraphics, Text, Options, Font="Arial", Width="", Height="", Measure=0){
			IWidth := Width, IHeight:= Height
			RegExMatch(Options, "i)X([\-\d\.]+)(p*)", xpos)
			RegExMatch(Options, "i)Y([\-\d\.]+)(p*)", ypos)
			RegExMatch(Options, "i)W([\-\d\.]+)(p*)", Width)
			RegExMatch(Options, "i)H([\-\d\.]+)(p*)", Height)
			RegExMatch(Options, "i)C(?!(entre|enter))([a-f\d]+)", Colour)
			RegExMatch(Options, "i)Top|Up|Bottom|Down|vCentre|vCenter", vPos)
			RegExMatch(Options, "i)NoWrap", NoWrap)
			RegExMatch(Options, "i)R(\d)", Rendering)
			RegExMatch(Options, "i)S(\d+)(p*)", Size)
			if !Gdip_DeleteBrush(Gdip_CloneBrush(Colour2))
				PassBrush := 1, pBrush := Colour2
			if !(IWidth && IHeight) && (xpos2 || ypos2 || Width2 || Height2 || Size2)
				return -1
			Style := 0, Styles := "Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
			Loop, Parse, Styles, |
			{
				if RegExMatch(Options, "\b" A_loopField)
					Style |= (A_LoopField != "StrikeOut") ? (A_Index-1) : 8
			}
			Align := 0, Alignments := "Near|Left|Centre|Center|Far|Right"
			Loop, Parse, Alignments, |
			{
				if RegExMatch(Options, "\b" A_loopField)
					Align |= A_Index//2.1      ; 0|0|1|1|2|2
			}
			xpos := (xpos1 != "") ? xpos2 ? IWidth*(xpos1/100) : xpos1 : 0
			ypos := (ypos1 != "") ? ypos2 ? IHeight*(ypos1/100) : ypos1 : 0
			Width := Width1 ? Width2 ? IWidth*(Width1/100) : Width1 : IWidth
			Height := Height1 ? Height2 ? IHeight*(Height1/100) : Height1 : IHeight
			if !PassBrush
				Colour := "0x" (Colour2 ? Colour2 : "ff000000")
			Rendering := ((Rendering1 >= 0) && (Rendering1 <= 5)) ? Rendering1 : 4
			Size := (Size1 > 0) ? Size2 ? IHeight*(Size1/100) : Size1 : 12
			hFamily := Gdip_FontFamilyCreate(Font)
			hFont := Gdip_FontCreate(hFamily, Size, Style)
			FormatStyle := NoWrap ? 0x4000 | 0x1000 : 0x4000
			hFormat := Gdip_StringFormatCreate(FormatStyle)
			pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour)
			if !(hFamily && hFont && hFormat && pBrush && pGraphics)
				return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0
			CreateRectF(RC, xpos, ypos, Width, Height)
			Gdip_SetStringFormatAlign(hFormat, Align)
			Gdip_SetTextRenderingHint(pGraphics, Rendering)
			ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
			if vPos
			{
				StringSplit, ReturnRC, ReturnRC, |
				if (vPos = "vCentre") || (vPos = "vCenter")
					ypos += (Height-ReturnRC4)//2
				else if (vPos = "Top") || (vPos = "Up")
					ypos := 0
				else if (vPos = "Bottom") || (vPos = "Down")
					ypos := Height-ReturnRC4
				CreateRectF(RC, xpos, ypos, Width, ReturnRC4)
				ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
			}
			if !Measure
				E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)
			if !PassBrush
				Gdip_DeleteBrush(pBrush)
			Gdip_DeleteStringFormat(hFormat)
			Gdip_DeleteFont(hFont)
			Gdip_DeleteFontFamily(hFamily)
			return E ? E : ReturnRC
		}
		Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, ByRef RectF){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			if (!A_IsUnicode)
			{
				nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, 0, "int", 0)
				VarSetCapacity(wString, nSize*2)
				DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
			}
			return DllCall("gdiplus\GdipDrawString", Ptr, pGraphics, Ptr, A_IsUnicode ? &sString : &wString, "int", -1, Ptr, hFont, Ptr, &RectF, Ptr, hFormat, Ptr, pBrush)
		}
		Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode=1){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			CreatePointF(PointF1, x1, y1), CreatePointF(PointF2, x2, y2)
			DllCall("gdiplus\GdipCreateLineBrush", Ptr, &PointF1, Ptr, &PointF2, "Uint", ARGB1, "Uint", ARGB2, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
			return LGpBrush
		}
		Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode=1, WrapMode=1){
			CreateRectF(RectF, x, y, w, h)
			DllCall("gdiplus\GdipCreateLineBrushFromRect", A_PtrSize ? "UPtr" : "UInt", &RectF, "int", ARGB1, "int", ARGB2, "int", LinearGradientMode, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
			return LGpBrush
		}
		Gdip_CloneBrush(pBrush){
			DllCall("gdiplus\GdipCloneBrush", A_PtrSize ? "UPtr" : "UInt", pBrush, A_PtrSize ? "UPtr*" : "UInt*", pBrushClone)
			return pBrushClone
		}
		Gdip_FontFamilyCreate(Font){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			if (!A_IsUnicode)
			{
				nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, "uint", 0, "int", 0)
				VarSetCapacity(wFont, nSize*2)
				DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, Ptr, &wFont, "int", nSize)
			}
			DllCall("gdiplus\GdipCreateFontFamilyFromName", Ptr, A_IsUnicode ? &Font : &wFont, "uint", 0, A_PtrSize ? "UPtr*" : "UInt*", hFamily)
			return hFamily
		}
		Gdip_SetStringFormatAlign(hFormat, Align){
			return DllCall("gdiplus\GdipSetStringFormatAlign", A_PtrSize ? "UPtr" : "UInt", hFormat, "int", Align)
		}
		Gdip_StringFormatCreate(Format=0, Lang=0){
			DllCall("gdiplus\GdipCreateStringFormat", "int", Format, "int", Lang, A_PtrSize ? "UPtr*" : "UInt*", hFormat)
			return hFormat
		}
		Gdip_FontCreate(hFamily, Size, Style=0){
			DllCall("gdiplus\GdipCreateFont", A_PtrSize ? "UPtr" : "UInt", hFamily, "float", Size, "int", Style, "int", 0, A_PtrSize ? "UPtr*" : "UInt*", hFont)
			return hFont
		}
		Gdip_CreatePen(ARGB, w){
			DllCall("gdiplus\GdipCreatePen1", "UInt", ARGB, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
			return pPen
		}
		Gdip_CreatePenFromBrush(pBrush, w){
			DllCall("gdiplus\GdipCreatePen2", A_PtrSize ? "UPtr" : "UInt", pBrush, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
			return pPen
		}
		Gdip_BrushCreateSolid(ARGB=0xff000000){
			DllCall("gdiplus\GdipCreateSolidFill", "UInt", ARGB, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
			return pBrush
		}
		Gdip_BrushCreateHatch(ARGBfront, ARGBback, HatchStyle=0){
			DllCall("gdiplus\GdipCreateHatchBrush", "int", HatchStyle, "UInt", ARGBfront, "UInt", ARGBback, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
			return pBrush
		}
		CreateRectF(ByRef RectF, x, y, w, h){
			VarSetCapacity(RectF, 16)
			NumPut(x, RectF, 0, "float"), NumPut(y, RectF, 4, "float"), NumPut(w, RectF, 8, "float"), NumPut(h, RectF, 12, "float")
		}
		Gdip_SetTextRenderingHint(pGraphics, RenderingHint){
			return DllCall("gdiplus\GdipSetTextRenderingHint", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", RenderingHint)
		}
		Gdip_MeasureString(pGraphics, sString, hFont, hFormat, ByRef RectF){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			VarSetCapacity(RC, 16)
			if !A_IsUnicode
			{
				nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, "uint", 0, "int", 0)
				VarSetCapacity(wString, nSize*2)
				DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
			}
			DllCall("gdiplus\GdipMeasureString", Ptr, pGraphics, Ptr, A_IsUnicode ? &sString : &wString, "int", -1, Ptr, hFont, Ptr, &RectF, Ptr, hFormat, Ptr, &RC, "uint*", Chars, "uint*", Lines)
			return &RC ? NumGet(RC, 0, "float") "|" NumGet(RC, 4, "float") "|" NumGet(RC, 8, "float") "|" NumGet(RC, 12, "float") "|" Chars "|" Lines : 0
		}
		CreateRect(ByRef Rect, x, y, w, h){
			VarSetCapacity(Rect, 16)
			NumPut(x, Rect, 0, "uint"), NumPut(y, Rect, 4, "uint"), NumPut(w, Rect, 8, "uint"), NumPut(h, Rect, 12, "uint")
		}
		CreateSizeF(ByRef SizeF, w, h){
			VarSetCapacity(SizeF, 8)
			NumPut(w, SizeF, 0, "float"), NumPut(h, SizeF, 4, "float")
		}
		CreatePointF(ByRef PointF, x, y){
			VarSetCapacity(PointF, 8)
			NumPut(x, PointF, 0, "float"), NumPut(y, PointF, 4, "float")
		}
		Gdip_DrawArc(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdiplus\GdipDrawArc", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
		}
		Gdip_DrawPie(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdiplus\GdipDrawPie", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
		}
		Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdiplus\GdipDrawLine", Ptr, pGraphics, Ptr, pPen, "float", x1, "float", y1, "float", x2, "float", y2)
		}
		Gdip_DrawLines(pGraphics, pPen, Points){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			StringSplit, Points, Points, |
			VarSetCapacity(PointF, 8*Points0)
			Loop, %Points0%
			{
				StringSplit, Coord, Points%A_Index%, `,
				NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
			}
			return DllCall("gdiplus\GdipDrawLines", Ptr, pGraphics, Ptr, pPen, Ptr, &PointF, "int", Points0)
		}
		Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdiplus\GdipFillRectangle", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
		}
		Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r){
			Region := Gdip_GetClipRegion(pGraphics)
			Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
			Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
			Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
			Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
			E := Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
			Gdip_SetClipRegion(pGraphics, Region, 0)
			Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
			Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
			Gdip_FillEllipse(pGraphics, pBrush, x, y, 2*r, 2*r)
			Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y, 2*r, 2*r)
			Gdip_FillEllipse(pGraphics, pBrush, x, y+h-(2*r), 2*r, 2*r)
			Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
			Gdip_SetClipRegion(pGraphics, Region, 0)
			Gdip_DeleteRegion(Region)
			return E
		}
		Gdip_GetClipRegion(pGraphics){
			Region := Gdip_CreateRegion()
			DllCall("gdiplus\GdipGetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics, "UInt*", Region)
			return Region
		}
		Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode=0){
			return DllCall("gdiplus\GdipSetClipRect",  A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "float", w, "float", h, "int", CombineMode)
		}
		Gdip_SetClipPath(pGraphics, Path, CombineMode=0){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdiplus\GdipSetClipPath", Ptr, pGraphics, Ptr, Path, "int", CombineMode)
		}
		Gdip_ResetClip(pGraphics){
			return DllCall("gdiplus\GdipResetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics)
		}
		Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdiplus\GdipFillEllipse", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
		}
		Gdip_FillRegion(pGraphics, pBrush, Region){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdiplus\GdipFillRegion", Ptr, pGraphics, Ptr, pBrush, Ptr, Region)
		}
		Gdip_FillPath(pGraphics, pBrush, Path){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdiplus\GdipFillPath", Ptr, pGraphics, Ptr, pBrush, Ptr, Path)
		}
		Gdip_CreateRegion(){
			DllCall("gdiplus\GdipCreateRegion", "UInt*", Region)
			return Region
		}
		Gdip_DeleteRegion(Region){
			return DllCall("gdiplus\GdipDeleteRegion", A_PtrSize ? "UPtr" : "UInt", Region)
		}
		Gdip_CreateBitmap(Width, Height, Format=0x26200A){
			DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, A_PtrSize ? "UPtr" : "UInt", 0, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
			Return pBitmap
		}
		Gdip_SetSmoothingMode(pGraphics, SmoothingMode){
			return DllCall("gdiplus\GdipSetSmoothingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", SmoothingMode)
		}
		Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdiplus\GdipDrawRectangle", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
		}
		Gdip_DrawRoundedRectangle(pGraphics, pPen, x, y, w, h, r){
			Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
			Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
			Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
			Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
			E := Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
			Gdip_ResetClip(pGraphics)
			Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
			Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
			Gdip_DrawEllipse(pGraphics, pPen, x, y, 2*r, 2*r)
			Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y, 2*r, 2*r)
			Gdip_DrawEllipse(pGraphics, pPen, x, y+h-(2*r), 2*r, 2*r)
			Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
			Gdip_ResetClip(pGraphics)
			return E
		}
		Gdip_DrawEllipse(pGraphics, pPen, x, y, w, h){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			return DllCall("gdiplus\GdipDrawEllipse", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
		}
		Gdip_CreateHBITMAPFromBitmap(pBitmap, Background=0xffffffff){
			DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hbm, "int", Background)
			return hbm
		}
		SetImage(hwnd, hBitmap){
			SendMessage, 0x172, 0x0, hBitmap,, ahk_id %hwnd%
			E := ErrorLevel
			DeleteObject(E)
			return E
		}
		Gdip_FillPolygon(pGraphics, pBrush, Points, FillMode=0){
			Ptr := A_PtrSize ? "UPtr" : "UInt"
			StringSplit, Points, Points, |
			VarSetCapacity(PointF, 8*Points0)
			Loop, %Points0%
			{
				StringSplit, Coord, Points%A_Index%, `,
				NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
			}
			return DllCall("gdiplus\GdipFillPolygon", Ptr, pGraphics, Ptr, pBrush, Ptr, &PointF, "int", Points0, "int", FillMode)
		}
;#####################################################################################
; Default = 0
; LowQuality = 1
; HighQuality = 2
; Bilinear = 3
; Bicubic = 4
; NearestNeighbor = 5
; HighQualityBilinear = 6
; HighQualityBicubic = 7
		Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
		{
			return DllCall("gdiplus\GdipSetInterpolationMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", InterpolationMode)
		}
		
		
		
		Create(){
			ToolTip,   
			GuiControl , % HB_Button[ A_GuiControl ].Window ": Focus" , % HB_Button[ A_GuiControl ].Hwnd
			if( ! HB_Button[ A_GuiControl ].Draw_Pressed() )
				return
	;GuiControl,% This.Window ":Focus",% This.Hwnd
	;(This.Value:=This.CtrlValue)?(msgbox, %Value%)
			Edit1:=% up_down1.value
			Edit2:=% up_down2.value
			Edit3:=% up_down3.value
			Edit4:=% up_down4.value
			
			GuiControlGet,Boxname,,,Boxname
			
			msgbox,4096,Setting Mirror,Box Name:%Boxname% CPU Cores: %Edit1% HDD GB: %Edit2% RAM MB: %Edit3% ANDROID: %Edit4%,3
			
			IfExist,avd\%Boxname%.avd
			{
				msgbox,4096,Error ,Box Exist,5
				return
			}
			else
			{
				FileCreateDir, avd\%Boxname%.avd
				FileCopy, avd\Demo\Config.ini , avd\%Boxname%.avd\Config.ini
				
				FileCopy, avd\Demo\BotIT.ini , avd\%Boxname%.ini
				
			}
			
			
			
			ControlGetText, OutputVar , edit1
			IniWrite, %Boxname%, avd\%Boxname%.avd\Config.ini,Botit Emulator,AvdId
			IniWrite, %Boxname%, avd\%Boxname%.avd\Config.ini,Botit Emulator,avd.ini.displayname
			IniWrite, %Edit1%, avd\%Boxname%.avd\Config.ini,Botit Emulator,hw.cpu.ncore
			IniWrite, %Edit2%G, avd\%Boxname%.avd\Config.ini,Botit Emulator,disk.dataPartition.size
			IniWrite, %Edit3%, avd\%Boxname%.avd\Config.ini,Botit Emulator,hw.ramSize
			IniWrite, system-images\%Edit4%\, avd\%Boxname%.avd\Config.ini,Botit Emulator,image.sysdir.1
			
			
			IniWrite,..\avd\%Boxname%.avd,avd\%Boxname%.ini,Botit Emulator,path
			IniWrite,avd\%Boxname%.avd, avd\%Boxname%.ini,Botit Emulator,path.rel
			
			
			
			IfExist,%Boxname%.bat
			{
				msgbox,4096,Error ,.Bat Dup Exist,5
				return
			}
			else
			{
				FileCopy, avd\Demo\T1.bat , %Boxname%.bat
				
				batFile = %Boxname%.bat
				
				output := ""
				Loop, read, %batFile%
				{
					Line = %A_LoopReadLine%
					IfInString, Line, @Name
					{
						StringReplace, Line, Line, @Name, @%Boxname%
        ; note: Regular Expressions can be used like Line := regExReplace(Line, "...", "...")
					}
					
					output .= Line . "`n"   ; note: this is the same as if to say output = %output%%Line%`n or output := output . line "`n"
				}
				
				FileDelete, %batFile%
				FileAppend, %output%, %batFile%
				
				Run1 = echo off
				Run2 = cd emulator
				Run3 = set ANDROID_AVD_HOME=..\avd
				Run4 = start emulator.exe @%Boxname% -writable-system  -no-window
		;msgbox,%Run1%`r%Run2%`r%Run3%`r%Run4%
		;FileAppend %Run1%`r%Run2%`r%Run3%`r%Run4%,%Boxname%.BAT
				
			}
			
			msgbox,4096,Done,Finished Setup. Wait for "Little boxes to update",3
			Gosub,Boxlistview
			
			
			
		}
		
		
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
		
		
;; ---------    THE FUNCTION    ------------------------------------
		/*
			SmartZip()
			Smart ZIP/UnZIP files
			Parameters:
			s, o   When compressing, s is the dir/files of the source and o is ZIP filename of object. When unpressing, they are the reverse.
			t      The options used by CopyHere method. For availble values, please refer to: http://msdn.microsoft.com/en-us/library/windows/desktop/bb787866
			Link:
			http://www.autohotkey.com/forum/viewtopic.php?p=523649#523649
		*/
		
		SmartZip(s, o, t = 4)
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
		
		
		
		F8::ExitApp