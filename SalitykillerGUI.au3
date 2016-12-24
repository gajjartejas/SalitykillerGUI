#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Resources\icon.ico
#AutoIt3Wrapper_Outfile=Sality Killer GUI.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=Sality Killer GUI
#AutoIt3Wrapper_Res_Description=Sality Killer GUI
#AutoIt3Wrapper_Res_Fileversion=1..0.0
#AutoIt3Wrapper_Res_LegalCopyright=©Gajjar Tejas 2016
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Field=CompanyName|Gajjar Tejas's Blog
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=Internal Name|Sality Killer GUI.exe
#AutoIt3Wrapper_Res_Field=Product Name|Sality Killer GUI
#AutoIt3Wrapper_Res_Field=Product Version|1.0.0.0
#AutoIt3Wrapper_Res_requestedExecutionLevel=highestAvailable
#AutoIt3Wrapper_Res_File_Add=Resources\wintop.jpg, rt_rcdata, wintop
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#AutoIt3Wrapper_Run_After=del "SalitykillerGUI_stripped.au3"
#Au3Stripper_Parameters=/so
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#Region ;************ Includes ************
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>
#include "Includes\_Resources.au3"
#EndRegion ;************ Includes ************

Global $current_version = "1.0.0.0"
Global $Win_Title = "SALITY KILLER GUI" & $current_version
Global $Build_Date = "6th Jan 2013"

#Region ### START Koda GUI section ###
Global $HGUI = GUICreate($Win_Title, 396, 269, 402, 220)
$BGimage = GUICtrlCreatePic("", 0, 0, 396, 60, 67108864)
_ResourceSetImageToCtrl($BGimage, "wintop")
GUISetBkColor(0xFFFFFF)
$Input_File = GUICtrlCreateInput("", 10, 15, 291, 21)
$Button_Browse = GUICtrlCreateButton("Browse v", 305, 14, 75, 25)

$Group1 = GUICtrlCreateGroup("Options", 10, 50, 375, 190)

$Group2 = GUICtrlCreateGroup("Scan", 20, 70, 185, 155)
$Checkbox_Scan_Network_Disks = GUICtrlCreateCheckbox("Network Disks", 30, 90, 97, 17)
$Checkbox_Scan_Removable = GUICtrlCreateCheckbox("Removable", 30, 110, 97, 17)
$Checkbox_Scan_Monatring_Mode = GUICtrlCreateCheckbox("Monatring Mode", 30, 130, 97, 17)
$Checkbox_Scan_Scan_Then_Monitor = GUICtrlCreateCheckbox("Scan Then Monitor", 30, 150, 122, 17)
$Checkbox_Scan_All_Disk_Autorun = GUICtrlCreateCheckbox("All Disk and Remove autorun.inf", 30, 170, 172, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)

$Group3 = GUICtrlCreateGroup("Restore", 210, 70, 160, 85)
$Checkbox_Restore_Hidden_File = GUICtrlCreateCheckbox("Hidden File", 220, 90, 97, 17)
$Checkbox_Restore_Disable_Autorun = GUICtrlCreateCheckbox("Disable Autorun", 220, 110, 97, 17)
$Checkbox_Restore_Safe = GUICtrlCreateCheckbox("Restore Safe Registry", 220, 130, 132, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)

$Group4 = GUICtrlCreateGroup("Log", 210, 160, 160, 65)
$Checkbox_Log_Enable = GUICtrlCreateCheckbox("Enable Logging", 220, 180, 97, 17)
$Checkbox_Log_With_Detai = GUICtrlCreateCheckbox("With Detailed", 220, 200, 97, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)

$Button_Start_Scan = GUICtrlCreateButton("Start Scan", 10, 245, 76, 21)
If Not IsAdmin() Then _GUICtrlButton_SetShield($Button_Start_Scan)
$Button_Copy_CMDLINE = GUICtrlCreateButton("Copy Commandline", 90, 245, 116, 21)
$Button_Info = GUICtrlCreateButton("i", 300, 245, 26, 21)
$Button_Create_Bat_File = GUICtrlCreateButton("Create bat File", 210, 245, 86, 21)
$Label_About = GUICtrlCreateLabel("About", 350, 250, 37, 17)
GUICtrlSetFont(-1, 8, 800, 4, "MS Sans Serif")
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetCursor(-1, 3)

$hBtnArrowContext = GUICtrlCreateContextMenu($Button_Browse)
$MenuItem0 = GUICtrlCreateMenuItem("Choose File...", $hBtnArrowContext)
$MenuItem1 = GUICtrlCreateMenuItem("Choose Folder...", $hBtnArrowContext)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
_Check_SalityKiller()
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Button_Browse
			ShowMenu($HGUI, $nMsg, $hBtnArrowContext)

		Case $MenuItem0
			$sfile = FileOpenDialog("Choose File To Scan", "::{450D8FBA-AD25-11D0-98A8-0800361B1103}", "All Files(*.*) | Executable File(*.exe;*.dll*.ocx;*.cpl;*.sys;*.scr;*.drv) | Compressed File (*.zip;*.7z;*.rar;*.bz2;*.gz;*.tar;*.cab;*.arc;*.ace)", 5, "", $HGUI)
			If @error Then GUICtrlSetData($Input_File, "")
			GUICtrlSetData($Input_File, $sfile)

		Case $MenuItem1
			$sfile = FileSelectFolder("Choose a folder to scan...", "", 3, "", $HGUI)
			If @error Then GUICtrlSetData($Input_File, "")
			GUICtrlSetData($Input_File, $sfile)

		Case $Checkbox_Log_Enable
			If GUICtrlRead($Checkbox_Log_Enable) = $GUI_CHECKED Then
				GUICtrlSetState($Checkbox_Log_With_Detai, $GUI_ENABLE)
			Else
				GUICtrlSetState($Checkbox_Log_With_Detai, $GUI_DISABLE)
			EndIf

		Case $Button_Start_Scan
			If Not IsAdmin() Then
				ShellExecute(@ScriptDir & "\SalityKiller.exe", _sCMDLINE())
			Else
				$Foo = Run(@ScriptDir & "\SalityKiller.exe" & _sCMDLINE())
			EndIf

		Case $Button_Copy_CMDLINE
			ClipPut(@ScriptDir & "\SalityKiller.exe" & _sCMDLINE())

		Case $Button_Create_Bat_File
			If FileExists(@ScriptDir & "\Sality_CMDLINE.bat") Then FileDelete(@ScriptDir & "\Sality_CMDLINE.bat")
			FileWrite(@ScriptDir & "\Sality_CMDLINE.bat", @ScriptDir & "\SalityKiller.exe" & _sCMDLINE())

		Case $Button_Info
			If FileExists(@ScriptDir & "\SalityKiller.exe") Then
				MsgBox(0, "SalityKiller.exe Version Info", "Programme Name: " & "SalityKiller" _
						 & @CRLF & "File Version: " & FileGetVersion(@ScriptDir & "\SalityKiller.exe") _
						 & @CRLF & "File Size: " & FileGetSize(@ScriptDir & "\SalityKiller.exe") / 1024 & "kb")
			Else
				If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer
				$iMsgBoxAnswer = MsgBox(36, "Confirm", "SalityKiller.exe Not Found In This Directory.Please Install SalityKiller.exe From ... Do you want to download SalityKiller.exe ?")
				Select
					Case $iMsgBoxAnswer = 6 ;Yes
						ShellExecute("https://support.kaspersky.com/downloads/utils/salitykiller.zip")
					Case $iMsgBoxAnswer = 7 ;No
				EndSelect
			EndIf

		Case $Label_About
			About()

	EndSwitch
WEnd

Func _sCMDLINE()
	Local $CMD_LINE = ""
	If GUICtrlRead($Input_File) <> "" Then $CMD_LINE &= " -p" & " " & '"' & GUICtrlRead($Input_File) & '"'
	If GUICtrlRead($Checkbox_Scan_Network_Disks) = $GUI_CHECKED Then $CMD_LINE &= " -n"
	If GUICtrlRead($Checkbox_Scan_Removable) = $GUI_CHECKED Then $CMD_LINE &= " -r"
	If GUICtrlRead($Checkbox_Scan_Monatring_Mode) = $GUI_CHECKED Then $CMD_LINE &= " -m"
	If GUICtrlRead($Checkbox_Scan_Scan_Then_Monitor) = $GUI_CHECKED Then $CMD_LINE &= " -q"
	If GUICtrlRead($Checkbox_Scan_All_Disk_Autorun) = $GUI_CHECKED Then $CMD_LINE &= " -k"

	If GUICtrlRead($Checkbox_Restore_Hidden_File) = $GUI_CHECKED Then $CMD_LINE &= " -x"
	If GUICtrlRead($Checkbox_Restore_Disable_Autorun) = $GUI_CHECKED Then $CMD_LINE &= " -a"
	If GUICtrlRead($Checkbox_Restore_Safe) = $GUI_CHECKED Then $CMD_LINE &= " -j"

	If GUICtrlRead($Checkbox_Log_Enable) = $GUI_CHECKED Then $CMD_LINE &= " -l SalityKillerLog.Log"
	If GUICtrlRead($Checkbox_Log_With_Detai) = $GUI_CHECKED Then $CMD_LINE &= " -v"

	Return $CMD_LINE
EndFunc   ;==>_sCMDLINE

Func ShowMenu($hWnd, $CtrlID, $nContextID)
	Local $arPos, $x, $y
	Local $hMenu = GUICtrlGetHandle($nContextID)
	$arPos = ControlGetPos($hWnd, "", $CtrlID)
	$x = $arPos[0]
	$y = $arPos[1] + $arPos[3]
	ClientToScreen($hWnd, $x, $y)
	TrackPopupMenu($hWnd, $hMenu, $x, $y)
EndFunc   ;==>ShowMenu

; Convert the client (GUI) coordinates to screen (desktop) coordinates
Func ClientToScreen($hWnd, ByRef $x, ByRef $y)
	Local $stPoint = DllStructCreate("int;int")
	DllStructSetData($stPoint, 1, $x)
	DllStructSetData($stPoint, 2, $y)
	DllCall("user32.dll", "int", "ClientToScreen", "hwnd", $hWnd, "ptr", DllStructGetPtr($stPoint))
	$x = DllStructGetData($stPoint, 1)
	$y = DllStructGetData($stPoint, 2)
	; release Struct not really needed as it is a local
	$stPoint = 0
EndFunc   ;==>ClientToScreen

; Show at the given coordinates (x, y) the popup menu (hMenu) which belongs to a given GUI window (hWnd)
Func TrackPopupMenu($hWnd, $hMenu, $x, $y)
	DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hWnd, "ptr", 0)
EndFunc   ;==>TrackPopupMenu

Func _Check_SalityKiller()
	If Not FileExists("SalityKiller.exe") Then
		GUICtrlSetState($Button_Start_Scan, $GUI_DISABLE)
		GUICtrlSetState($Button_Info, $GUI_DISABLE)
		$iMsgBoxAnswer = MsgBox(36, "Confirm", "SalityKiller.exe Not Found In This Directory. Do you want to download SalityKiller.exe From www.kaspersky.com?", 0, $HGUI)
		Select
			Case $iMsgBoxAnswer = 6 ;Yes
				_Download_Sality()
				If @error Then
					MsgBox(48, "Error", "Error occured during download", 0, $HGUI)
				Else
					MsgBox(48, "Info", "UnZip Salitykiller.exe in Current Directory and Restart Me.", 0, $HGUI)
				EndIf
			Case $iMsgBoxAnswer = 7 ;No
		EndSelect
	EndIf
EndFunc   ;==>_Check_SalityKiller

Func _Download_Sality()
	ProgressOn("Download", "Downloading SalityKiller...", "0%", -1, -1, 18)
	Local $url = "https://support.kaspersky.com/downloads/utils/salitykiller.zip" ;Set URL
	Local $file = "salitykiller.zip" ;Set folder
	Local $hInet = InetGet($url, $file, 1, 1) ;Forces a reload from the remote site and return immediately and download in the background
	If @error Then
		ProgressOff()
		Return SetError(-1)
	EndIf
	Local $FileSize = InetGetSize($url, 1) ;Get file size
	If @error Then
		ProgressOff()
		Return SetError(-2)
	EndIf
	Local $BytesReceived = 0
	Do
		Sleep(100) ;Sleep for half a second to avoid flicker in the progress bar
		$BytesReceived = InetGetInfo($hInet, 0) ;Get bytes received
		$Pct = Round($BytesReceived / $FileSize * 100, 2) ;Calculate percentage
		ProgressSet($Pct, $Pct & "%") ;Set progress bar
	Until InetGetInfo($hInet, 2) ; Check if the download is complete.
	ProgressOff()
EndFunc   ;==>_Download_Sality

Func About()
	GUISetState(@SW_HIDE, $HGUI)
	$Child_About = GUICreate("About", 297, 310, -1, -1, BitAND(BitOR($GUI_SS_DEFAULT_GUI, $WS_DLGFRAME, $DS_MODALFRAME, $DS_SETFOREGROUND), Not $WS_MAXIMIZEBOX, Not $WS_MINIMIZEBOX))
	GUISetBkColor(0xFFFFFF)
	$Child_About_GroupBox = GUICtrlCreateGroup("", 3, 3, 285, 230)
	$Label1 = GUICtrlCreateLabel("About " & $Win_Title, 57, 29, 215, 17)
	$Child_Copyright = GUICtrlCreateLabel("Copyright (c) 2016 Gajjar Tejas", 56, 57, 149, 17)
	$Child_Icon = GUICtrlCreateIcon("", -1, 10, 15, 42, 42)
	$Child_Label_Email = GUICtrlCreateLabel("Email:", 10, 90, 32, 17)
	$Child_Label_Website = GUICtrlCreateLabel("Website:", 10, 110, 43, 17)
	$Child_Label_Email_ = GUICtrlCreateLabel("gajjartejas26@gmail.com", 77, 90, 121, 17)
	GUICtrlSetFont(-1, 8, 400, 4, "MS Sans Serif")
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetCursor(-1, 0)
	$Child_Label_Website_ = GUICtrlCreateLabel("http://www.tejasgajjar.in", 77, 110, 187, 17)
	GUICtrlSetFont(-1, 8, 400, 4, "MS Sans Serif")
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetCursor(-1, 0)
	$Label2 = GUICtrlCreateLabel($Win_Title & " Is under GPL", 10, 196, 260, 34)
	$Child_Label_Date = GUICtrlCreateLabel("Build Date: ", 10, 130, 53, 17)
	$Child_Label_Date_ = GUICtrlCreateLabel($Build_Date, 77, 130, 191, 17)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$Child_Ok = GUICtrlCreateButton("&OK", 184, 245, 100, 25, 0)
	$Contribute = GUICtrlCreateButton("&Project Homepage", 5, 245, 160, 25)
	GUISetState(@SW_SHOW, $Child_About)

	While 1
		$msg = GUIGetMsg()
		If $msg = $Child_Ok Or $msg = $GUI_EVENT_CLOSE Then ExitLoop
		If $msg = $Contribute Then ShellExecute("https://github.com/gajjartejas/SalitykillerGUI")
		If $msg = $Child_Label_Email_ Then ShellExecute("mailto:gajjartejas26@gmail.com")
		If $msg = $Child_Label_Website_ Then ShellExecute("http://www.gajjartejas26.blogspot.com/")
	WEnd

	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Child_About, "int", 1000, "long", 0x00050010) ;implode
	GUIDelete($Child_About)
	GUISetState(@SW_SHOW, $HGUI)
EndFunc   ;==>About
