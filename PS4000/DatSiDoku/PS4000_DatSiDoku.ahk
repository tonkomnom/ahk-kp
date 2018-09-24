;V1.1.beta

#SingleInstance, force
SetWorkingDir %A_ScriptDir%

FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\%A_ScriptName%.lnk

I_Icon = %A_ScriptDir%\blue.ico
Menu, Tray, Icon, %I_Icon%
Menu, Tray, Tip, %A_ScriptName%
;Menu, Tray, NoStandard
Menu, Tray, Add, Info..., guiAbout
Menu, Tray, Add, Hilfe, guiHelp
Menu, Tray, Add
Menu, Tray, Add, Sichern über PS4000, guiSichern
Menu, Tray, Add, Wiederherstellen über PS4000, guiHerstellen
Menu, Tray, Add, Ablage über Explorer, guiExplorer
Menu, Tray, Add
Menu, Tray, Add, Programm anhalten, gPause
Menu, Tray, Add, Beenden, gExit
return

~^s::
	SetTitleMatchMode, 2
	if WinActive(A_ScriptName)
		{
			SendInput, ^s
			SplashTextOn,,25, Status, Script updated
			Sleep,1000
			SplashTextOff
			Reload
			Sleep 1000
			MsgBox, 4,, The script was not reloaded, open it to edit?
			IfMsgBox, Yes, Edit
		}
	else
		SendInput, ^s
	return

;!F11::Gosub, WriteDatabase

#IfWinActive, PS4000 Projektkonsole
~LButton::
	if WinExist("PS4000 Projektkonsole","Sicherung")
		{
			MouseGetPos,,,, OutputVarControl
				if OutputVarControl = Button1
					Gosub, guiSichern
					OutputVarControl :=""
				return
		}
	else
		{
			if WinExist("PS4000 Projektkonsole","Wiederherstellung")
				MouseGetPos,,,, OutputVarControl
					if OutputVarControl = Button1
						Gosub, guiHerstellen
						OutputVarControl :=""
					return
		}
	return


;GUI PS4000 Sicherung
guiSichern:
	Gui, Destroy
	Gui, +E0x08000000 +AlwaysOnTop
	Gui, Show, x250 y250 w200 h200 NoActivate, %A_ScriptName%
	Gui, Add, Button, x40 y5 h30 w120 gnavpath, Zu Verzeichnis
	Gui, Add, Button, x40 y45 h50 w120 gSichern, Sichern
	Gui, Add, Button, x65 y160 h20 w70 gexit, Schließen
	return

navpath:
	WinGetTitle, vaktprojekt, PS4000 - "
	FileRead, vdatabase, database.txt
		if InStr(vdatabase, vaktprojekt)
			{	
				vneedle := "(?<=path:).+"
				RegExMatch(vdatabase, vneedle, vcurrentPath, InStr(vdatabase, vaktprojekt))
				;ControlClick, [Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText]
				;ControlSend, [ Control, Keys, WinTitle, WinText, ExcludeTitle, ExcludeText]
				SendInput, {TAB 5}
				SendInput, {Enter}
				SendInput, %vcurrentPath%
				SendInput, {Enter}
			}
		else
			{
				SplashTextOn, 300, 20, Fehler, Der Pfad wurde noch nicht gespeichert.
				Sleep, 1000
				SplashTextOff
			}
	vaktprojekt := ""
	vdatabase := ""
	vcurrentPath :=""
	return


Sichern:
	WinGetTitle, vaktprojekt, PS4000 - "
	FileRead, vdatabase, database.txt
		if InStr(vdatabase, vaktprojekt)
			{
				WinGet, win_id, ID, A
				ControlGetText bar_text, ToolbarWindow324, ahk_id %win_id%
				StringTrimLeft, vcurrentPath, bar_text, 9
				FormatTime, vCurrentDateTime,, yyyy-MM-dd_HH-mm
				FileDelete, %vcurrentPath%\*abgelegt*.ps5
				FileAppend, , %vcurrentPath%\%vCurrentDateTime% die letzte Datensicherung wurde abgelegt durch %A_UserName%.ps5
					if ErrorLevel
						MsgBox,, Fehler, Achtung, es wurde keine Datei erzeugt!
					else
						{
							SplashTextOn,,25, Status, Datei wurde erzeugt.
							Sleep, 750
							SplashTextOff
							Gui, Destroy
						}
					return
			}
		else
			{
				WinGet, win_id, ID, A
				ControlGetText bar_text, ToolbarWindow324, ahk_id %win_id%
				StringTrimLeft, vcurrentPath, bar_text, 9
				FormatTime, vCurrentDateTime,, yyyy-MM-dd_HH-mm
				FileDelete, %vcurrentPath%\*abgelegt*.ps5
				FileAppend, , %vcurrentPath%\%vCurrentDateTime% die letzte Datensicherung wurde abgelegt durch %A_UserName%.ps5
					if ErrorLevel
						MsgBox,, Fehler, Achtung, es wurde keine Datei erzeugt!
					else
						{
							SplashTextOn,,25, Status, Datei wurde erzeugt.
							Sleep, 750
							SplashTextOff
							Gui, Destroy
							FileAppend,
								(
									%vaktprojekt% path:%vcurrentPath%
					
								), %A_ScriptDir%\database.txt
						}
			}
	vaktprojekt := ""
	vdatabase := ""
	vcurrentPath :=""
	return


;GUI PS4000 Wiederherstellung
guiHerstellen:
	Gui, Destroy
	Gui, +E0x08000000 +AlwaysOnTop
	Gui, Show, x250 y250 w200 h200 NoActivate, %A_ScriptName%
	Gui, Add, Button, x40 y5 h50 w120 gHerstellen, Wiederherstellen
	Gui, Add, Button, x65 y160 h20 w70 gexit, Schließen
	return

Herstellen:
	WinGet, win_id, ID, A
	ControlGetText bar_text, ToolbarWindow323, ahk_id %win_id%
	StringTrimLeft, currentPath, bar_text, 9
	FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm
	FileDelete, %currentPath%\*wiederhergestellt*.ps5
	FileAppend, , %currentPath%\%CurrentDateTime% Achtung! Das Projekt wurde wiederhergestellt von %A_UserName%.ps5
		if ErrorLevel
			MsgBox,, Fehler, Achtung, es wurde keine Datei erzeugt!
		else
			{
				SplashTextOn,,25, Status, Datei wurde erzeugt.
				Sleep, 750
				SplashTextOff
				Gui, Destroy
			}
	currentPath :=""
	return


;GUI Windows Explorer
guiExplorer:
	Gui, Destroy
	Gui, +E0x08000000 +AlwaysOnTop
	Gui, Show, x250 y250 w200 h200 NoActivate, %A_ScriptName%
	Gui, Add, Button, x40 y5 h20 w120 gExplorersub1, Sichern
	Gui, Add, Button, x40 h20 w120 gExplorersub2, Wiederherstellen
	Gui, Add, Button, x40 h20 w120 gExplorersub3, Ausbuchen
	Gui, Add, Button, x65 y170 h20 w70 gexit, Schließen
	return

Explorersub1:
	WinGet, win_id, ID, A
	ControlGetText bar_text, ToolbarWindow323, ahk_id %win_id%
	StringTrimLeft, currentPath, bar_text, 9
	FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm
	FileDelete, %currentPath%\*abgelegt*.ps5
	FileAppend, , %currentPath%\%CurrentDateTime% die letzte Datensicherung wurde abgelegt durch %A_UserName%.ps5
		if ErrorLevel
			MsgBox,, Fehler, Achtung, es wurde keine Datei erzeugt!
		else
			{
			SplashTextOn,,25, Status, Datei wurde erzeugt.
			Sleep, 750
			SplashTextOff
			Gui, Destroy
			}
	currentPath :=""
	return

Explorersub2:
	WinGet, win_id, ID, A
	ControlGetText bar_text, ToolbarWindow323, ahk_id %win_id%
	StringTrimLeft, currentPath, bar_text, 9
	FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm
	FileDelete, %currentPath%\*wiederhergestellt*.ps5
	FileAppend, , %currentPath%\%CurrentDateTime% Achtung! Das Projekt wurde wiederhergestellt von %A_UserName%.ps5
		if ErrorLevel
			MsgBox,, Fehler, Achtung, es wurde keine Datei erzeugt!
		else
			{
				SplashTextOn,,25, Status, Datei wurde erzeugt.
				Sleep, 750
				SplashTextOff
				Gui, Destroy
			}
	currentPath :=""
	return

Explorersub3:
	WinGet, win_id, ID, A
	ControlGetText bar_text, ToolbarWindow323, ahk_id %win_id%
	StringTrimLeft, currentPath, bar_text, 9
	FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm
	InputBox, ausbuchen_name, PS4000 Ablage, Für wen wird die Sicherung ausgebucht?,,,150
		if ausbuchen_name =
			MsgBox,, Fehler!, Sie haben keinen Namen angegeben, bitte erneut versuchen.
		else
			{
				FileDelete, %currentPath%\*übergeben*.ps5
				FileAppend, , %currentPath%\%CurrentDateTime% Achtung! Das Projekt wurde übergeben an %ausbuchen_name%.ps5
					if ErrorLevel
						MsgBox,, Fehler!, Achtung, es wurde keine Datei erzeugt!
					else
						{
							SplashTextOn,,25, Status, Datei wurde erzeugt.
							Sleep, 750
							SplashTextOff
							Gui, Destroy
						}
				currentPath :=""
				ausbuchen_name :=""
			}
	return

/*
WriteDatabase:
	WinGetTitle, vaktprojekt, ahk_exe PS4000.exe
	FileRead, vdatabase, database.txt
	if InStr(vdatabase, vaktprojekt)
		{
			needle := "(?<=path:).+"
			RegExMatch(vdatabase, needle, outputvar)
			SplashTextOn, , 25, Title, %outputvar%
			Sleep, 1000
			SplashTextOff
			return
		}
	else
		WinGet, win_id, ID, A
		ControlGetText bar_text, ToolbarWindow323, ahk_id %win_id%
		StringTrimLeft, currentPath, bar_text, 9
		FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm
		FileDelete, %currentPath%\*abgelegt*.ps5
		FileAppend, , %currentPath%\%CurrentDateTime% die letzte Datensicherung wurde abgelegt durch %A_UserName%.ps5
			if ErrorLevel
				MsgBox,, Fehler, Achtung, es wurde keine Datei erzeugt!
			else
				{
					SplashTextOn,,25, Status, Datei wurde erzeugt.
					Sleep, 750
					SplashTextOff
					Gui, Destroy
					FileAppend,
						(
							%vaktprojekt% path:%currentPath%
			
						), %A_ScriptDir%\database.txt
					vaktprojekt := ""
					vdatabase := ""
				}
	currentPath :=""
	return
*/

gPause:
	menu, tray, ToggleCheck, Programm anhalten
	Suspend, Toggle
	Pause, Toggle
	return

gExit:
	ExitApp
	Return

guiAbout:
	Gui, 99:Destroy
	Gui, 99:Add, Text, ,© Manuel Jurca, Kieback&&Peter GmbH && Co. KG
	Gui, 99:Add, Text, ,Version V1.0.1, 2018-09-19
	Gui, 99:Add, Text, cblue ggitlink, GitHub
	Gui, 99:Add, Text,
	Gui, 99:Show, AutoSize
	return

gitlink:
	Run, https://github.com/tonkomnom/ahk-kp/blob/master/PS4000/DatSiDoku/PS4000_DatSiDoku.ahk
	return

guiHelp:
	Run, https://github.com/tonkomnom/ahk-kp/blob/master/PS4000/DatSiDoku/
	return

guiclose:
Gui, Destroy

exit:
Gui, Destroy
