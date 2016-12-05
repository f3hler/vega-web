#include <Date.au3>
#include <Array.au3>
#include <ImageSearch2015.au3>
#include <AutoItConstants.au3>
;~ Global $title_main = "KIXEYE.com - Mozilla Firefox"
;~ Global $title_main = "KIXEYE - VEGA Conflict - Mozilla Firefox"
Global $title_main = "[REGEXPTITLE:KIXEYE.*]"
;~ Global $title_main = "10.141.2.154 - Remote Desktop Connection"
Global $Debug_sleep=1000
Global $actionOnlyRepair=0		; !только ремонт!
Global $actionReturnFleets=0
Global $btn_Fleet[7][4]
Global $fleetActive_b=0 ; кол-во флотов для фарма. начльная цыфра+1 		!!!!!!!!!!!!!!!!!!!
Global $fleetActive_e=4 ; кол-во флотов для фарма. конечная цыфра+1 		!!!!!!!!!!!!!!!!!11
Global $btn_Tags_max=3	;кол-во флотов для поиска из закладок
Global $btn_Tags_min=0

;------------------
; активные флоты
;------------------
Local $activeFleets_data = "1,2,3,4,5"
Global $fleetActive=StringSplit($activeFleets_data, ",")
If IsArray($fleetActive) Then
	ConsoleWrite("$fleetActive ="& UBound($fleetActive)-1&@CRLF )
	For $p=1 To $fleetActive[0]
		$fleetActive[$p] = $fleetActive[$p]-1
		ConsoleWrite('$fleetActive['&$p&']= '&$fleetActive[$p] & @LF)
	Next
EndIf
;-----------------
; активные цели
;-----------------
Local $targets_data = "3,4"
Global $targets_Array=StringSplit($targets_data, ",")
Global $arrayTargetsLenght = UBound($targets_Array)
If IsArray($targets_Array) Then
	local $arrayLenght2 = UBound($targets_Array)
	ConsoleWrite("$targets_Array ="& $arrayLenght2-1&@CRLF )
	For $p=1 To $targets_Array[0]
		$targets_Array[$p] = $targets_Array[$p]-1
		ConsoleWrite('$targets_Array['&$p&']= '&$targets_Array[$p] & @LF)
	Next
EndIf

;#AutoIt3Wrapper_Run_Debug_Mode = Y
;#AutoIt3Wrapper_Run_Debug = On
HotKeySet("p", "findReadyFleet")
HotKeySet("x", "VEGA_exit")
HotKeySet("{F6}","Quit")
Global $VEGA_win[2]	;VEGA winhandle and control if any
Global $VEGA_win_pos[4];=WinGetPos  ( "VEGA 55Conflict" )
;Global $button_BP[0]=
;Global $button_BP[1]=
Global $cap_left_game_img
$cap_left_game_img='img\cap_left_deck.gif'
Global $btn_reload_game[2]
Global $lost_connection_img='img\lost_connection.gif'
Global $btn_reload_game[2]
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;$VEGA_win_pos[0]=1024
;$VEGA_win_pos[1]=768
;$VEGA_win_pos[3]=768
Global $wait_attack_max_time=8000 ; in milliseconds3e
Global $btn_fleet_under_attack='img\fleet\fleet_under_attack.gif'
Global $btn_fleet_under_attack_ignore[2]
Global $btn_Fleet_img[9]
$btn_Fleet_img[0]='img\fleet\fleet_empty.gif'
; 0 = empty fleet
$btn_Fleet_img[1]='img\fleet\fleet_inport_ok.gif'
; 1 = in port ok
$btn_Fleet_img[2]='img\fleet\fleet_inport_dmg.gif'
; 2 = in port damaged
$btn_Fleet_img[3]='img\fleet\fleet_idle_out_ok.gif'
; 3 = idle ok
$btn_Fleet_img[4]='img\fleet\fleet_idle_out_dmg.gif'
; 4 = idle damaged
$btn_Fleet_img[5]='img\fleet\fleet_moving_ok.gif'
; 5 = moving ok
$btn_Fleet_img[6]='img\fleet\fleet_moving_dmg.gif'
; 6 = moving damaged
$btn_Fleet_img[7]='img\fleet\fleet_action.gif'
; 7 = in action/battle
$btn_Fleet_img[8]='img\fleet\fleet_inport_repairing.gif'
; 8 = repairing

Global $btn_Fleet_manage_img='img\fleet_manage.gif'
Global $btn_Fleet_menu_img='img\fleet_menu.gif' ;fleet menu img
Global $btn_Fleet_menu[3][2] ;x/y position of 3 states menu
;Global $btn_Fleet_menu_y1=536
;Global $btn_Fleet_menu_y2=582
Global $btn_Attack_active_img='img\attack_active.gif'
Global $btn_Fleet_warp_img='img\fleet_warp_img.gif'

;bottom buttons coords
local $btn_coords_y1=985
local $btn_coords_y2=1052

; INSTANT REPAIR BUTTON
;KIXEYE
;~ Global $btn_repair_image='fleet_instant_repair.gif';
global $y = 0, $x = 0
;FB
Global $btn_repair_image='img\fleet_instant_repair_fb_selected.gif';
;~ Global $btn_repair_image='fleet_instant_repair_fb_not_selected'
Global $btn_repair_fleet_img='img\fleet_repair_btn.png'
;~ Global $btn_repair_instant_planet_img='fleet_instant_repair_planet.png'
Global $btn_repair_instant_planet_img='img\fleet_instant_free_planet_01.png'


Global $img_btn_remove_from_fleet='img\remove_from_fleet.bmp'
Global $img_btn_add_to_fleet='img\add_to_fleet.bmp'
Global $img_btn_launch_fleet='img\launch_fleet.bmp'


; change from left


;##################1#########################
; need to convert to % from top/bottom/right
;###########################################

Vega_Active()
VEGA_Calibrate()
VEGA_Main()
;~ test()

Func test()
	MouseMove($VEGA_win_pos[0],$VEGA_win_pos[1])
	Sleep(1000)
	For $i=0 to 5
;~ 		MouseMove($ShipInFleet_StatusRedGreenNumber_coords[$i][0],$ShipInFleet_StatusRedGreenNumber_coords[$i][1])
;~ 		Sleep(1000)
;~ 		$fleet_demaged = PixelSearch($ShipInFleet_StatusRedGreenNumber_coords[$i][0] , $ShipInFleet_StatusRedGreenNumber_coords[$i][1], $ShipInFleet_StatusRedGreenNumber_coords[$i][0]+2, $ShipInFleet_StatusRedGreenNumber_coords[$i][1]-2, 0x73393A,25) ;только красненькие 0x713838
;~ 		sleep(200)
;~ 		If IsArray($fleet_demaged) > 0 Then
;~ 			ConsoleWrite($i & " RED " & @CRLF)
;~ 		Else
;~ 			ConsoleWrite($i & " GREEN " & @CRLF)
;~ 		EndIf
	Next
EndFunc

Func Vega_Active()
	WinActivate($title_main)
	if WinWait($title_main, "", 3) = 0 then
		ConsoleWrite('VEGA window is not ACTIVE! "WinWait "'&@CRLF)
		Vega_Active()
	EndIf
EndFunc

Func VEGA_Main()
while 1 ;main loop
   sleep(200)
;~    for $i=$fleetActive_b to $fleetActive_e step 1 ;for $i=0 to 6 step 1
	For $i=1 To $fleetActive[0]
		local $currentFleet = $fleetActive[$i]
;~ 		ConsoleWrite('$currentFleet '& $currentFleet&@CRLF)
	  ; 0 = empty fleet
	  ; 1 = in port ok
	  ; 2 = in port damaged
	  ; 3 = idle ok
	  ; 4 = idle damaged
	  ; 5 = moving ok
	  ; 6 = moving damaged
	  ; 7 = in action/battle
	  ; 8 = repairing
	  local $FleetStatus=VEGA_CheckFleet($currentFleet);
;~ 	  ConsoleWrite('$FleetStatus '& $FleetStatus&@CRLF)
	  switch $FleetStatus
	  Case 0,5,6,7,8	; 8 - check for free repair later
		 ;ConsoleWrite('fleet '&$i&' is unusable for action'&@CRLF)
		 sleep (250)
	 Case 1,3
		 if ($actionOnlyRepair=0) Then
			 ConsoleWrite('fleet '&$currentFleet+1&' in port/idle and ok -> action'&@CRLF)
			 ;MouseClick('left',$btn_Fleet[$i][0]+($btn_Fleet[$i][2]-$btn_Fleet[$i][0])/2,$btn_Fleet[$i][1]+($btn_Fleet[$i][3]-$btn_Fleet[$i][1])/2,1,1)
			 Send($currentFleet+1)
			 VEGA_attack_target($currentFleet,-1) ;$fleet, $tag_number
			 sleep(400)
		 EndIf
	  Case 2
		 ConsoleWrite('fleet '&$currentFleet+1&' in port and damaged -> repair'&@CRLF)
			if VEGA_RepairFleet3($currentFleet) Then
			   consolewrite ('repaired')
			Else
			   consolewrite ('error, not repaired')
			Endif

		 sleep (400)
	  Case 4
		 ConsoleWrite('fleet '&$currentFleet+1&' is idle and damaged -> consider action'&@CRLF)
		 VEGA_ReturnFleet($currentFleet)
	  Case Else
		 ConsoleWrite ('Something went horribly wrong. fleet status is: '&$FleetStatus&@CRLF)
		 local $search=_ImageSearchArea($btn_fleet_under_attack, 0, $VEGA_win_pos[0], $VEGA_win_pos[1], $VEGA_win_pos[0]+$VEGA_win_pos[2], $VEGA_win_pos[1]+$VEGA_win_pos[3], $x, $y, 70 )
		 If $search = 1 Then
			ConsoleWrite('fleet is under attack! trying to ignore...'&@CRLF)
			MouseClick($btn_fleet_under_attack_ignore[0],$btn_fleet_under_attack_ignore[1],1,1)
		 Else
			ConsoleWrite('fleet is not under attack'&@CRLF)
		 EndIf

		 ConsoleWrite ('find if capt left the deck'&@CRLF)
		 local $search = _ImageSearchArea($cap_left_game_img, 0, $VEGA_win_pos[0], $VEGA_win_pos[1], $VEGA_win_pos[0]+$VEGA_win_pos[2], $VEGA_win_pos[1]+$VEGA_win_pos[3], $x, $y, 70 )
		 if $search = 1 Then
			ConsoleWrite('Capt left the deck, reloading game'&@CRLF)
			sleep (500)
			MouseMove($btn_reload_game[0],$btn_reload_game[1],50)
			MouseClick($btn_reload_game[0],$btn_reload_game[1],1,5)
			MouseClick($btn_reload_game[0],$btn_reload_game[1],1,5)
			sleep (5000)
		 Else
			ConsoleWrite('Capt on deck'&@CRLF)
		 EndIf

		 ConsoleWrite ('find if lost connection'&@CRLF)
		 local $search = _ImageSearchArea($lost_connection_img, 0, $VEGA_win_pos[0], $VEGA_win_pos[1], $VEGA_win_pos[0]+$VEGA_win_pos[2], $VEGA_win_pos[1]+$VEGA_win_pos[3], $x, $y, 70 )
		 if $search = 1 Then
			ConsoleWrite('connection lost, reloading game'&@CRLF)
			MouseMove($btn_reload_game[0],$btn_reload_game[1],30)
			sleep (200)
			MouseClick($btn_reload_game[0],$btn_reload_game[1],1,5)
			sleep (5000)
		 Else
			ConsoleWrite('connection not lost'&@CRLF)
		 EndIf

	  EndSwitch
   Next
WEnd
EndFunc

Func SetFleetMenu() ;set fleet menu to correct state
	  ;find fleet menu $btn_Fleet_img[10]
ConsoleWrite (@CRLF&'|'&$VEGA_win_pos[0]&'|'&$VEGA_win_pos[1]&'|'&$VEGA_win_pos[2]&'|'&$VEGA_win_pos[3]&'|'&@CRLF)


local $x
local $y
Local $search = _ImageSearchArea($btn_Fleet_menu_img, 0, $VEGA_win_pos[0], $VEGA_win_pos[1], $VEGA_win_pos[0]+$VEGA_win_pos[2], $VEGA_win_pos[1]+$VEGA_win_pos[3], $x, $y, 90 )
   If $search = 1 Then
	  ConsoleWrite("fleet menu at "&$x&":"&$y&@CRLF)
	  local $i
	  for $i=0 To 2 step 1
		 ConsoleWrite ('check menu at position:'&$i&' must be in '&$btn_Fleet_menu[$i][0]&'<'&$x&'<'&$btn_Fleet_menu[$i][1]&@CRLF)
		 if ($x <= $btn_Fleet_menu[$i][1]) and ($x >= $btn_Fleet_menu[$i][0]) Then
			ConsoleWrite ('menu position is '&$i&@CRLF)
			if $i <> 1 then
			   ConsoleWrite ('menu position not 1, change it'&@CRLF)
			   MouseMove ($x, $y,1)
			   MouseClick ('left', $x+10, $y)
			   if SetFleetMenu()==0 then
				  return 0
			   EndIf
			EndIf
		 EndIf
	  Next
   Else
	  ConsoleWrite("can't find fleet menu"&@CRLF)
	  VEGA_Calibrate()
	  ;WinActivate ( "VEGA Conflict" )
	  return -1
   EndIf
EndFunc

Func findReadyFleet() ;not used
local $x
local $y
   Local $search = _ImageSearchArea('img\checkfleet.gif', 0, $VEGA_win_pos[0], $VEGA_win_pos[1], $VEGA_win_pos[0]+$VEGA_win_pos[2], $VEGA_win_pos[1]+$VEGA_win_pos[3], $x, $y, 90 )
   If $search = 1 Then
      Beep();
	  ;ConsoleWrite("fleet ready location: "&$x&":"&$y&@CRLF)
      ;MouseMove($x, $y, 1)
   Else
	  ;ConsoleWrite("fleet ready location not found"&@CRLF)
	  SetFleetMenu()
   EndIf
EndFunc

Func VEGA_IfInBase () ; check main screen state not used
   local $x
   local $y
   Local $search = _ImageSearchArea('img\InBase.gif', 0, 1, 1, 4096, 2048, $x, $y, 90 )
   If $search = 1 Then
      Beep();
	  ConsoleWrite("In Base: "&$x&":"&$y&@CRLF)
      MouseMove($x, $y, 1)
   Else
	  ConsoleWrite("Not in Base"&@CRLF)
   EndIf

EndFunc

Func VEGA_IfInPlanet () ; check main screen state not used
   local $x
   local $y
   Local $search = _ImageSearchArea('img\InPlanet.gif', 0, 1, 1, 4096, 2048, $x, $y, 90 )
   If $search = 1 Then
      Beep();
	  ConsoleWrite("In Planet: "&$x&":"&$y&@CRLF)
	  ;MouseMove($x, $y, 1)
   Else
	  ConsoleWrite("Not in Planet"&@CRLF)
   EndIf

EndFunc

Func VEGA_IfInSector () ; check main screen state not used
   local $x
   local $y
   Local $search = _ImageSearchArea('img\InSector.gif', 0, 1, 1, 4096, 2048, $x, $y, 100 )
   If $search = 1 Then
      Beep();
	  ConsoleWrite("In Sector: "&$x&":"&$y&@CRLF)
      MouseMove($x, $y, 1)
   Else
	  ConsoleWrite("Not in Sector"&@CRLF)
   EndIf

EndFunc

Func VEGA_IfWinActive()
   ; return handle of VEGA window or 0 if no VEGA found
   Local $hWnd = WinGetHandle("[ACTIVE]") ; handle of active window
   ConsoleWrite('Win handle: '&$hWnd&@CRLF)
   Local $hControl = ControlGetHandle($hWnd, "", "[CLASS:Unity.WebPlayer]") ;if any Unity.WebPlayer instance found in browser
   ; add STEAM support
   ConsoleWrite('control: '&$hControl&@CRLF)

   if $hControl Then
	  ConsoleWrite('Unity.WebPlayer present in active window'&@CRLF)

	  local $tmp_VEGA_win_pos=WinGetPos($hControl )
	  If not $tmp_VEGA_win_pos Then
		 ;If $VEGA_win_pos[0]=$tmp_VEGA_win_pos[0] and $VEGA_win_pos[1]=$tmp_VEGA_win_pos[1] and $VEGA_win_pos[2]=$tmp_VEGA_win_pos[2] and $VEGA_win_pos[3]=$tmp_VEGA_win_pos[3] Then
		;	$VEGA_win[0]=$hWnd
		;	$VEGA_win[1]=$hControl
		;	Return $VEGA_win ; return handle of VEGA window without calibrating
		; EndIf
		 $VEGA_win_pos=$tmp_VEGA_win_pos
		 ConsoleWrite("VEGA X:"&$VEGA_win_pos[0]&" Y:"&$VEGA_win_pos[1]&" width:"&$VEGA_win_pos[2]&" height:"&$VEGA_win_pos[3]&@CRLF)

		 Global $btn_Fleet_menu[3][2]

		 $btn_Fleet_menu[0][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]-280	; From right
		 $btn_Fleet_menu[0][1]=$VEGA_win_pos[0]+$VEGA_win_pos[2]-200
		 $btn_Fleet_menu[1][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]-130
		 $btn_Fleet_menu[1][1]=$VEGA_win_pos[0]+$VEGA_win_pos[2]-75
		 $btn_Fleet_menu[2][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]-50
		 $btn_Fleet_menu[2][1]=$VEGA_win_pos[0]+$VEGA_win_pos[2]
		 Global $btn_Fleet_menu_y1=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-25	;From center
		 Global $btn_Fleet_menu_y2=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+25

local $btn_Fleet_Xstart=$VEGA_win_pos[0]+$VEGA_win_pos[2]-85
local $btn_Fleet_Xend=$VEGA_win_pos[0]+$VEGA_win_pos[2]-40
;local $btn_Fleet_Ystart=$VEGA_win_pos[1]+406

		 Global $btn_Fleet[7][4]

; Find where is -7 delta from center comes

;Fleet 1
$btn_Fleet[0][0]=$btn_Fleet_Xstart
$btn_Fleet[0][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-150-7
$btn_Fleet[0][2]=$btn_Fleet_Xend
$btn_Fleet[0][3]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-107-7

;Fleet 2
$btn_Fleet[1][0]=$btn_Fleet_Xstart
$btn_Fleet[1][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-107-7
$btn_Fleet[1][2]=$btn_Fleet_Xend
$btn_Fleet[1][3]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-64-7

;Fleet 3
$btn_Fleet[2][0]=$btn_Fleet_Xstart
$btn_Fleet[2][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-64-7
$btn_Fleet[2][2]=$btn_Fleet_Xend
$btn_Fleet[2][3]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-22-7

;Fleet 4
$btn_Fleet[3][0]=$btn_Fleet_Xstart
$btn_Fleet[3][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-22-7
$btn_Fleet[3][2]=$btn_Fleet_Xend
$btn_Fleet[3][3]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+22-7

;Fleet 5
$btn_Fleet[4][0]=$btn_Fleet_Xstart
$btn_Fleet[4][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+22-7
$btn_Fleet[4][2]=$btn_Fleet_Xend
$btn_Fleet[4][3]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+64-7

;Fleet 6
$btn_Fleet[5][0]=$btn_Fleet_Xstart
$btn_Fleet[5][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+64-7
$btn_Fleet[5][2]=$btn_Fleet_Xend
$btn_Fleet[5][3]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+107-7

;Fleet 7
$btn_Fleet[6][0]=$btn_Fleet_Xstart
$btn_Fleet[6][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+107-7
$btn_Fleet[6][2]=$btn_Fleet_Xend
$btn_Fleet[6][3]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+150-7


Global $btn_Tags_main[2]
$btn_Tags_main[0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]-193 ;from right
$btn_Tags_main[1]=$VEGA_win_pos[1]+35 ;from top

;change from center ?
Global $btn_Tags_page[3][2]
$btn_Tags_page[0][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-427;230
$btn_Tags_page[0][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-285;130
$btn_Tags_page[1][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-262
$btn_Tags_page[1][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-285
$btn_Tags_page[2][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-107
$btn_Tags_page[2][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-285

Global $btn_Tags_list[12][2]
$btn_Tags_list[0][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[0][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-233
$btn_Tags_list[1][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[1][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-179
$btn_Tags_list[2][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[2][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-125
$btn_Tags_list[3][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[3][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-71
$btn_Tags_list[4][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[4][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-17
$btn_Tags_list[5][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[5][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+37
$btn_Tags_list[6][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[6][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+91
$btn_Tags_list[7][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[7][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+145
$btn_Tags_list[8][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[8][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+199
$btn_Tags_list[9][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[9][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+253
$btn_Tags_list[10][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[10][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+307
$btn_Tags_list[11][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_Tags_list[11][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+361
;~ $btn_Tags_list[12][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
;~ $btn_Tags_list[12][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+415

; TODO - extend list to all targs

local $btn_coords_y1=$VEGA_win_pos[1]+$VEGA_win_pos[3]-90
local $btn_coords_y2=$VEGA_win_pos[1]+$VEGA_win_pos[3]

Global $btn_coords[4][4] ;btn[number][x1,y1,x2,y2];
$btn_coords[0][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-192
$btn_coords[0][1]=$btn_coords_y1
$btn_coords[0][2]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-96
$btn_coords[0][3]=$btn_coords_y2

$btn_coords[1][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-96
$btn_coords[1][1]=$btn_coords_y1
$btn_coords[1][2]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_coords[1][3]=$btn_coords_y2

$btn_coords[2][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_coords[2][1]=$btn_coords_y1
$btn_coords[2][2]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+96
$btn_coords[2][3]=$btn_coords_y2

$btn_coords[3][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+96
$btn_coords[3][1]=$btn_coords_y1
$btn_coords[3][2]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+192
$btn_coords[3][3]=$btn_coords_y2

Global $FleetManagerClosebtn_coords[2]
$FleetManagerClosebtn_coords[0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+480
$FleetManagerClosebtn_coords[1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-354


Global $RepairFleetBtn[2]
$RepairFleetBtn[0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+372
$RepairFleetBtn[1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+113

Global $btn_repair_cost_coords[4]
; KIXYEY site
;btn_repair_cost_coords[0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-310
;$btn_repair_cost_coords[1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-90
;$btn_repair_cost_coords[2]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+445
;$btn_repair_cost_coords[3]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-35

; FACEBOOK site
$btn_repair_cost_coords[0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+200
$btn_repair_cost_coords[1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-100
$btn_repair_cost_coords[2]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+500
$btn_repair_cost_coords[3]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-35


Global $ShipInFleet_coords[6][2]
$ShipInFleet_coords[0][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-135
$ShipInFleet_coords[0][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-156

$ShipInFleet_coords[1][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$ShipInFleet_coords[1][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-156

$ShipInFleet_coords[2][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+135
$ShipInFleet_coords[2][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-156

$ShipInFleet_coords[3][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-135
$ShipInFleet_coords[3][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-21

$ShipInFleet_coords[4][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-0
$ShipInFleet_coords[4][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-21

$ShipInFleet_coords[5][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-135
$ShipInFleet_coords[5][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-21

Global $ShipInFleet_StatusRedGreenNumber_coords[6][2]
$ShipInFleet_StatusRedGreenNumber_coords[0][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-194
$ShipInFleet_StatusRedGreenNumber_coords[0][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-197

$ShipInFleet_StatusRedGreenNumber_coords[1][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-59
$ShipInFleet_StatusRedGreenNumber_coords[1][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-197

$ShipInFleet_StatusRedGreenNumber_coords[2][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+76
$ShipInFleet_StatusRedGreenNumber_coords[2][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-197

$ShipInFleet_StatusRedGreenNumber_coords[3][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-194
$ShipInFleet_StatusRedGreenNumber_coords[3][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-62

$ShipInFleet_StatusRedGreenNumber_coords[4][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-59
$ShipInFleet_StatusRedGreenNumber_coords[4][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-62

$ShipInFleet_StatusRedGreenNumber_coords[5][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+76
$ShipInFleet_StatusRedGreenNumber_coords[5][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-62

Global $ShipInFleet_StatusLine_coords[6][3]
$ShipInFleet_StatusLine_coords[0][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-191
$ShipInFleet_StatusLine_coords[0][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-98

$ShipInFleet_StatusLine_coords[1][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-56
$ShipInFleet_StatusLine_coords[1][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-98

$ShipInFleet_StatusLine_coords[2][0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+79
$ShipInFleet_StatusLine_coords[2][1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-98


Global $LastShip_coords[2]
$LastShip_coords[0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-433
$LastShip_coords[1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-208

Global $LastShip_page[2]
$LastShip_page[0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2-421
$LastShip_page[1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2-285

Global $btn_notarget[2]
$btn_notarget[0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_notarget[1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+90

Global $btn_fleet_under_attack_ignore[2]
$btn_fleet_under_attack_ignore[0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2+100
$btn_fleet_under_attack_ignore[1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+100

Global $btn_reload_game[2]
$btn_reload_game[0]=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
$btn_reload_game[1]=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2+85 ; TODO - check Y location

Global $btn_remove_from_fleet[4]
$btn_remove_from_fleet[0]=925
$btn_remove_from_fleet[1]=900
$btn_remove_from_fleet[2]=1085
$btn_remove_from_fleet[3]=925
Global $btn_add_to_fleet[4]
$btn_add_to_fleet[0]=940
$btn_add_to_fleet[1]=900
$btn_add_to_fleet[2]=1050
$btn_add_to_fleet[3]=920
Global $btn_launch_fleet[4]
$btn_launch_fleet[0]=955
$btn_launch_fleet[1]=905
$btn_launch_fleet[2]=1060
$btn_launch_fleet[3]=920

	  Else
		 ConsoleWrite('VEGA window size is unknown'&@CRLF)
	  EndIf
	  Return $VEGA_win ; return handle of VEGA window
   Else
	  ConsoleWrite('No Unity.WebPlayer in active window'&@CRLF)
	  ;add here STEAM support
	  Return 0 ; return 0 if no VEGA found
   EndIf
EndFunc

Func VEGA_Calibrate() ;not used - use for relative coords
   while 1
	  if @DesktopWidth<>1920 or @DesktopHeight<>1080 Then
		 ;ConsoleWrite('Desktop should be 1920x1080 but current settings is: '&@DesktopWidth&':'&@DesktopHeight&@CRLF)
	  EndIf


	  local $hControl=VEGA_IfWinActive()

	  if $hControl = 0 Then
		 ConsoleWrite('VEGA window is not ACTIVE!'&@CRLF&'handle'&@CRLF)
		 if ControlFocus ($VEGA_win[0], "", "[CLASS:Unity.WebPlayer]") =1 Then
			ConsoleWrite('Ok set control focus - something strange')
			Sleep (2000)
		 else
			ConsoleWrite('ERROR setting focus to control')
			Sleep (5000)
		 EndIf
		 Else	;found VEGA Unity WebPlayer
		 ConsoleWrite('VEGA window is ACTIVE!'&@CRLF&'handle'&@CRLF)
 		 if ControlFocus ($VEGA_win[0], "", "[CLASS:Unity.WebPlayer]") =1 Then
			ConsoleWrite('Ok set control focus'&@CRLF)
			;$VEGA_win_pos=ControlGetPos($VEGA_win[0], "", "[CLASS:Unity.WebPlayer]");

			Sleep (2000)
			return 0
		 else
			ConsoleWrite('ERROR setting focus to control'&@CRLF)
			Sleep (5000)
		 EndIf
	  EndIf
   WEnd

   ; code up to EndFunc should be removed

   local $x
   local $y
   Local $search = _ImageSearchArea('img\BuildIcon.bmp', 0, 1, 1, 4096, 2048, $x, $y, 100 )
   If $search = 1 Then
      Beep();
	  ConsoleWrite("build location: "&$x&":"&$y&@CRLF)
      MouseMove($x, $y, 1)
   Else
	  ConsoleWrite("build location not found"&@CRLF)
   EndIf

   ;VEGA_IfInBase ()
   ;VEGA_IfInPlanet ()
   ;VEGA_IfInSector ()
   ;VEGA_clickBase ()

EndFunc

Func VEGA_exit ()
 Exit
EndFunc

Func VEGA_clickBase () ; not used
   ;MouseClick ( "left" , $VEGA_win_pos[0]+$VEGA_win_pos[2]-151, $VEGA_win_pos[1]+$VEGA_win_pos[3]-82 , 1 , 1 )
EndFunc

Func VEGA_CheckFleet( $FleetNumber=0) ;return fleet status
   local $fleetstatus = 0
   ; 0 = empty fleet
   ; 1 = in port ok
   ; 2 = in port damaged
   ; 3 = idle ok
   ; 4 = idle damaged
   ; 5 = moving ok
   ; 6 = moving damaged
   ; 7 = in action/battle
if $FleetNumber<0 or $FleetNumber>6 Then
	return -1
EndIf

;local $x
;Localocal $y
local $i
local $j
;for $i=0 to 3 step 1 ;fleets 0-3
   $i=$FleetNumber
   for $j=0 to 7 ; look for fleet status
	  ;consolewrite("i: "&$i&" j: "&$j&" "&'-'&" "&@CRLF)
	  ;MouseMove($btn_Fleet[$i][0], $btn_Fleet[$i][1], 1)
	  ;MouseMove($btn_Fleet[$i][2], $btn_Fleet[$i][3], 1)
	  ;Sleep (2000)
	  Local $search = _ImageSearchArea( $btn_Fleet_img[$j], 0, $btn_Fleet[$i][0], $btn_Fleet[$i][1], $btn_Fleet[$i][2], $btn_Fleet[$i][3], $x, $y, 90 )

	  If $search = 1 Then
		 ;MouseMove($x, $y, 1)
		 ;MouseClick ('left', $x, $y)
		 ;send($i+1)
		 ;ConsoleWrite("Fleet: "&$i&" status: "&$j&@CRLF)	;" btn_coords: "&$x&":"&$y&@CRLF)
		 $fleetstatus=$j
		 Return $fleetstatus
	  else
		 ;ConsoleWrite("Fleet: "&$i&" status: "&$j&" not found at coords: "&$btn_Fleet[$i][0]&":"&$btn_Fleet[$i][1]&":"&$btn_Fleet[$i][2]&":"&$btn_Fleet[$i][3]&@CRLF)
	  EndIf
   Next

;Next
   SetFleetMenu()
   Return -1	;status not found
EndFunc

Func VEGA_RepairIsFree()

   MouseMove($btn_repair_cost_coords[0]+($btn_repair_cost_coords[2]-$btn_repair_cost_coords[0])/2, $btn_repair_cost_coords[1]+($btn_repair_cost_coords[3]-$btn_repair_cost_coords[1])/2,1)
;~    MouseMove ($btn_repair_cost_coords[0], $btn_repair_cost_coords[1],20)
;~    sleep(2000)
;~    MouseMove ($btn_repair_cost_coords[2], $btn_repair_cost_coords[3],20)
   sleep (200)
   ;MouseMove($btn_repair_cost_coords[0], $btn_repair_cost_coords[1],20)
   ;MouseMove($btn_repair_cost_coords[2], $btn_repair_cost_coords[1],20)
   ;MouseMove($btn_repair_cost_coords[2], $btn_repair_cost_coords[3],20)
   ;MouseMove($btn_repair_cost_coords[0], $btn_repair_cost_coords[3],20)
   local $x=0
   local $y=0

   ;Local $search = _ImageSearchArea( $btn_repair_image, 0, $btn_repair_cost_coords[0], $btn_repair_cost_coords[1], $btn_repair_cost_coords[2], $btn_repair_cost_coords[3], $x, $y, 90 )
   ;Works w/Kixeye
   ;Local $search = _ImageSearchArea( $btn_repair_image, 0, $VEGA_win_pos[0], $VEGA_win_pos[1], $VEGA_win_pos[0]+$VEGA_win_pos[2], $VEGA_win_pos[1]+$VEGA_win_pos[3], $x, $y, 70 )
   ; Facebook
   Local $search = _ImageSearchArea( $btn_repair_image, 0, $btn_repair_cost_coords[0], $btn_repair_cost_coords[1], $btn_repair_cost_coords[2], $btn_repair_cost_coords[3], $x, $y, 70 )

   ;TEMP !!!
   ;$search=0
   if $search = 1 Then
	  ConsoleWrite ('found repair is free '&$x&':'&$y&@CRLF)
	  ;MouseMove($btn_repair_cost_coords[0]+($btn_repair_cost_coords[2]-$btn_repair_cost_coords[0])/2, $btn_repair_cost_coords[1]+($btn_repair_cost_coords[3]-$btn_repair_cost_coords[1])/2,1)
	  ;MouseMove($x,$y,50)
	  ;sleep (250)
	  ;MouseClick('left',$btn_repair_cost_coords[0]+($btn_repair_cost_coords[2]-$btn_repair_cost_coords[0])/2, $btn_repair_cost_coords[1]+($btn_repair_cost_coords[3]-$btn_repair_cost_coords[1])/2,1)
	  ;MouseClick($x,$y,1,50)
	  ;sleep(500)
	  ConsoleWrite('img found at X:'&$x&' Y:'&$y&@CRLF)

	  MouseClick('left',$x,$y,2,1)
	  ConsoleWrite('CLICKED'&@CRLF)
	  sleep(200)
	  ;click 'repair'
	  return True
   else
	  ConsoleWrite ($search&@CRLF)

	  ConsoleWrite ('repair is free not found '&$btn_repair_cost_coords[0]&"x"&$btn_repair_cost_coords[1]&" "&$btn_repair_cost_coords[2]&"x"&$btn_repair_cost_coords[3]&@CRLF)
;~   	  MouseMove($btn_repair_cost_coords[0],$btn_repair_cost_coords[1],50)
;~ 	  MouseMove($btn_repair_cost_coords[2],$btn_repair_cost_coords[1],40)
;~ 	  MouseMove($btn_repair_cost_coords[2],$btn_repair_cost_coords[3],40)
;~ 	  MouseMove($btn_repair_cost_coords[0],$btn_repair_cost_coords[3],40)

	  return False
   EndIf

	  ;sleep (10000)
   return False
EndFunc

Func Vega_RemoveShip($ship_numb)
	;MouseMove($ShipInFleet_coords[$ship_numb][0],$ShipInFleet_coords[$ship_numb][1],1)
	sleep(100)
	MouseMove($ShipInFleet_coords[$ship_numb][0],$ShipInFleet_coords[$ship_numb][1],1)
	MouseClick('left',$ShipInFleet_coords[$ship_numb][0],$ShipInFleet_coords[$ship_numb][1],1,1)
	sleep(500)

	local $x=0
	local $y=0
	Local $search = _ImageSearchArea( $img_btn_remove_from_fleet, 1, $btn_remove_from_fleet[0], $btn_remove_from_fleet[1], $btn_remove_from_fleet[2], $btn_remove_from_fleet[3], $x, $y, 70 )
	sleep(300)
	if $search = 1 Then
		ConsoleWrite ('found remove_from_fleet btn '&$x&':'&$y&@CRLF)
		MouseClick('left',$x,$y,1,1)
		ConsoleWrite('CLICKED'&@CRLF)
		sleep(200)
	Else
		ConsoleWrite ('not found remove_from_fleet btn '&$x&':'&$y&@CRLF)
	EndIf
	;~    MouseClick('left',$ShipInFleet_coords[$ship_numb][0],$ShipInFleet_coords[$ship_numb][1],2,1)
;~    sleep(100)
EndFunc

Func Vega_AddShip($ship_numb)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   sleep(200)
   MouseMove($ShipInFleet_coords[$ship_numb][0],$ShipInFleet_coords[$ship_numb][1],5)
   sleep(100)
   MouseClick('left',$ShipInFleet_coords[$ship_numb][0],$ShipInFleet_coords[$ship_numb][1],1,5)
   sleep(500)
   ;MouseClick('left',543+$VEGA_win_pos[0],273+$VEGA_win_pos[1],1,1)
   ;sleep (300)
   ;MouseClick('left',$LastShip_coords[0],$LastShip_coords[1],1,1)
   ;sleep(300)
   sleep(200)
   MouseMove($LastShip_page[0],$LastShip_page[1],1)
   sleep(100)
   MouseClick('left',$LastShip_page[0],$LastShip_page[1],1,1)
   sleep(300)
   MouseMove($LastShip_coords[0],$LastShip_coords[1],1)
   sleep(100)
   MouseClick('left',$LastShip_coords[0],$LastShip_coords[1],1,5)
   sleep(500)

	local $x=0
	local $y=0
	Local $search = _ImageSearchArea( $img_btn_add_to_fleet, 1, $btn_add_to_fleet[0], $btn_add_to_fleet[1], $btn_add_to_fleet[2], $btn_add_to_fleet[3], $x, $y, 70 )
	sleep(300)
	if $search = 1 Then
		ConsoleWrite ('found add_to_fleet btn '&$x&':'&$y&@CRLF)
		MouseClick('left',$x,$y,1,1)
		ConsoleWrite('CLICKED'&@CRLF)
		sleep(200)
	Else
		ConsoleWrite ('not found add_to_fleet btn '&$x&':'&$y&@CRLF)
	EndIf

;~    sleep(50)
;~    MouseClick('left',$LastShip_coords[0],$LastShip_coords[1],1,5)
   ;sleep(10)
   ;MouseClick('left',$LastShip_coords[0],$LastShip_coords[1],1,1)
   sleep(300)
EndFunc

Func VEGA_RepairFleet3($FleetNumber=0) ;repairing fleet in FLEET MANGER
	sleep (500)
	Global $arrRepairFleet[0]
	if VEGA_IfManageBtn('click',$FleetNumber) <> -1 Then; is button manage clicked ?
		if VEGA_RepairIsFree() Then
			ConsoleWrite("Fleet repaired, closing fleet manager");
			VEGA_FleetManagerClose()
			return 1 ;FleetRepaired
		EndIf

		; разбираем флот для ремонта
		for $i=0 to 5 step 1	;for each ship in fleet
			local $fleet_demaged = PixelSearch($ShipInFleet_StatusRedGreenNumber_coords[$i][0] , $ShipInFleet_StatusRedGreenNumber_coords[$i][1], $ShipInFleet_StatusRedGreenNumber_coords[$i][0]+2, $ShipInFleet_StatusRedGreenNumber_coords[$i][1]-2, 0x73393A,25) ;только красненькие 0x713838
			sleep (200)
			If IsArray($fleet_demaged) > 0 Then
				ConsoleWrite("Ship["&$i & "] - RED " & @CRLF)
				Vega_RemoveShip($i)
				; заполняем массив нашими ранеными
				_ArrayAdd($arrRepairFleet, $i)
				Sleep (200)
				if (VEGA_RepairIsFree()) Then ExitLoop
			Else
				ConsoleWrite("Ship["&$i & "] - GREEN " & @CRLF)
			EndIf

		Next

		For $i=0 to 5
;~ 		MouseMove($ShipInFleet_StatusRedGreenNumber_coords[$i][0],$ShipInFleet_StatusRedGreenNumber_coords[$i][1])
;~ 		Sleep(1000)
		$fleet_demaged = PixelSearch($ShipInFleet_StatusRedGreenNumber_coords[$i][0] , $ShipInFleet_StatusRedGreenNumber_coords[$i][1], $ShipInFleet_StatusRedGreenNumber_coords[$i][0]+2, $ShipInFleet_StatusRedGreenNumber_coords[$i][1]-2, 0x73393A,25) ;только красненькие 0x713838
		sleep(200)
		If IsArray($fleet_demaged) > 0 Then
			ConsoleWrite($i & " RED " & @CRLF)
		Else
			ConsoleWrite($i & " GREEN " & @CRLF)
		EndIf
	Next


		; собираем флот обратно
		If IsArray($arrRepairFleet) Then
			local $arrayLenght = UBound($arrRepairFleet)
			_ArrayReverse($arrRepairFleet)
;~ 			ConsoleWrite("NEW $arrayLenght ="& $arrayLenght&@CRLF )
			For $k=0 To $arrayLenght-1
;~ 				ConsoleWrite($arrRepairFleet[$k] & @LF)
				Vega_AddShip($arrRepairFleet[$k])
				sleep(300)
				VEGA_RepairIsFree()
				sleep(250)
			Next
		EndIf

		MouseClick('left',$RepairFleetBtn[0],$RepairFleetBtn[1],1,1)
		sleep (200)
		VEGA_FleetManagerClose()
	EndIf
   ;ConsoleWrite ('return from repairing -1'&@CRLF)
	return -1 ;manage button not clicked
EndFunc

Func VEGA_RepairFleet($FleetNumber=0) ;repairing fleet in FLEET MANGER
	sleep (500)
	if VEGA_IfManageBtn('click',$FleetNumber) <> -1 Then; is button manage clicked ?
		if VEGA_RepairIsFree() Then
			ConsoleWrite("Fleet repaired, closing fleet manager");
			VEGA_FleetManagerClose()
			return 1 ;FleetRepaired
		EndIf

		local $RemovedShips=0
		for $i=0 to 4 step 1	;for each ship in fleet
			sleep (200)
			Vega_RemoveShip($i)
			Sleep (200)
		Next
		sleep (200)
		VEGA_RepairIsFree()
		sleep (300)

		for $j=$i-1 to 0 step -1
 			Vega_AddShip($j)
			sleep(300)
			VEGA_RepairIsFree()
			sleep(250)
		Next

		MouseClick('left',$RepairFleetBtn[0],$RepairFleetBtn[1],1,1)
		sleep (200)
	  VEGA_FleetManagerClose()
	EndIf
   ;ConsoleWrite ('return from repairing -1'&@CRLF)
   return -1 ;manage button not clicked
EndFunc

Func VEGA_RepairFleet2($FleetNumber=0) ;repairing fleet in FLEET MANGER
	sleep (500)
	Global $arrRepairFleet[0]
	if VEGA_IfManageBtn('click',$FleetNumber) <> -1 Then; is button manage clicked ?
		if VEGA_RepairIsFree() Then
			ConsoleWrite("Fleet repaired, closing fleet manager");
			VEGA_FleetManagerClose()
			return 1 ;FleetRepaired
		EndIf

		; разбираем флот для ремонта
		for $i=0 to 5 step 1	;for each ship in fleet
			sleep (200)
			Vega_RemoveShip($i)
			; заполняем массив нашими ранеными
			_ArrayAdd($arrRepairFleet, $i)
			Sleep (200)
			if (VEGA_RepairIsFree()) Then ExitLoop
		Next

		; собираем флот обратно
		If IsArray($arrRepairFleet) Then
			local $arrayLenght = UBound($arrRepairFleet)
			_ArrayReverse($arrRepairFleet)
;~ 			ConsoleWrite("NEW $arrayLenght ="& $arrayLenght&@CRLF )
			For $k=0 To $arrayLenght-1
;~ 				ConsoleWrite($arrRepairFleet[$k] & @LF)
				Vega_AddShip($arrRepairFleet[$k])
				sleep(300)
				VEGA_RepairIsFree()
				sleep(250)
			Next
		EndIf

		MouseClick('left',$RepairFleetBtn[0],$RepairFleetBtn[1],1,1)
		sleep (200)
		VEGA_FleetManagerClose()
	EndIf
   ;ConsoleWrite ('return from repairing -1'&@CRLF)
	return -1 ;manage button not clicked
EndFunc

Func VEGA_FleetManagerClose()
   sleep (200)
   MouseClick("left", $FleetManagerClosebtn_coords[0],$FleetManagerClosebtn_coords[1],1,1)
   sleep(300)
EndFunc

func VEGA_IfManageBtn($action='' , $fleet=0)
   ;MouseMove($btn_Fleet[$fleet][0]+($btn_Fleet[$fleet][2]-$btn_Fleet[$fleet][0])/2, $btn_Fleet[$fleet][1]+($btn_Fleet[$fleet][3]-$btn_Fleet[$fleet][1])/2,1)
   sleep(300)
   send($fleet+1)
   ;mouseclick('left',$btn_Fleet[$fleet][0]+($btn_Fleet[$fleet][2]-$btn_Fleet[$fleet][0])/2, $btn_Fleet[$fleet][1]+($btn_Fleet[$fleet][3]-$btn_Fleet[$fleet][1])/2,50)
   ;send ("q")
   sleep(300)

   local $x
   local $y
   ;MouseMove($btn_coords[0][0], $btn_coords[0][1], 10)
   ;MouseMove($btn_coords[0][2], $btn_coords[0][3], 10)
   ;MouseMove($btn_coords[0][0]+($btn_coords[0][2]-$btn_coords[0][0])/2, $btn_coords[0][1]+($btn_coords[0][3]-$btn_coords[0][1])/2,1)
   ;ConsoleWrite('looking for:'&$btn_Fleet_manage_img&' in '&$btn_coords[0][0]&' '& $btn_coords[0][1]&' '&$btn_coords[0][2]&' '&$btn_coords[0][3])
   sleep(300)
   Local $search = _ImageSearchArea($btn_Fleet_manage_img, 0, $btn_coords[0][0], $btn_coords[0][1], $btn_coords[0][2], $btn_coords[0][3], $x, $y, 90 )
if $search = 1 Then
      ;Beep();
	  ConsoleWrite("fleet ready for manage, button:"&$x&":"&$y&@CRLF)
      ;MouseMove($x, $y, 100)
	  local $retarr[2]
	  $retarr[0]=$x
	  $retarr[1]=$y
	  if $action == 'click' Then
		 ;MouseMove ( $btn_coords[0][0]+($btn_coords[0][2]-$btn_coords[0][0])/2, $btn_coords[0][1]+($btn_coords[0][3]-$btn_coords[0][1])/2,20)
		 ;MouseClick ('left', $btn_coords[0][0]+($btn_coords[0][2]-$btn_coords[0][0])/2, $btn_coords[0][1]+($btn_coords[0][3]-$btn_coords[0][1])/2,1,1)

		 send("q")
		 sleep (500)
	  EndIf
	  return $retarr

   Else
	  ConsoleWrite("fleet not ready for manage"&@CRLF)

   EndIf
   return -1
EndFunc


Func VEGA_FindTarget($Fleet, $VEGA_Target_numb=-1)
	sleep($Debug_sleep/2)

	if $VEGA_Target_numb<>-1 Then
		$target=$VEGA_Target_numb
		local $btn_Tags_max=$VEGA_Target_numb
		ConsoleWrite('using exact target'&@CRLF)
	EndIf

	send($Fleet+1)

;~ 	For $vGoToFight In $fleet_ready_arr
	For $target=1 To $targets_Array[0]
		local $currentTarget = $targets_Array[$target]
		ConsoleWrite('Attacking target: '&$currentTarget&' with fleet '&$Fleet+1&@CRLF)
		sleep($Debug_sleep)
		local $try=0
		; click on target main button
		;ConsoleWrite('TAGs main x:y is 1e1e1e1e1e1e1e1e'&$btn_Tags_main[0]&':'&$btn_Tags_main[1]&@CRLF)
		; кликаем на кнопку BOOKMARKS
		MouseClick('left',$btn_Tags_main[0],$btn_Tags_main[1],1,1)
;~ 		MouseMove($btn_Tags_main[0],$btn_Tags_main[1])
		sleep (250)
		; click on target page 2
;~ 		MouseMove($btn_Tags_page[1][0],$btn_Tags_page[1][1])
		MouseClick('left',$btn_Tags_page[1][0],$btn_Tags_page[1][1],1,1)
		sleep (250)
		; click on target 1 in list
		ConsoleWrite('$target= '&$currentTarget&'   '&$btn_Tags_list[$currentTarget][0]&":"&$btn_Tags_list[$currentTarget][1]&@CRLF)
;~ 		MouseMove($btn_Tags_list[$target][0],$btn_Tags_list[$target][1])
		sleep (250)
		MouseClick('left',$btn_Tags_list[$currentTarget][0],$btn_Tags_list[$currentTarget][1],1,1)
		; Use exact fleet

		;sleep(2000)
		sleep (500)
		local $search= _ImageSearchArea($btn_Attack_active_img, 0, $btn_coords[0][0], $btn_coords[0][1], $btn_coords[0][2], $btn_coords[0][3], $x, $y, 70 )

		if $search = 1 Then
			;ConsoleWrite ('attack is active'&@CRLF)
			; center
			$centre_x=$VEGA_win_pos[0]+$VEGA_win_pos[2]/2
			$centre_y=$VEGA_win_pos[1]+$VEGA_win_pos[3]/2

			$distanceAtack = 40
			for $k=-1 to 1 step 2
				for $l=-1 to 1 step 2
					$try=$try+1
					;MouseMove($centre_x+50*$l,$centre_y+50*$k,1)
					;sleep(300)
					MouseMove( $centre_x+$distanceAtack*$l,$centre_y+$distanceAtack*$k,5)
					sleep (400)
					MouseClick('left',$centre_x+$distanceAtack*$l,$centre_y+$distanceAtack*$k,1,5)
					sleep(100)
					MouseClick('left',$centre_x+$distanceAtack*$l,$centre_y+$distanceAtack*$k,1,1)
					sleep(300)
					local $search = _ImageSearchArea($btn_Fleet_warp_img, 0, $btn_coords[1][0], $btn_coords[1][1], $btn_coords[1][2], $btn_coords[1][3], $x, $y, 70 )
					if $search=1 Then
						ConsoleWrite (_NowTime(5)&' warping fleet #'&$Fleet+1&'...'&@CRLF)
						Send("w")
						;MouseClick('left',$btn_coords[1][0]+($btn_coords[1][2]-$btn_coords[1][0])/2, $btn_coords[1][1]+($btn_coords[1][3]-$btn_coords[1][1])/2,1)
						sleep (100)
						ExitLoop 2
					else
						ConsoleWrite (_NowTime(5)&' warp not active'&@CRLF)
						sleep (500)
					EndIf
					;sleep (200)
				Next
			Next
			if $try=4 Then
				ConsoleWrite(_NowTime(5)&' terminate warp'&@CRLF)
				return -1
			EndIf
			sleep (100)
			;select fleet
			send($Fleet+1)
			;MouseClick('left',$btn_Fleet[$Fleet][0]+($btn_Fleet[$Fleet][2]-$btn_Fleet[$Fleet][0])/2,$btn_Fleet[$Fleet][1]+($btn_Fleet[$Fleet][3]-$btn_Fleet[$Fleet][1])/2,1,1)

			sleep (300)
			;attack
			MouseClick('left',$btn_Tags_main[0],$btn_Tags_main[1],1,1)
			sleep (300)
			MouseClick('left',$btn_Tags_page[1][0],$btn_Tags_page[1][1],1,1)
			sleep (300)
			MouseClick('left',$btn_Tags_list[$currentTarget][0],$btn_Tags_list[$currentTarget][1],1,1)

			ConsoleWrite(_NowTime(5)&' wait for warping'&@CRLF)
			Sleep (4250)

			local $search= _ImageSearchArea($btn_Attack_active_img, 0, $btn_coords[0][0], $btn_coords[0][1], $btn_coords[0][2], $btn_coords[0][3], $x, $y, 70 )
			if $search = 1 Then
				ConsoleWrite(_NowTime(5)&' press attack'&@CRLF)
				local $search= _ImageSearchArea($btn_Attack_active_img, 0, $btn_coords[0][0], $btn_coords[0][1], $btn_coords[0][2], $btn_coords[0][3], $x, $y, 70 )
				if $search=1 Then
					;MouseMove($btn_coords[0][0]+($btn_coords[0][2]-$btn_coords[0][0])/2, $btn_coords[0][1]+($btn_coords[0][3]-$btn_coords[0][1])/2,1)
					;sleep(200)
					;MouseClick('left',$btn_coords[0][0]+($btn_coords[0][2]-$btn_coords[0][0])/2, $btn_coords[0][1]+($btn_coords[0][3]-$btn_coords[0][1])/2,1,1)
					send("q")
					;;;;;;;;;;
					;	wait fleet will be in attack action
					; start TimerDiff
					local $timer=TimerInit()
					While TimerDiff($timer)<$wait_attack_max_time
						local $i=$Fleet
						Local $search = _ImageSearchArea( $btn_Fleet_img[7], 0, $btn_Fleet[$i][0], $btn_Fleet[$i][1], $btn_Fleet[$i][2], $btn_Fleet[$i][3], $x, $y, 90 )
						if $search = 1 Then
							ConsoleWrite(_NowTime(5)&' Fleet '&$Fleet&' in action in '&TimerDiff($timer)&' milliseconds, continue'&@CRLF)
							return 1	;Fleet in attack action
						EndIf
					wend
					ConsoleWrite('Fleet '&$Fleet&' not in action in '&TimerDiff($timer)&' milliseconds, return fleet'&@CRLF)
					VEGA_ReturnFleet($Fleet)
					;end TimerDiff exceeded
					; return fleet
					;;;;;;;;;;;;;;

					;sleep (2500)
					return 1
					;sleep (1000)
				EndIf
			else
				ConsoleWrite(_NowTime(5)&' press Return ?'&@CRLF)
				sleep(400)
				VEGA_ReturnFleet($Fleet)
			EndIf

		EndIf
	;target not found
	MouseClick('left',$btn_notarget[0],$btn_notarget[1],1,5)
	sleep(200)
	Next

	ConsoleWrite(_NowTime(5)&' not found any target'&@CRLF)
	return -1
EndFunc

func VEGA_attack_target($fleet, $target=-1)

   VEGA_FindTarget($fleet,$target)
EndFunc

Func VEGA_ReturnFleet($Fleet=0)
   sleep(100)
   ConsoleWrite(' return fleet sub for fleet '&$Fleet+1&@CRLF)
   Local $search = _ImageSearchArea($btn_Fleet_manage_img, 0, $btn_coords[2][0], $btn_coords[2][1], $btn_coords[2][2], $btn_coords[2][3], $x, $y, 90 )
   if $search = 1 Then
	  ConsoleWrite(' return btn found for fleet '&$Fleet+1&@CRLF)
	  Send("e")
   Else
	  ConsoleWrite(' return btn not found for fleet '&$Fleet+1&@CRLF)
	  Send($Fleet+1)
	  sleep(50)
	  Send("e")
   EndIf
   sleep(100)
EndFunc

Func Quit()
;~    MsgBox(0,"","Exit key. Bot ends with "& $i &" itterations",5)
   ConsoleWrite("Exit using key F6"&@CRLF)
   Exit
EndFunc
