;setzt automatisch einen Kommentar mit Rahmen und blauem Info Icon in einer SPS Zeichnung

#IfWinActive, ahk_exe PS4000.exe

^k::
;Alt+k
;create comment
MouseClick, Right
SendInput, {Tab 2}
SendInput, {Right}
SendInput, {Up}
SendInput, {Enter}
MouseGetPos, xpos, ypos
MouseMove, xpos + 10, ypos + 10

;Rahmen setzen
MouseClick, Right
SendInput, {Tab 2}
SendInput, {Right}
SendInput, {Down 2}
SendInput, {Tab}
SendInput, {Enter}

;Symbol setzen
MouseClick, Right
SendInput, {Tab}
SendInput, {Right}
SendInput, {Down}
SendInput, {Tab}
SendInput, {Enter}
Return	

#IfWinActive