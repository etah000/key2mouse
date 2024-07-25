#SingleInstance
SetDefaultMouseSpeed, 0
DetectHiddenWindows, On
customDPI := A_ScreenDPI/96
hintSize :=  20
winc_presses := 0
numberOfRows := 26
numberOfCols := 26
rowSpacing := hintSize + ( (A_ScreenHeight - numberOfRows * (hintSize * customDPI) ) / (numberOfRows - 1) ) / customDPI
colSpacing := hintSize + ( (A_ScreenWidth - numberOfCols * (hintSize * customDPI) ) / (numberOfCols - 1) ) / customDPI
AscA := 97
KeyArray := ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

Gui, +AlwaysOnTop +ToolWindow -Caption -DPIScale +HwndGrid +LastFound
Gui, Margin, 0
Gui, Color, 779977
Gui, Font, s13 w70 cFFFF00 bold
WinSet, Transparent, 140

; Display Coordinates 
rowCounter := 0
Loop {
	rowYCoord := rowCounter * rowSpacing
	rowYCoordAlpha := KeyArray[rowCounter+1]
	colCounter := 0
	Loop {
		colXCoord := colCounter * colSpacing
		colXCoordAlpha := KeyArray[colCounter+1]
		;Gui, Add, Progress, w%hintSize% h%hintSize% x%colXCoord% y%rowYCoord% Backgroundfafafa disabled
		;gui, add, Pic, w%hintSize% h%hintSize% x%colXCoord% y%rowYCoord% border 0x201 readonly backgroundtrans c212121, %rowYCoordAlpha%%colXCoordAlpha%
		gui, add, Text, w%hintSize% h%hintSize% x%colXCoord% y%rowYCoord% ,  %rowYCoordAlpha%%colXCoordAlpha%
 
		colCounter := colCounter + 1
	} Until colCounter = numberOfcols			
	rowCounter := rowCounter + 1
} Until rowCounter = numberOfRows

Gui -Caption +AlwaysOnTop +E0x20
Gui, Show, Hide X0 Y0 W%A_ScreenWidth% H%A_ScreenHeight%, CoordGrid



INI_PATH = %A_ScriptDir%\Conf.ini

Menu,Tray,NoStandard
Menu,Tray,Icon,images\mouse.ico
Menu,Tray,add,Config(&C),Menu_Ini
Menu,Tray,add
Menu,Tray,add,Restart(&R),Menu_Reload
Menu,Tray,add,Exit(&E),Menu_Exit
Menu,Tray,Click,1

QUICK_MODE := true
MOUSE_KEYBOARD_MODEL := false
CLICK_KEY := ""

NUMPAD_MOUSE_MODEL := false

; ; 显示AutoHotkey版本
; ; MsgBox, 当前运行的AutoHotkey版本是: %A_AhkVersion%

; ; numpad to stimulate mouse click  
IniRead, NumpadClickOnOff, %INI_PATH%, Numpad, SwitchNumpadOnOff
Hotkey, %NumpadClickOnOff%, SwitchNumpadMouseModel

#If NUMPAD_MOUSE_MODEL

#If

; ; only for numpad mode
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

STARTED := false 

iniread,ExitApp_,%INI_PATH%,Start,ExitApp
if ExitApp_
	Hotkey,%ExitApp_%,ExitApp__


; moves key config,
iniread,DIRE_UP,%INI_PATH%,MouseMove,DIRE_UP
iniread,DIRE_DOWN,%INI_PATH%,MouseMove,DIRE_DOWN
iniread,DIRE_LEFT,%INI_PATH%,MouseMove,DIRE_LEFT
iniread,DIRE_RIGHT,%INI_PATH%,MouseMove,DIRE_RIGHT

iniread,DEFAULT_SPEED,%INI_PATH%,MouseMove,DEFAULT_SPEED
iniread,QUICK_MODE_UP_SPEED,%INI_PATH%,MouseMove,QUICK_MODE_UP_SPEED
iniread,NORMAL_MODEL_UP_SPEED,%INI_PATH%,MouseMove,NORMAL_MODEL_UP_SPEED

iniread,TO_LOCATION_MODE,%INI_PATH%,MouseMove,TO_LOCATION_MODE

Hotkey, If, MOUSE_KEYBOARD_MODEL
Hotkey,%DIRE_UP%,MouseMoveByKey 
Hotkey,%DIRE_DOWN%,MouseMoveByKey
Hotkey,%DIRE_RIGHT%,MouseMoveByKey
Hotkey,%DIRE_LEFT%,MouseMoveByKey
Hotkey,%TO_LOCATION_MODE%,SwitchToLocationMode

iniread,TurnOff,%INI_PATH%,Start,TurnOff
Hotkey,%TurnOff%,TurnOffMouseKeyboardMode

       
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
	
	if (Fname == "ClickLeftMouse")
		CLICK_KEY := Fkey
	
}




#IfWinActive CoordGrid
	
	/*	
	CapsLock::
		WinSet, Transparent, 200, CoordGrid
		KeyWait, CapsLock  ; Wait for user to physically release it.
		WinSet, Transparent, 140, CoordGrid
		return
	*/
	
	esc::
		Gui, Hide
		gosub, TurnOnMouseKeyboardMode
	return 


	~a:: gosub, RunKey
	~b:: gosub, RunKey
	~c:: gosub, RunKey
	~d:: gosub, RunKey
	~e:: gosub, RunKey
	~f:: gosub, RunKey
	~g:: gosub, RunKey
	~h:: gosub, RunKey
	~i:: gosub, RunKey
	~j:: gosub, RunKey
	~k:: gosub, RunKey
	~l:: gosub, RunKey
	~m:: gosub, RunKey
	~n:: gosub, RunKey
	~o:: gosub, RunKey
	~p:: gosub, RunKey
	~q:: gosub, RunKey
	~r:: gosub, RunKey
	~s:: gosub, RunKey
	~t:: gosub, RunKey
	~u:: gosub, RunKey
	~v:: gosub, RunKey
	~w:: gosub, RunKey
	~x:: gosub, RunKey
	~y:: gosub, RunKey
	~z:: gosub, RunKey

	Runkey:
	      global winc_presses
	      winc_presses += 1
	      if winc_presses = 2  
	      {
			NavigateToCoord()
			winc_presses = 0
			
	        global QUICK_MODE 
			global DEFAULT_SPEED 
			QUICK_MODE := false
			goSub, TurnOnMouseKeyboardMode 
         	}
	Return	

	NavigateToCoord()
	{
		CoordMode, Mouse, Window
		global numberOfRows, numberOfCols, rowSpacing, colSpacing, customDPI

		XCoordInput := SubStr(A_ThisHotkey,2,1)
		YCoordInput := SubStr(A_PriorHotkey,2,1)
		XCoordToUse := ConvertInputCoord(XcoordInput, "X")
		YCoordToUse := ConvertInputCoord(YcoordInput, "Y")

		XCoord := (XCoordToUse+0.26) * colSpacing * customDPI
		YCoord := (YCoordToUse-0.60) * rowSpacing * customDPI


		MouseMove, %XCoord%, %YCoord%, 0
		Gui Hide
		;Click
		Return
	}

	ConvertInputCoord(coordInput, XorY)
	{
		global AscA
		coordAsc := Asc(coordInput)
		if (XorY = "X") {
			coordToUse := coordAsc - AscA
		}
		else {
			coordToUse := coordAsc - AscA + 1
		}
		coordToUse := floor(coordToUse) 
		Return coordToUse
	}
#IfWinActive


#If MOUSE_KEYBOARD_MODEL

#If


MouseMoveByKey:
	global DEFAULT_SPEED
	global QUICK_MODE

	speed := DEFAULT_SPEED

	x_speed := 0
	y_speed := 0
	
	cur_k := LTrim(A_ThisHotkey, "~")

	; MsgBox, % "这个函数是由按键组合:" cur_k "触发的。"	

	If ( QUICK_MODE)
		speed := speed + QUICK_MODE_UP_SPEED
	else
		speed := speed + NORMAL_MODEL_UP_SPEED
	
	If (cur_k == DIRE_RIGHT)
	{
		x_speed := speed
	}
	else If (cur_k == DIRE_LEFT)
	{
		x_speed := -speed
	}
	else If (cur_k == DIRE_DOWN)
	{
		y_speed := speed
	}
	else If (cur_k == DIRE_UP)
	{
		y_speed := -speed
	}

	x := x_speed
	y := y_speed
	MouseMove, x, y, 0, R
Return

Start:
	global STARTED
	STARTED := true
	if ( StartWithLocationMode == "true") {
	  Gui, Show
	} else {
	  goSub, TurnOnMouseKeyboardMode 
	}
return 

Stop:
	Gui, hide
        
	gosub, TurnOffMouseKeyboardMode
	
	global STARTED
	STARTED := false
return 

; start and stop
SwitchMouseKeyboardModel:
	global STARTED
        if STARTED
		gosub, Stop
	else
		gosub, Start
return 

TurnOnMouseKeyboardMode:
	global MOUSE_KEYBOARD_MODEL
	MOUSE_KEYBOARD_MODEL := true
	SetSystemCursor()
return


TurnOffMouseKeyboardMode:

	global MOUSE_KEYBOARD_MODEL
	If MOUSE_KEYBOARD_MODEL
	{
		MOUSE_KEYBOARD_MODEL := false
		RestoreSystemCursor()
	}
return 


SwitchToLocationMode:
	gosub, TurnOffMouseKeyboardMode
	Gui, Show
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

SwitchNumpadMouseModel:
	global NUMPAD_MOUSE_MODEL
	if NUMPAD_MOUSE_MODEL
	{
        NUMPAD_MOUSE_MODEL := false
		RestoreSystemCursor()
	}
    else  
	{
		gosub, TurnOffMouseKeyboardMode
		NUMPAD_MOUSE_MODEL := true
		SetSystemCursor()
	}
		 
return

#Include Functions.ahk
