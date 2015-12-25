#include <WinAPI.au3>
#include <PostMessage.au3>

#include <ClickFunctions.au3>
#include <ClickerHeroes_functions.au3>

;Script by VADemon - http://steamcommunity.com/profiles/76561198033268090
;Melody by Mast3rpyr0 - http://www.autoitscript.com/forum/topic/50598-musical-melodies/page__hl__beep+song

HotKeySet("{PGUP}","setting")
HotKeySet("{PGDN}","mouseposclick")

Func mouseposclick()
	local $coords = calcMouseCoords()
	_PostMessage_FastClick($CH_Hwnd, $coords[0] + 4, $coords[1] - 14, $User32, 1, 10)
endfunc

AutoItSetOption("MouseClickDelay", 50)	; 75ms delay between clicks
AutoitSetOption("TrayAutoPause", 0)		; do not pause in tray

Global $scriptEnabled = 0

Global Const $cfgFile = "clickerheroes.inf"
Global Const $defaultMousePos[2] = [IniRead($cfgFile, "clicker", "defaultmousex", 840) , IniRead($cfgFile, "clicker", "defaultmousey", 380) ]	; default coordinates
Global Const $batchClicks = 		IniRead($cfgFile, "clicker", "batchclicks", 2)
Global Const $batchClicksDelay =	IniRead($cfgFile, "clicker", "batchclicksdelay", 10)
Global Const $clickSleep = 			IniRead($cfgFile, "clicker", "sleep", 60)

Global $mouseClickerPos = 0	; used to click
Global $MousePosX = 0
Global $MousePosY = 0
resetMousePos()


Global $User32 = DllOpen("User32.dll")

Global $inactivityClickTimer = 0
Global $CH_Hwnd = 0


while 1

	while $scriptEnabled==1
		;_MouseClickFastVAD($MousePosX, $MousePoxY, $User32, 2)
		_PostMessage_FastClick($CH_Hwnd, $MousePosX, $MousePosY, $User32, $batchClicks, $batchClicksDelay)
		sleep($clickSleep)
	WEnd
	
	if $scriptEnabled == 0 then	;; Inactivity Clicker (if clicker is disabled, you won't loose your click combo)
		$inactivityClickTimer += 1
		if $inactivityClickTimer == 25 then
			doInactivityClick()
		endif
	endif
	
sleep(1000)
WEnd

Func setting()
	if $scriptEnabled == 0 then
		
		;$winpos = WinGetPos("Clicker Heroes")
		;MsgBox(0, "Coords", "Mouse:" & @CRLF & "X: " & $MousePosX & "   Y: " & $MousePoxY & @CRLF & "WindowPos:" & @CRLF & "X Pos: " & $winpos[0] & "   Y Pos: " & $winpos[1] & @CRLF &	"Width: " & $winpos[2] & "   Height: " & $winpos[3])
		
		If CH_exists() then
			setCurrentMousePos()
			
			
			$scriptEnabled = 1
			Call("playsound", 1)
		else
			MsgBox(16, "Clicker Heroes not found", "Couldn't find an opened Clicker Heroes Window!")
		endif
	else
		$scriptEnabled = 0
		Call("playsound", 0)
		
		; we don't know exactly when the inactivity timer is going to tick, just to make sure we don't lose combo clicks
		doInactivityClick()
	endif
EndFunc



Func playsound($y)
	SoundSetWaveVolume(50)
	if $y==1 then
		SoundPlay(@ScriptDir & "\turnon.wav")
	elseif $y==0 then
		SoundPlay(@ScriptDir & "\turnoff.wav")
	endif
EndFunc
