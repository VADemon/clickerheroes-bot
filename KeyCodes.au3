; ======================================================================================
; Author:			KDeluxe
; ======================================================================================

#include-once
#include <Constants.au3>

Global Const $VK_CANCEL 	= 0x03
Global Const $VK_BACK 		= 0x08
Global Const $VK_TAB 		= 0x09
Global Const $VK_RETURN 	= 0x0D
Global Const $VK_SHIFT 		= 0x10
Global Const $VK_CONTROL 	= 0x11
Global Const $VK_MENU 		= 0x12
Global Const $VK_PAUSE		= 0x13
Global Const $VK_CAPITAL 	= 0x14
Global Const $VK_ESCAPE 	= 0x1B
Global Const $VK_SPACE 		= 0x20
Global Const $VK_SNAPSHOT 	= 0x2C
Global Const $VK_INSERT 	= 0x2D
Global Const $VK_DELETE 	= 0x2E
Global Const $VK_LWIN		= 0x5B
Global Const $VK_RWIN		= 0x5C
Global Const $VK_NUMPAD0 	= 0x60
Global Const $VK_NUMPAD1 	= 0x61
Global Const $VK_NUMPAD2 	= 0x62
Global Const $VK_NUMPAD3 	= 0x63
Global Const $VK_NUMPAD4 	= 0x64
Global Const $VK_NUMPAD5 	= 0x65
Global Const $VK_NUMPAD6 	= 0x66
Global Const $VK_NUMPAD7 	= 0x67
Global Const $VK_NUMPAD8 	= 0x68
Global Const $VK_NUMPAD9 	= 0x69
Global Const $VK_MULTIPLY 	= 0x6A
Global Const $VK_ADD 		= 0x6B
Global Const $VK_SUBTRACT 	= 0x6D
Global Const $VK_DECIMAL 	= 0x6E
Global Const $VK_DIVIDE 	= 0x6F
Global Const $VK_F1 		= 0x70
Global Const $VK_F2 		= 0x71
Global Const $VK_F3 		= 0x72
Global Const $VK_F4 		= 0x73
Global Const $VK_F5 		= 0x74
Global Const $VK_F6 		= 0x75
Global Const $VK_F7 		= 0x76
Global Const $VK_F8 		= 0x77
Global Const $VK_F9 		= 0x78
Global Const $VK_F10 		= 0x79
Global Const $VK_F11 		= 0x7A
Global Const $VK_F12 		= 0x7B
Global Const $VK_NUMLOCK 	= 0x90
Global Const $VK_SCROLL 	= 0x91

;=================================================================================================
; Function:			_ReplaceKey($Key)
; Description:		Converts the key to a key code.
; Parameter(s):		$Key - Key to convert
; Requirement(s):	A key to convert
; Return Value(s):	On Success - Returns the key code
;					On Failure - Returns false
;					@Error - 0 = No error
;							 1 = Invalid key
; Author(s):		KDeluxe
;=================================================================================================
Func _ReplaceKey($Key)
	If IsInt($Key) And $Key < 0x92 And $Key > 0 Then
		Return SetError(0, "", $Key)
	EndIf

	$Key = StringReplace($Key, "{", "")
	$Key = StringReplace($Key, "}", "")

	If StringLen($Key) == 0 Then
		Return SetError(1, "", False)
	ElseIf StringLen($Key) == 1 Then
		If 	$Key == "+" Or $Key == "-" Or $Key == "*" Or _
			$Key == "/" Or $Key == "," Or $Key == " " _
		Then
			$Key = StringReplace($Key, "+", 			$VK_ADD)
			$Key = StringReplace($Key, "-", 			$VK_SUBTRACT)
			$Key = StringReplace($Key, "*", 			$VK_MULTIPLY)
			$Key = StringReplace($Key, "/", 			$VK_DIVIDE)
			$Key = StringReplace($Key, ",", 			$VK_DECIMAL)
			$Key = StringReplace($Key, " ", 			$VK_SPACE)
		Else
			$Key = StringUpper($Key)
			$Key = StringToBinary($Key)
		EndIf
	Else
		$Key = StringReplace($Key, "LBUTTON", 			$VK_LBUTTON)
		$Key = StringReplace($Key, "RBUTTON", 			$VK_RBUTTON)
		$Key = StringReplace($Key, "BREAK", 			$VK_CANCEL)
		$Key = StringReplace($Key, "MBUTTON", 			$VK_MBUTTON)
		$Key = StringReplace($Key, "DELETE", 			$VK_BACK)
		$Key = StringReplace($Key, "TAB", 				$VK_TAB)
		$Key = StringReplace($Key, "ENTER", 			$VK_RETURN)
		$Key = StringReplace($Key, "SHIFT", 			$VK_SHIFT)
		$Key = StringReplace($Key, "LSHIFT", 			$VK_SHIFT)
		$Key = StringReplace($Key, "RSHIFT", 			$VK_SHIFT)
		$Key = StringReplace($Key, "CTRL", 				$VK_CONTROL)
		$Key = StringReplace($Key, "LCTRL", 			$VK_CONTROL)
		$Key = StringReplace($Key, "RCTRL", 			$VK_CONTROL)
		$Key = StringReplace($Key, "CONTROL", 			$VK_CONTROL)
		$Key = StringReplace($Key, "ALT", 				$VK_MENU)
		$Key = StringReplace($Key, "LALT", 				$VK_MENU)
		$Key = StringReplace($Key, "RALT", 				$VK_MENU)
		$Key = StringReplace($Key, "PAUSE", 			$VK_PAUSE)
		$Key = StringReplace($Key, "CAPSLOCK", 			$VK_CAPITAL)
		$Key = StringReplace($Key, "CAPSLOCK ON", 		$VK_CAPITAL)
		$Key = StringReplace($Key, "CAPSLOCK OFF", 		$VK_CAPITAL)
		$Key = StringReplace($Key, "CAPSLOCK TOGGLE",	$VK_CAPITAL)
		$Key = StringReplace($Key, "ESCAPE", 			$VK_ESCAPE)
		$Key = StringReplace($Key, "SPACE", 			$VK_SPACE)
		$Key = StringReplace($Key, "PGUP", 				$VK_PRIOR)
		$Key = StringReplace($Key, "PGDN", 				$VK_NEXT)
		$Key = StringReplace($Key, "END", 				$VK_END)
		$Key = StringReplace($Key, "HOME", 				$VK_HOME)
		$Key = StringReplace($Key, "LEFT", 				$VK_LEFT)
		$Key = StringReplace($Key, "UP", 				$VK_UP)
		$Key = StringReplace($Key, "RIGHT", 			$VK_RIGHT)
		$Key = StringReplace($Key, "DOWN", 				$VK_DOWN)
		$Key = StringReplace($Key, "PRINTSCREEN",	 	$VK_SNAPSHOT)
		$Key = StringReplace($Key, "INSERT",	 		$VK_INSERT)
		$Key = StringReplace($Key, "DELETE", 			$VK_DELETE)
		$Key = StringReplace($Key, "NUMPAD0", 			$VK_NUMPAD0)
		$Key = StringReplace($Key, "NUMPAD1", 			$VK_NUMPAD1)
		$Key = StringReplace($Key, "NUMPAD2", 			$VK_NUMPAD2)
		$Key = StringReplace($Key, "NUMPAD3", 			$VK_NUMPAD3)
		$Key = StringReplace($Key, "NUMPAD4", 			$VK_NUMPAD4)
		$Key = StringReplace($Key, "NUMPAD5", 			$VK_NUMPAD5)
		$Key = StringReplace($Key, "NUMPAD6", 			$VK_NUMPAD6)
		$Key = StringReplace($Key, "NUMPAD7", 			$VK_NUMPAD7)
		$Key = StringReplace($Key, "NUMPAD8", 			$VK_NUMPAD8)
		$Key = StringReplace($Key, "NUMPAD9", 			$VK_NUMPAD9)
		$Key = StringReplace($Key, "NUMPADMULT", 		$VK_MULTIPLY)
		$Key = StringReplace($Key, "NUMPADADD", 		$VK_ADD)
		$Key = StringReplace($Key, "NUMPADSUB", 		$VK_SUBTRACT)
		$Key = StringReplace($Key, "NUMPADDOT", 		$VK_DECIMAL)
		$Key = StringReplace($Key, "NUMPADDIV", 		$VK_DIVIDE)
		$Key = StringReplace($Key, "F1", 				$VK_F1)
		$Key = StringReplace($Key, "F2", 				$VK_F2)
		$Key = StringReplace($Key, "F3", 				$VK_F3)
		$Key = StringReplace($Key, "F4", 				$VK_F4)
		$Key = StringReplace($Key, "F5", 				$VK_F5)
		$Key = StringReplace($Key, "F6", 				$VK_F6)
		$Key = StringReplace($Key, "F7", 				$VK_F7)
		$Key = StringReplace($Key, "F8", 				$VK_F8)
		$Key = StringReplace($Key, "F9", 				$VK_F9)
		$Key = StringReplace($Key, "F10", 				$VK_F10)
		$Key = StringReplace($Key, "F11", 				$VK_F11)
		$Key = StringReplace($Key, "F12", 				$VK_F12)
		$Key = StringReplace($Key, "NUMLOCK", 			$VK_NUMLOCK)
		$Key = StringReplace($Key, "NUMLOCK ON", 		$VK_NUMLOCK)
		$Key = StringReplace($Key, "NUMLOCK OFF", 		$VK_NUMLOCK)
		$Key = StringReplace($Key, "NUMLOCK TOGGLE",	$VK_NUMLOCK)
		$Key = StringReplace($Key, "SCROLLLOCK", 		$VK_SCROLL)
		$Key = StringReplace($Key, "SCROLLLOCK ON", 	$VK_SCROLL)
		$Key = StringReplace($Key, "SCROLLLOCK OFF",	$VK_SCROLL)
		$Key = StringReplace($Key, "SCROLLLOCK TOGGLE",	$VK_SCROLL)
	EndIf

	If Not IsInt($Key) Then
		Return SetError(1, "", False)
	Else
		Return SetError(0, "", $Key)
	EndIf
EndFunc

Func _MakeLong($LoDWORD, $HiDWORD)
    Return BitOR($HiDWORD * 0x10000, BitAND($LoDWORD, 0xFFFF))
EndFunc

Func _CheckKey($Key)
	If IsString($Key) And StringLen($Key) > 0 Then
		Return SetError(0, "", True)
	Else
		If IsInt($Key) Then
			If $Key < 0x92 Then
				If $Key > 0 Then
					Return SetError(0, "", True)
				Else
					Return SetError(3, "", False)
				EndIf
			Else
				Return SetError(2, "", False)
			EndIf
		Else
			Return SetError(1, "", False)
		EndIf
	EndIf
EndFunc