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

Func calcMouseCoords_winapi()
	local $clientSize = WinGetClientSize($CH_Hwnd)
	
	Local $mousePos = MouseGetPos()	; 0 = X;  1 = Y
	Local $mousePosStruct = DllStructCreate("int X;int Y")
	
	DllStructSetData($mousePosStruct, "X", $mousePos[0])
	DllStructSetData($mousePosStruct, "Y", $mousePos[1])
	
	local $rtvalue = _WinAPI_ScreenToClient(WinGetHandle("Clicker Heroes"), $mousePosStruct)
	
	local $newCoords[2] = [DllStructGetData($mousePosStruct, "X"), DllStructGetData($mousePosStruct, "Y")]
	
	if $newCoords[0] < 1 or $newCoords[1] < 1 or $newCoords[0] > $clientSize[0] or $newCoords[1] > $clientSize[1] then
		; Mouse is outside the CH Window
		return $defaultMousePos
	else
		; Mouse is inside the window, the calculations are correct
		return $newCoords
	endif
	
endfunc

Func setCurrentMousePos()
	$mouseClickerPos = calcMouseCoords_winapi()
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