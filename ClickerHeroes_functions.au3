; 1) Check if the previous HWND is valid
; 	1.1) if not, look for the Clicker Heroes Window
;	1.2) return Status
; >> automatically sets $CH_Hwnd
Func CH_exists()
	if $CH_Hwnd == 0 or IsHWnd($CH_Hwnd) == 0 then
		resetMousePos()	; reset the settings of the previous window
		
		if WinGetHandle("Clicker Heroes") == 0 then
			$CH_Hwnd = 0
			return 0
		else
			$CH_Hwnd = WinGetHandle("Clicker Heroes")
			return $CH_Hwnd
		endif
	else
		return IsHWnd($CH_Hwnd)
	endif
endfunc

Func doInactivityClick()
	if CH_exists() then
		_PostMessage_FastClick($CH_Hwnd, $MousePosX, $MousePosY, $User32, 1, 10)
		$inactivityClickTimer = 0
	else
		$inactivityClickTimer = -10		; ClickerHeroes isn't opened, next check in 19s
	endif
endfunc

Func calcMouseCoords()	; calculates real mouse coordinates relative to CH Window position
	Local $mousePos = MouseGetPos()	; 0 = X;  1 = Y
	Local $windowPos = WinGetPos("Clicker Heroes")	; 0 = X Pos;	1 = Y Pos;	2 = Width;	3 = Height
	
	; Mouse coords inside the game window
	; @> -16 is an offset, dunno why the position shifted without it
	Local $relativeMousePos = [$mousePos[0] - $windowPos[0] + 4, $mousePos[1] - $windowPos[1] - 14]
	
	;; is the mouse INSIDE the window?
	if $relativeMousePos[0] < $windowPos[2] and $relativeMousePos[1] < $windowPos[3] then
	
		;MsgBox(0, "Relativeposition", "Calculated position:" & @CRLF & "x: " & $relativeMousePos[0] & "   y: " & $relativeMousePos[1])
		return $relativeMousePos
	else
	
		;MsgBox(0, "Resetting position", "Calculated position is outside the window:" & @CRLF & "x: " & $relativeMousePos[0] & "   y: " & $relativeMousePos[1])
		return $mouseClickerPos		; either the default setting or the last user-defined position
		;return $defaultMousePos	; don't use invalid parameters from above
	endif
endfunc

Func setCurrentMousePos()
	$mouseClickerPos = calcMouseCoords()
	$MousePosX = $mouseClickerPos[0]
	$MousePosY = $mouseClickerPos[1]
endfunc

; reset mousePos to default
; > Used when the previous window was closed
Func resetMousePos()
	$mouseClickerPos = $defaultMousePos
	$MousePosX = $defaultMousePos[0]
	$MousePosY = $defaultMousePos[1]
endfunc