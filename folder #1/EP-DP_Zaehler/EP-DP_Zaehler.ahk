;V1.1.1

#SingleInstance, force

I_Icon = %A_ScriptDir%\blue.ico
Menu, Tray, Icon, %I_Icon%
Menu, Tray, Tip, EP/DP Zaehler V1.1

Gui, show, w200 h200, EP/DP V1.1
Gui, add, button, x40 y5 h20 w120 gsub1, Einblendpunkte
Gui, add, button, x40 h20 w120 gsub2, Datenpunkte
Gui, add, button, x65 y135 h20 w70 greload, Neu laden
Gui, add, button, x65 h20 w70 gexit, Exit
Return

sub1:
	FileSelectFile, SelectedFile, , C:\Users\%A_UserName%\Desktop, GLT Stapeldruck auswählen, *.pdf
		If (SelectedFile = "") {
			MsgBox, , Fehler!,Sie haben keine Datei ausgewählt.
		Return
		}
		FileCopy, %SelectedFile%, %A_ScriptDir%\temp_ep.pdf
	
		RunWait, %A_ScriptDir%\pdftotext.exe temp_ep.pdf
	
		FileRead haystack, temp_ep.txt
		needle := "(?<=Gesamtzahl aller Einblendpunkte: )\d+"
	
		output_ep := ""
		var_ep := 0
	
		Pos := 1
		While(Pos := RegExMatch(haystack, needle, M, Pos + StrLen(M)))
		output_ep .= M "`n"
	
		FileAppend, %output_ep%, %A_ScriptDir%\output_ep.txt
	
		Loop, Read, %A_ScriptDir%\output_ep.txt
		var_ep += A_LoopReadLine
	
		If var_ep > 0
			MsgBox, , EP,Gesamtzahl aller Einblendpunkte: %var_ep%
		Else
			MsgBox, , Fehler!, Es konnten keine Einblendpunkte gefunden werden,`nvergewissern Sie sich dass Sie die richtige`nDatei ausgewählt hatten.

	
		FileDelete, %A_ScriptDir%\temp_ep.txt
		FileDelete, %A_ScriptDir%\temp_ep.pdf
		FileDelete, %A_ScriptDir%\output_ep.txt
	
	Return

sub2:
	FileSelectFile, SelectedFile, , C:\Users\%A_UserName%\Desktop, GLT Stapeldruck auswählen, *.pdf
		If (SelectedFile = "") {
			MsgBox, , Fehler!, Sie haben keine Datei ausgewählt.
		Return
		}
		FileCopy, %SelectedFile%, %A_ScriptDir%\temp_dp.pdf
	
		RunWait, %A_ScriptDir%\pdftotext.exe temp_dp.pdf
	
		FileRead haystack, temp_dp.txt
		needle := "(?<=Gesamtzahl aller Informationspunkte: )\d+"
	
		output_dp := ""
		var_dp := 0
	
		Pos := 1
		While(Pos := RegExMatch(haystack, needle, M, Pos + StrLen(M)))
			output_dp .= M "`n"
	
		FileAppend, %output_dp%, %A_ScriptDir%\output_dp.txt
	
		Loop, Read, %A_ScriptDir%\output_dp.txt
		var_dp += A_LoopReadLine
	
		If var_dp > 0
			MsgBox, , EP,Gesamtzahl aller Informationspunkte: %var_dp%
		Else
			MsgBox, , Fehler!, Es konnten keine Informationspunkte gefunden werden,`nvergewissern Sie sich dass Sie die richtige`nDatei ausgewählt hatten.
	
		FileDelete, %A_ScriptDir%\temp_dp.txt
		FileDelete, %A_ScriptDir%\temp_dp.pdf
		FileDelete, %A_ScriptDir%\output_dp.txt
	
	Return

reload:
Reload

guiclose:
ExitApp

exit:
Exitapp