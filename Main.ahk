#SingleInstance

INI_PATH = %A_ScriptDir%\Conf.ini

Menu,Tray,NoStandard
Menu,Tray,Icon,images\mouse.ico
Menu,Tray,add,Config(&C),Menu_Ini
Menu,Tray,add
Menu,Tray,add,Restart(&R),Menu_Reload
Menu,Tray,add,Exit(&E),Menu_Exit
Menu,Tray,Click,1

MOUSE_KEYBOARD_MODEL := false
NUMPAD_MOUSE_MODEL := false

; numpad to stimulate mouse click  
IniRead, Use_Numpad, %INI_PATH%, Numpad, UseNumpad, false
if (Use_Numpad == "true")
{
	Hotkey,NumLock,SwitchNumpadMouseModel
	gosub, SwitchNumpadMouseModel
}

	

; only for numpad mode
IniRead, Left_Click, %INI_PATH%, Numpad, ClickLeftMouse
IniRead, Right_Click, %INI_PATH%, Numpad, ClickRightMouse

Hotkey, If, NUMPAD_MOUSE_MODEL
Hotkey, %Left_Click%, ClickLeftMouse
Hotkey, %Right_Click%, ClickRightMouse
Hotkey, If

; start hot key config
iniread,TurnOn,%INI_PATH%,Start,SwitchOnOff
iniread,StartWithLocationMode,%INI_PATH%,Start,StartWithLocationMode
Hotkey,%TurnOn%,SwitchMouseKeyboardModel

iniread,ExitApp_,%INI_PATH%,Start,ExitApp
if ExitApp_
	Hotkey,%ExitApp_%,ExitApp__

Hotkey, If, MOUSE_KEYBOARD_MODEL
iniread,TurnOff,%INI_PATH%,Start,TurnOff
Hotkey,%TurnOff%,SwitchMouseKeyboardModel
      
; mouse module event
iniread,Event,%INI_PATH%,Event
Loop,parse,Event,`n,`r
{
	if (A_LoopField="")
		continue
	
	Fname :=RegExReplace(A_LoopField,"=.*?$")
	Fkey :=RegExReplace(A_LoopField,"^.*?=") 
	
	try
		Hotkey,%Fkey%,%Fname%
	catch
		MsgBox, Error: %A_LoopField%
}
Hotkey, If

#If MOUSE_KEYBOARD_MODEL

#If

#If NUMPAD_MOUSE_MODEL

#If



; start and stop
SwitchMouseKeyboardModel:
	global MOUSE_KEYBOARD_MODEL
    if MOUSE_KEYBOARD_MODEL
	{
		MOUSE_KEYBOARD_MODEL := false
		RestoreSystemCursor()
	}
	else
	{
		MOUSE_KEYBOARD_MODEL := true
		SetSystemCursor()
	}
return 

SwitchNumpadMouseModel:
	global NUMPAD_MOUSE_MODEL
    if (GetKeyState("NumLock", "ON")) 
	{
        NUMPAD_MOUSE_MODEL := true
		SetSystemCursor()
	}
    else  
	{
		NUMPAD_MOUSE_MODEL := false
		RestoreSystemCursor()
	}
	
return


Menu_Ini(){
	global INI_PATH
	Run,%INI_PATH%
}
	
Menu_Reload(){
	Reload
}
	
	
Menu_Exit(){
	ExitApp
}

ExitApp__:
	ExitApp
return

#Include Functions.ahk
