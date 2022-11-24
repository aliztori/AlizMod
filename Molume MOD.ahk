
; Volume Scroll With Mouse (Moulume MOD)
; V1
; By Aliztori


; You Can Use This Script to Move Your Mouse to The Edges of Your Monitor(s)
; and Increase or Decrease The Volume of Your System by Scrolling.



CoordMode, Mouse, Screen
SendMode, Input

#NoEnv
#NoTrayIcon
#Singleinstance Force
#MaxHotkeysPerInterval 120

Edge := 40	;Change this to Modify the range.

;This Two line Get Width and height of the virtual screen, in pixels.
;The virtual screen is the bounding rectangle of all display monitors.
; More: https://www.autohotkey.com/docs/commands/SysGet.htm

; You Can Use A_Screenheight & A_Screenwidth Instead But Only The Main Monitor Is Included.

SysGet, Width, 78
SysGet, Height, 79	



WheelUp::
WheelDown::

	MouseGetPos, x, y
	
	Top := y <= Edge, Bottom := y >= Height - Edge
	Left := x <= Edge, Right := x >= Width - Edge

	If (Top || Bottom || Left || Right)
	{
		If (A_ThisHotkey = "WheelDown")
			Send, {Volume_Down}
		
		Else If (A_ThisHotkey = "WheelDown")
			Send, {Volume_Up}
	}

	Else
		Send, {%A_ThisHotkey%}

Return



#WheelDown::

	Suspend
	If (A_IsSuspended)
		Tippy(ScriptName " Suspend")
	Else
		Tippy(ScriptName " Unsuspend")

Return



#WheelUp::

	Tippy("Exiting " ScriptName " ...")
	Sleep, 1000

ExitApp



Tippy(Text := "", Time := 1000)
{	
	ToolTip % Text
	SetTimer, Tip, % Time
	Return
	
	Tip:
	SetTimer, Tip, Off
	ToolTip
	Return
}
