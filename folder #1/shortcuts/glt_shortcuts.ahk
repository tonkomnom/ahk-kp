;GLT-public V1.2.1.0 2018-08-09
#NoEnv
;Avoids checking empty variables to see if they are environment variables
SendMode Input
;Switches to the SendInput method for Send, SendRaw, Click, and MouseMove/Click/Drag.
SetWorkingDir %A_ScriptDir%
;Script unconditionally uses its own folder as its working directory.

I_Icon = %A_ScriptDir%\blue.ico
Menu, Tray, Icon, %I_Icon%
;custom tray icon
Menu, Tray, Tip, GLT Helfer 1.2.1
;custom tray tooltip text

#Pause::Suspend, Toggle
;Win+Pause disables AutoHotkey


#IfWinActive, ahk_exe phindows.ex_
	;Hotkeys
		^!+F12::MsgBox, 0, Test, Dies ist ein Test

		^z::SendInput, {AltDown}br{AltUp}
		;Ctrl+z - undo

		^s::SendInput, {AltDown}ds{AltUp}
		;Ctrl+s - save

		#Tab::
		;Win+Tab - close text block
		SendInput, {Tab 9}
		SendInput, {Enter}
		Return

		$F2::
    	KeyWait, F2, T0.5
    	if ErrorLevel
    	    {
    	    	;long
    	        CoordMode, Mouse, Client
    	        MouseGetPos, xpos, ypos
    	        MouseMove, 0, 0
    	        MouseClick, Left, 25, 50
    	        MouseClick, Left, 25, 260
    	        MouseClick, Left, 25, 50
    	        MouseMove, xpos, ypos
    	        Return
    	    }
    	Else
    	    {
    	    ;short
    	    KeyWait, F2, D T0.2
    	    if ErrorLevel
    	        SendInput, {F2}
    	    Else
    	        {
    	        	;double
    	            SendInput, {F2}
    	            Sleep, 50
    	            SendInput, {Tab 2}
    	            SendInput, {Space}
    	            Return
    	        }
    	    }
    	Return

		!F2::
		;Ctrl+Alt+F2 - deselect datapoint type
		CoordMode, Mouse, Client
		MouseGetPos, xpos, ypos
		MouseMove, 0, 0
		MouseClick, Left, 25, 50
		MouseClick, Left, 25, 260
		MouseClick, Left, 25, 50
		MouseMove, xpos, ypos
		Return
		

		global break_g = 0
		~LButton::break_g = 1
		
		^+s::
		;Ctrl+Shift+s - single switch value of error message from 1 to 0 (highly dependant on correct Sleep interval; adjust if necessary)
		SendInput, {Enter}
		Sleep, 500
		SendInput, {AltDown}m{AltUp}
		Sleep, 500
		SendInput, {ShiftDown}{Tab 4}{ShiftUp}
		SendInput, {Space}
		Sleep, 500
		SendInput, {Enter}
		Sleep, 500
		SendInput, {Enter}
		Return

		^+!s::
		;Ctrl+Shift+s - looped switch value of error message from 1 to 0 (highly dependant on correct Sleep interval; adjust if necessary)
		break_g = 0
		Loop, 5
		{
			SendInput, {Enter}
			Sleep, 500
			SendInput, {AltDown}m{AltUp}
			Sleep, 500
			SendInput, {ShiftDown}{Tab 4}{ShiftUp}
			SendInput, {Space}
			Sleep, 500
			SendInput, {Enter}
			Sleep, 500
			SendInput, {Enter}
			Sleep, 500
			SendInput, {Down}
			if(break_g = 1)
			{
				Return
			}
		}
		Return

		^Left::SendInput, {Left 10}
		;Ctrl+Left - move selection left 10 pixels 

		^Up::SendInput, {Up 10}
		;Ctrl+Up - move selection up 10 pixels 

		^Right::SendInput, {Right 10}
		;Ctrl+Right - move selection right 10 pixels 

		^Down::SendInput, {Down 10}
		;Ctrl+Down - move selection down 10 pixels 

		+Left::SendInput, {AltDown}bn{AltUp}
		;Shift+Left - rotate left

		+Right::SendInput, {AltDown}bc{AltUp}
		;Shift+Right - rotate right
#IfWinActive
