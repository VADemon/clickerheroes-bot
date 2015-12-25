#include-once
#include "KeyCodes.au3"
#include <WindowsConstants.au3>


;;; https://www.autoitscript.com/forum/topic/129149-mouseclickfast-mousemovefast/
Global $x_koef = 65535/@DesktopWidth
Global $y_koef = 65535/@DesktopHeight

Func _MouseClickFast2($x, $y, $User32 = "User32.dll")
    $x *= $x_koef
    $y *= $y_koef

    DllCall($User32, "none", "mouse_event", "int", 32769, "int", $x, "int", $y, "int", 0, "int", 0) ; 32769 0x8001 BitOR($MOUSEEVENTF_ABSOLUTE, $MOUSEEVENTF_MOVE)
    DllCall($User32, "none", "mouse_event", "int", 32770, "int", $x, "int", $y, "int", 0, "int", 0) ; 32770 0x8002 BitOR($MOUSEEVENTF_ABSOLUTE, $MOUSEEVENTF_LEFTDOWN)
    DllCall($User32, "none", "mouse_event", "int", 32772, "int", $x, "int", $y, "int", 0, "int", 0) ; 32772 0x8004 BitOR($MOUSEEVENTF_ABSOLUTE, $MOUSEEVENTF_LEFTUP)
EndFunc 

Func _MouseMoveFast2($x, $y, $User32 = "User32.dll")
    $x *= $x_koef
    $y *= $y_koef

    DllCall($User32, "none", "mouse_event", "int", 32769, "int", $x, "int", $y, "int", 0, "int", 0) ; 32769 0x8001 BitOR($MOUSEEVENTF_ABSOLUTE, $MOUSEEVENTF_MOVE)
EndFunc
;;;

Func _MouseClickFastVAD($x, $y, $User32, $clicks)
    $x *= $x_koef
    $y *= $y_koef

	; MOVE MOUSE ONCE
    DllCall($User32, "none", "mouse_event", "int", 32769, "int", $x, "int", $y, "int", 0, "int", 0) ; 32769 0x8001 BitOR($MOUSEEVENTF_ABSOLUTE, $MOUSEEVENTF_MOVE)
	
	For $i = 1 to $clicks
		DllCall($User32, "none", "mouse_event", "int", 32770, "int", $x, "int", $y, "int", 0, "int", 0) ; 32770 0x8002 BitOR($MOUSEEVENTF_ABSOLUTE, $MOUSEEVENTF_LEFTDOWN)
		DllCall($User32, "none", "mouse_event", "int", 32772, "int", $x, "int", $y, "int", 0, "int", 0) ; 32772 0x8004 BitOR($MOUSEEVENTF_ABSOLUTE, $MOUSEEVENTF_LEFTUP)
	Next
EndFunc 

;;;;

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
; Author(s):		KDeluxe // VAD edited func
;=================================================================================================
Func _PostMessage_FastClick($hWnd, $X, $Y, $User32, $Clicks = 1, $Delay = 10)
	;	$Button = $WM_LBUTTONDOWN == left
	;	$Button = $WM_RBUTTONDOWN == right
	;	$Button = $WM_MBUTTONDOWN == middle
	
	$Coordinate = _MakeLong($X, $Y)
	
	For $j = 1 To $Clicks
		DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $WM_LBUTTONDOWN, "int", 0, "long", $Coordinate)
		Sleep($Delay)
		DllCall($User32, "bool", "PostMessage", "HWND", $hWnd, "int", $WM_LBUTTONUP, "int", 0, "long", $Coordinate)
	Next

EndFunc