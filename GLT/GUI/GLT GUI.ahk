#SingleInstance, force

I_Icon = %A_ScriptDir%\blue.ico
Menu, Tray, Icon, %I_Icon%
Menu, Tray, Tip, %ScriptName%
Menu, Tray, Add, Fernbedienung öffnen, GLT
return

~^s::
	SetTitleMatchMode, 2
	If WinActive(A_ScriptName)
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
	Else
		SendInput, ^s
	return


F12::
	KeyWait, F12
	KeyWait, F12, D T0.2
	if ErrorLevel
		SendInput, {F12}
	else
		{
			Gosub, GLT
		}
	return


global break_g = 0

~LButton::break_g = 1

Abbrechen:
	break_g = 1
	return


GLT:
	Gui, 1:Destroy
	Gui, 1:+AlwaysOnTop
	Gui, 1:Add, Button, y5 w180 gGUIsm0, Störmeldung invertieren - SM=0
	Gui, 1:Add, Button, w180 gGUIsm1, Störmeldung invertieren - SM=1
	Gui, 1:Add, Text, w180 h2 +0x10
	Gui, 1:Add, Button, w180 gGUITa, Trendkurven anlegen
	Gui, 1:Add, Button, w180 gGUITl, Trendkurven löschen
	Gui, 1:Add, Button, x65 y270 h20 w70 gexit, Exit
	Gui, 1:Show, AutoSize NoActivate, %ScriptName%
	return


GUIsm0:
	WinGetPos, X1, Y1,,, A
	Gui, 1:Hide
	Gui, 2:+E0x08000000 +AlwaysOnTop
	Gui, 2:Add, Text, x20 y5, Störmeldungen invertieren - SM=0
	Gui, 2:Add, Radio, x20 y30 vradio1S0 Checked, 1-fach
	Gui, 2:Add, Radio, x80 y30 vradio5S0, 5-fach
	Gui, 2:Add, Radio, x140 y30 vradio10S0, 10-fach
	Gui, 2:Add, Text, x35 y60, Verzögerung in Millisekunden
	Gui, 2:Add, Slider, x40 Range300-1000 TickInterval50 ToolTipTop vSlidersm0, 500
	Gui, 2:Add, Text, w120 h2 +0x10
	Gui, 2:Add, Button, x40 h20 w120 gOKRadioS0, OK
	Gui, 2:Add, Button, x40 h20 w120 gAbbrechen, Abbrechen
	Gui, 2:Add, Button, x65 y235 h20 w70 gzurueck, Zurück
	Gui, 2:Show, % "x" X1 "y" Y1 w200 h300 NoActivate, %ScriptName%
	return

OKRadioS0:
	Gui, 2:Submit, NoHide
	if (radio1S0)
		{
			Gosub, 1fachS0
		}
	if (radio5S0)
		{
			Gosub, 5fachS0
		}
	if (radio10S0)
		{
			Gosub, 10fachS0
		}
	return

1fachS0:
	if WinActive("ahk_exe phindows.ex_")
		{
			SendInput, {Enter}
			Sleep, %Slidersm0%
			SendInput, {AltDown}m{AltUp}
			Sleep, %Slidersm0%
			SendInput, {ShiftDown}{Tab 4}{ShiftUp}
			SendInput, {Space}
			Sleep, %Slidersm0%
			SendInput, {Enter}
			Sleep, %Slidersm0%
			SendInput, {Enter}
			return
		}
	return

5fachS0:
	if WinActive("ahk_exe phindows.ex_")
		{
			break_g = 0
			Loop, 5
				{
					SendInput, {Enter}
					Sleep, %Slidersm0%
					SendInput, {AltDown}m{AltUp}
					Sleep, %Slidersm0%
					SendInput, {ShiftDown}{Tab 4}{ShiftUp}
					SendInput, {Space}
					Sleep, %Slidersm0%
					SendInput, {Enter}
					Sleep, %Slidersm0%
					SendInput, {Enter}
					Sleep, %Slidersm0%
					SendInput, {Down}
					Sleep, %Slidersm0%
					if(break_g = 1)
						{
							return
						}
				}
				return
		}
		return

10fachS0:
	if WinActive("ahk_exe phindows.ex_")
		{
			break_g = 0
			Loop, 10
			{
				SendInput, {Enter}
				Sleep, %Slidersm0%
				SendInput, {AltDown}m{AltUp}
				Sleep, %Slidersm0%
				SendInput, {ShiftDown}{Tab 4}{ShiftUp}
				SendInput, {Space}
				Sleep, %Slidersm0%
				SendInput, {Enter}
				Sleep, %Slidersm0%
				SendInput, {Enter}
				Sleep, %Slidersm0%
				SendInput, {Down}
				Sleep, %Slidersm0%
				if(break_g = 1)
					{
						return
					}
			}
			return
		}
		return


GUIsm1:
	WinGetPos, X1, Y1,,, A
	Gui, 1:Hide
	Gui, 3:+E0x08000000 +AlwaysOnTop
	Gui, 3:Add, Text, x20 y5, Störmeldungen invertieren - SM=1
	Gui, 3:Add, Radio, x20 y30 vradio1S1 Checked, 1-fach
	Gui, 3:Add, Radio, x80 y30 vradio5S1, 5-fach
	Gui, 3:Add, Radio, x140 y30 vradio10S1, 10-fach
	Gui, 3:Add, Text, x35 y60, Verzögerung in Millisekunden
	Gui, 3:Add, Slider, x40 Range300-1000 TickInterval50 ToolTipTop vSlidersm1, 500
	Gui, 3:Add, Text, w120 h2 +0x10
	Gui, 3:Add, Button, x40 h20 w120 gOKRadioS1, OK
	Gui, 3:Add, Button, x40 h20 w120 gAbbrechen, Abbrechen
	Gui, 3:Add, Button, x65 y235 h20 w70 gzurueck, Zurück
	Gui, 3:Show, % "x" X1 "y" Y1 w200 h300 NoActivate, %ScriptName%
	return

OKRadioS1:
	Gui, 3:Submit, NoHide
	if (radio1S1)
		{
			Gosub, 1fachS1
		}
	if (radio5S1)
		{
			Gosub, 5fachS1
		}
	if (radio10S1)
		{
			Gosub, 10fachS1
		}
	return

1fachS1:
	if WinActive("ahk_exe phindows.ex_")
		{
			SendInput, {Enter}
			Sleep, %Slidersm1%
			SendInput, {AltDown}m{AltUp}
			Sleep, %Slidersm1%
			SendInput, {ShiftDown}{Tab 3}{ShiftUp}
			SendInput, {Space}
			Sleep, %Slidersm1%
			SendInput, {Enter}
			Sleep, %Slidersm1%
			SendInput, {Enter}
			return
		}
	return

5fachS1:
	if WinActive("ahk_exe phindows.ex_")
		{
			break_g = 0
			Loop, 5
			{
				SendInput, {Enter}
				Sleep, %Slidersm1%
				SendInput, {AltDown}m{AltUp}
				Sleep, %Slidersm1%
				SendInput, {ShiftDown}{Tab 3}{ShiftUp}
				SendInput, {Space}
				Sleep, %Slidersm1%
				SendInput, {Enter}
				Sleep, %Slidersm1%
				SendInput, {Enter}
				Sleep, %Slidersm1%
				SendInput, {Down}
				Sleep, %Slidersm1%
				if(break_g = 1)
					{
						return
					}
			}
			return
		}
	return

10fachS1:
	if WinActive("ahk_exe phindows.ex_")
		{
			break_g = 0
			Loop, 10
			{
				SendInput, {Enter}
				Sleep, %Slidersm1%
				SendInput, {AltDown}m{AltUp}
				Sleep, %Slidersm1%
				SendInput, {ShiftDown}{Tab 3}{ShiftUp}
				SendInput, {Space}
				Sleep, %Slidersm1%
				SendInput, {Enter}
				Sleep, %Slidersm1%
				SendInput, {Enter}
				Sleep, %Slidersm1%
				SendInput, {Down}
				Sleep, %Slidersm1%
				if(break_g = 1)
					{
						return
					}
			}
			return
		}
	return


GUITa:
	WinGetPos, X1, Y1,,, A
	Gui, 1:Hide
	Gui, 4:+E0x08000000 +AlwaysOnTop
	Gui, 4:Add, Text, x40 y5, Trendkurven anlegen
	Gui, 4:Add, Radio, x20 y30 vradio1Ta Checked, 1-fach
	Gui, 4:Add, Radio, x80 y30 vradio5Ta, 5-fach
	Gui, 4:Add, Radio, x140 y30 vradio10Ta, 10-fach
	Gui, 4:Add, Text, x35 y60, Verzögerung in Millisekunden
	Gui, 4:Add, Slider, x40 Range300-1000 TickInterval50 ToolTipTop vSliderTa, 500
	Gui, 4:Add, Text, w120 h2 +0x10
	Gui, 4:Add, Button, x40 h20 w120 gOKRadioTa, OK
	Gui, 4:Add, Button, x40 h20 w120 gAbbrechen, Abbrechen
	Gui, 4:Add, Button, x65 y235 h20 w70 gzurueck, Zurück
	Gui, 4:Show, % "x" X1 "y" Y1 w200 h300 NoActivate, %ScriptName%
	return

OKRadioTa:
	Gui, 4:Submit, NoHide
	if (radio1Ta)
		{
			Gosub, 1fachTa
		}
	if (radio5Ta)
		{
			Gosub, 5fachTa
		}
	if (radio10Ta)
		{
			Gosub, 10fachTa
		}
	return

1fachTa:
	if WinActive("ahk_exe phindows.ex_")
		{
			SendInput, {Enter}
			Sleep, %SliderTa%
			SendInput, {AltDown}t{AltUp}
			Sleep, %SliderTa%
			SendInput, {Enter}
			Sleep, %SliderTa%
			SendInput, {Enter}
			return
		}
	return

5fachTa:
	if WinActive("ahk_exe phindows.ex_")
		{
			break_g = 0
			Loop, 5
			{
				SendInput, {Enter}
				Sleep, %SliderTa%
				SendInput, {AltDown}t{AltUp}
				Sleep, %SliderTa%
				SendInput, {Enter}
				Sleep, %SliderTa%
				SendInput, {Enter}
				Sleep, %SliderTa%
				SendInput, {Down}
				Sleep, %SliderTa%
				if(break_g = 1)
					{
						return
					}
			}
			return
		}
	return

10fachTa:
	if WinActive("ahk_exe phindows.ex_")
		{
			break_g = 0
			Loop, 10
			{
				SendInput, {Enter}
				Sleep, %SliderTa%
				SendInput, {AltDown}t{AltUp}
				Sleep, %SliderTa%
				SendInput, {Enter}
				Sleep, %SliderTa%
				SendInput, {Enter}
				Sleep, %SliderTa%
				SendInput, {Down}
				Sleep, %SliderTa%
				if(break_g = 1)
					{
						return
					}
			}
			return
		}
	return


GUITl:
	WinGetPos, X1, Y1,,, A
	Gui, 1:Hide
	Gui, 5:+E0x08000000 +AlwaysOnTop
	Gui, 5:Add, Text, x40 y5, Trendkurven löschen
	Gui, 5:Add, Radio, x20 y30 vradio1Tl Checked, 1-fach
	Gui, 5:Add, Radio, x80 y30 vradio5Tl, 5-fach
	Gui, 5:Add, Radio, x140 y30 vradio10Tl, 10-fach
	Gui, 5:Add, Text, x35 y60, Verzögerung in Millisekunden
	Gui, 5:Add, Slider, x40 Range300-1000 TickInterval50 ToolTipTop vSliderTl, 500
	Gui, 5:Add, Text, w120 h2 +0x10
	Gui, 5:Add, Button, x40 h20 w120 gOKRadioTl, OK
	Gui, 5:Add, Button, x40 h20 w120 gAbbrechen, Abbrechen
	Gui, 5:Add, Button, x65 y235 h20 w70 gzurueck, Zurück
	Gui, 5:Show, % "x" X1 "y" Y1 w200 h300 NoActivate, %ScriptName%
	return

OKRadioTl:
	Gui, 5:Submit, NoHide
	if (radio1Tl)
		{
			Gosub, 1fachTl
		}
	if (radio5Tl)
		{
			Gosub, 5fachTl
		}
	if (radio10Tl)
		{
			Gosub, 10fachTl
		}
	return

1fachTl:
	if WinActive("ahk_exe phindows.ex_")
		{
			SendInput, {Enter}
			Sleep, %SliderTl%
			SendInput, {AltDown}t{AltUp}
			Sleep, %SliderTl%
			SendInput, {AltDown}l{AltUp}
			Sleep, %SliderTl%
			SendInput, {AltDown}j{AltUp}
			Sleep, %SliderTl%
			SendInput, {Enter}
			return
		}
	return

5fachTl:
	if WinActive("ahk_exe phindows.ex_")
		{
			break_g = 0
			Loop, 5
			{
				SendInput, {Enter}
				Sleep, %SliderTl%
				SendInput, {AltDown}t{AltUp}
				Sleep, %SliderTl%
				SendInput, {AltDown}l{AltUp}
				Sleep, %SliderTl%
				SendInput, {AltDown}j{AltUp}
				Sleep, %SliderTl%
				SendInput, {Enter}
				Sleep, %SliderTl%
				SendInput, {Down}
				Sleep, %SliderTl%
				if(break_g = 1)
					{
						return
					}
			}
			return
		}
	return

10fachTl:
	if WinActive("ahk_exe phindows.ex_")
		{
			break_g = 0
			Loop, 10
			{
				SendInput, {Enter}
				Sleep, %SliderTl%
				SendInput, {AltDown}t{AltUp}
				Sleep, %SliderTl%
				SendInput, {AltDown}l{AltUp}
				Sleep, %SliderTl%
				SendInput, {AltDown}j{AltUp}
				Sleep, %SliderTl%
				SendInput, {Enter}
				Sleep, %SliderTl%
				SendInput, {Down}
				Sleep, %SliderTl%
				if(break_g = 1)
					{
						return
					}
			}
			return
		}
	return


zurueck:
Gui, 2:Destroy
Gui, 3:Destroy
Gui, 4:Destroy
Gui, 5:Destroy
Gui, 1:Show
Return

GuiClose:
Gui, 1:Destroy
Return

2GuiClose:
Gui, 2:Destroy
Gui, 1:Show
Return

3GuiClose:
Gui, 3:Destroy
Gui, 1:Show
Return

4GuiClose:
Gui, 4:Destroy
Gui, 1:Show
Return

5GuiClose:
Gui, 5:Destroy
Gui, 1:Show
Return

exit:
Exitapp