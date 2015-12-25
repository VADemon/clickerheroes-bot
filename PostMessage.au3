#include-once
#include "KeyCodes.au3"
#include <WindowsConstants.au3>

;=================================================================================================
; Function:			_PostMessage_Send($hWnd, $Key, $Delay = 10)
; Description:		Sends a key to a specified window.
; Parameter(s):		$hWnd - The handle or the title of the window.
;					$Key - Key to send.
;					$Delay - (optional) Delay in milliseconds. Default is 10.
; Requirement(s):	A window handle/title.
; Return Value(s):	On Success - Returns true
;					On Failure - Returns false
;					@Error - 0 = No error.
;							 1 = Invalid window handle or title.
;							 2 = Invalid key to send.
;							 3 = Invalid key code.
;							 4 = Failed to open the dll.
;							 5 = Invalid return value from 'MapVirtualKey'.
; Author(s):		KDeluxe
;=================================================================================================
Func _PostMessage_Send($hWnd, $Key, $Delay = 10)
	If Not IsHWND($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf

	If Not IsHWND($hWnd) Then Return SetError(1, "", False)
	If Not _CheckKey($Key) Then Return SetError(2, "", False)

	If StringInStr($Key, " DOWN}") Then
		_PostMessage_SendDown($hWnd, StringReplace($Key, " DOWN}", ""), $Delay)
	ElseIf StringInStr($Key, " UP}") Then
		_PostMessage_SendUp($hWnd, StringReplace($Key, " UP}", ""), $Delay)
	Else
		$Key = _ReplaceKey($Key)
		If @error Or $Key == False Then Return SetError(3, "", False)
	EndIf

	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(4, "", False)

	$ret = DllCall($User32, "int", "MapVirtualKey", "int", $Key, "int", 0)
	If IsArray($ret) Then
		DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $WM_KEYDOWN, "int", $Key, "long", _MakeLong(1, $ret[0]))
		Sleep($Delay)
		DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $WM_KEYUP, "int", $Key, "long", _MakeLong(1, $ret[0]) + 0xC0000000)
	Else
		Return SetError(5, "", False)
	EndIf

	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc

;=================================================================================================
; Function:			_PostMessage_SendDown($hWnd, $Key, $Delay = 10)
; Description:		Sends a key down command to a specified window.
; Parameter(s):		$hWnd - The handle or the title of the window.
;					$Key - Key to send down.
;					$Delay - (optional) Delay in milliseconds. Default is 10.
; Requirement(s):	A window handle/title.
; Return Value(s):	On Success - Returns true
;					On Failure - Returns false
;					@Error - 0 = No error.
;							 1 = Invalid window handle or title.
;							 2 = Invalid key to send.
;							 3 = Invalid key code.
;							 4 = Failed to open the dll.
;							 5 = Invalid return value from 'MapVirtualKey'.
; Author(s):		KDeluxe
;=================================================================================================
Func _PostMessage_SendDown($hWnd, $Key, $Delay = 10)
	If Not IsHWND($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf

	If Not IsHWND($hWnd) Then Return SetError(1, "", False)
	If Not _CheckKey($Key) Then Return SetError(2, "", False)

	$Key = _ReplaceKey($Key)
	If @error Or $Key == False Then Return SetError(3, "", False)

	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(4, "", False)

	$ret = DllCall($User32, "int", "MapVirtualKey", "int", $Key, "int", 0)
	If IsArray($ret) Then
		DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $WM_KEYDOWN, "int", $Key, "long", _MakeLong(1, $ret[0]))
	Else
		Return SetError(5, "", False)
	EndIf

	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc

;=================================================================================================
; Function:			_PostMessage_SendUp($hWnd, $Key, $Delay = 10)
; Description:		Sends a key up command to a specified window.
; Parameter(s):		$hWnd - The handle or the title of the window.
;					$Key - Key to send up.
;					$Delay - (optional) Delay in milliseconds. Default is 10.
; Requirement(s):	A window handle/title.
; Return Value(s):	On Success - Returns true
;					On Failure - Returns false
;					@Error - 0 = No error.
;							 1 = Invalid window handle or title.
;							 2 = Invalid key to send.
;							 3 = Invalid key code.
;							 4 = Failed to open the dll.
;							 5 = Invalid return value from 'MapVirtualKey'.
; Author(s):		KDeluxe
;=================================================================================================
Func _PostMessage_SendUp($hWnd, $Key, $Delay = 10)
	If Not IsHWND($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf

	If Not IsHWND($hWnd) Then Return SetError(1, "", False)
	If Not _CheckKey($Key) Then Return SetError(2, "", False)

	$Key = _ReplaceKey($Key)
	If @error Or $Key == False Then Return SetError(3, "", False)

	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(4, "", False)

	$ret = DllCall($User32, "int", "MapVirtualKey", "int", $Key, "int", 0)
	If IsArray($ret) Then
		DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $WM_KEYUP, "int", $Key, "long", _MakeLong(1, $ret[0]) + 0xC0000000)
	Else
		Return SetError(5, "", False)
	EndIf

	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc

;=================================================================================================
; Function:			_PostMessage_Click($hWnd, $X = -1, $Y = -1, $Button = "left", $Clicks = 1, $Delay = 10)
; Description:		Sends a mouse click command to a specified window.
; Parameter(s):		$hWnd - The handle or the title of the window.
;					$X - (optional) The x position to click within the window. Default is center.
;					$Y - (optional) The y position to click within the window. Default is center.
;					$Button - (optional) The button to click, "left", "right", "middle". Default is the left button.
;					$Clicks - (optional) The number of times to click the mouse. Default is 1.
;					$Delay - (optional) Delay in milliseconds. Default is 10.
; Requirement(s):	A window handle/title.
; Return Value(s):	On Success - Returns true
;					On Failure - Returns false
;					@Error - 0 = No error.
;							 1 = Invalid window handle or title.
;							 2 = Failed to open the dll.
; Author(s):		KDeluxe
;=================================================================================================
Func _PostMessage_Click($hWnd, $X = -1, $Y = -1, $Button = "left", $Clicks = 1, $Delay = 10)
	If Not IsHWND($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf

	If Not IsHWND($hWnd) Then
		Return SetError(1, "", False)
	EndIf

	If StringLower($Button) == "left" Then
		$Button = $WM_LBUTTONDOWN
	ElseIf StringLower($Button) == "right" Then
		$Button = $WM_RBUTTONDOWN
	ElseIf StringLower($Button) == "middle" Then
		$Button = $WM_MBUTTONDOWN
		If $Delay == 10 Then $Delay = 100
	EndIf

	$WinSize = WinGetClientSize($hWnd)
	If $X == -1 Then $X = $WinSize[0] / 2
	If $Y == -1 Then $Y = $WinSize[1] / 2

	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(2, "", False)

	For $j = 1 To $Clicks
		DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $Button, "int", 0, "long", _MakeLong($X, $Y))
		Sleep($Delay)
		DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $Button + 1, "int", 0, "long", _MakeLong($X, $Y))
	Next

	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc

;=================================================================================================
; Function:			_PostMessage_ClickDown($hWnd, $X = -1, $Y = -1, $Button = "left")
; Description:		Sends a mouse down command to a specified window.
; Parameter(s):		$hWnd - The handle or the title of the window.
;					$X - (optional) The x position to click within the window. Default is center.
;					$Y - (optional) The y position to click within the window. Default is center.
;					$Button - (optional) The button to click, "left", "right", "middle". Default is the left button.
; Requirement(s):	A window handle/title.
; Return Value(s):	On Success - Returns true
;					On Failure - Returns false
;					@Error - 0 = No error.
;							 1 = Invalid window handle or title.
;							 2 = Failed to open the dll.
; Author(s):		KDeluxe
;=================================================================================================
Func _PostMessage_ClickDown($hWnd, $X = -1, $Y = -1, $Button = "left")
	If Not IsHWND($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf

	If Not IsHWND($hWnd) Then
		Return SetError(1, "", False)
	EndIf

	If StringLower($Button) == "left" Then
		$Button = $WM_LBUTTONDOWN
	ElseIf StringLower($Button) == "right" Then
		$Button = $WM_RBUTTONDOWN
	ElseIf StringLower($Button) == "middle" Then
		$Button = $WM_MBUTTONDOWN
	EndIf

	$WinSize = WinGetClientSize($hWnd)
	If $X == -1 Then $X = $WinSize[0] / 2
	If $Y == -1 Then $Y = $WinSize[1] / 2

	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(2, "", False)

	DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $Button, "int", 0, "long", _MakeLong($X, $Y))

	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc

;=================================================================================================
; Function:			_PostMessage_ClickUp($hWnd, $X = -1, $Y = -1, $Button = "left", $Delay = 50)
; Description:		Sends a mouse up command to a specified window.
; Parameter(s):		$hWnd - The handle or the title of the window.
;					$X - (optional) The x position to click within the window. Default is center.
;					$Y - (optional) The y position to click within the window. Default is center.
;					$Button - (optional) The button to click, "left", "right", "middle". Default is the left button.
; Requirement(s):	A window handle/title.
; Return Value(s):	On Success - Returns true
;					On Failure - Returns false
;					@Error - 0 = No error.
;							 1 = Invalid window handle or title.
;							 2 = Failed to open the dll.
; Author(s):		KDeluxe
;=================================================================================================
Func _PostMessage_ClickUp($hWnd, $X = -1, $Y = -1, $Button = "left")
	If Not IsHWND($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf

	If Not IsHWND($hWnd) Then
		Return SetError(1, "", False)
	EndIf

	If StringLower($Button) == "left" Then
		$Button = $WM_LBUTTONDOWN
	ElseIf StringLower($Button) == "right" Then
		$Button = $WM_RBUTTONDOWN
	ElseIf StringLower($Button) == "middle" Then
		$Button = $WM_MBUTTONDOWN
	EndIf

	$WinSize = WinGetClientSize($hWnd)
	If $X == -1 Then $X = $WinSize[0] / 2
	If $Y == -1 Then $Y = $WinSize[1] / 2

	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(2, "", False)

	DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $Button + 1, "int", 0, "long", _MakeLong($X, $Y))

	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc

;=================================================================================================
; Function:			_PostMessage_ClickDrag($hWnd, $X1, $Y1, $X2, $Y2, $Button = "left")
; Description:		Sends a mouse click and drag command to a specified window.
; Parameter(s):		$hWnd - The handle or the title of the window.
;					$X1, $Y1 - The x/y position to start the drag operation from.
;					$X2, $Y2 - The x/y position to end the drag operation at.
;					$Button - (optional) The button to click, "left", "right", "middle". Default is the left button.
;					$Delay - (optional) Delay in milliseconds. Default is 50.
; Requirement(s):	A window handle/title.
; Return Value(s):	On Success - Returns true
;					On Failure - Returns false
;					@Error - 0 = No error.
;							 1 = Invalid window handle or title.
;							 2 = Invalid start position.
;							 3 = Invalid end position.
;							 4 = Failed to open the dll.
;							 5 = Failed to send a MouseDown command.
;							 5 = Failed to send a MouseMove command.
;							 7 = Failed to send a MouseUp command.
; Author(s):		KDeluxe
;=================================================================================================
Func _PostMessage_ClickDrag($hWnd, $X1, $Y1, $X2, $Y2, $Button = "left", $Delay = 10)
	If Not IsHWND($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf

	If Not IsHWND($hWnd) Then
		Return SetError(1, "", False)
	EndIf

	If Not IsInt($X1) Or Not IsInt($Y1) Then
		Return SetError(2, "", False)
	EndIf

	If Not IsInt($X2) Or Not IsInt($Y2) Then
		Return SetError(3, "", False)
	EndIf

	If $Button = "left" Then
		$Button = $WM_LBUTTONDOWN
		$Pressed = 1
	ElseIf $Button = "right" Then
		$Button = $WM_RBUTTONDOWN
		$Pressed = 2
	ElseIf $Button = "middle" Then
		$Button = $WM_MBUTTONDOWN
		$Pressed = 10
	EndIf

	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(4, "", False)

	DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $Button, "int", 0, "long", _MakeLong($X1, $Y1))
	If @error Then Return SetError(5, "", False)

	Sleep($Delay / 2)

	DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $WM_MOUSEMOVE, "int", $Pressed, "long", _MakeLong($X2, $Y2))
	If @error Then Return SetError(6, "", False)

	Sleep($Delay / 2)

	DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $Button + 1, "int", 0, "long", _MakeLong($X2, $Y2))
	If @error Then Return SetError(7, "", False)

	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc

;=================================================================================================
; Function:			_GetAsyncKeyState($Key)
; Description:		Determines whether a key is up or down.
; Parameter(s):		$Key - Key to test for.
; Return Value(s):	On Success - Returns true
;					On Failure - Returns false
;					@Error - 0 = No error.
;							 1 = Invalid key to check.
;							 2 = Failed to open the dll.
;							 3 = Failed to get the key state.
; Author(s):		KDeluxe
;=================================================================================================
Func _GetAsyncKeyState($Key)
	If Not _CheckKey($Key) Then Return SetError(1, "", False)
	$Key = _ReplaceKey($Key)

	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(2, "", False)

	$ret = DllCall($User32, "short", "GetAsyncKeyState", "int", $Key)
	If IsArray($ret) Then
		Return SetError(0, "", $ret[0])
	Else
		Return SetError(3, "", False)
	EndIf
EndFunc