#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Window
;#SingleInstance Ignore




;Gui

GUI:

Gui, Add, Text, x20 y10, Modes To Import:
Gui, Add, CheckBox, viranked checked x40 yp+30, Ranked
Gui, Add, CheckBox, vicasual xp+105, Casual
Gui, Add, CheckBox, viarena x40, Arena
Gui, Add, CheckBox, vibrawl xp+105, Brawl
Gui, Add, CheckBox, vifriendly x40, Friendly
Gui, Add, CheckBox, vipractice xp+105, Practice

Gui, Add, Text, x20 yp+30, Note:
Gui, Add, Edit, vnote w200, Entered by HDT Import

Gui, Add, Button, yp+40 x20 w200, Import
Gui, Add, Button, yp+30 x20 w200, Exit
Gui, Show, w240, HDT Import

Return

ButtonExit:
exitapp

ButtonImport:
Gui, Submit

currentgame := {class: "", oclass: "", opponent: "", result: "", mode: "", rank: "", turns: "", duration: ""}
lastclass := ""

;GamesHistory and recording games already in HDT

gameshistory := ""

Loop, Read, %A_AppData%\HearthstoneDeckTracker\DeckStats.xml
{
	;A_LoopReadLine
	
	If InStr(A_LoopReadLine, "<PlayerHero>")
	{
		ReplacedStr := StrReplace(A_LoopReadLine, "<PlayerHero>")
		ReplacedStr := StrReplace(ReplacedStr, "</PlayerHero>")
		currentgame["class"] := Trim(ReplacedStr, " `t")
	}
	Else If InStr(A_LoopReadLine, "<OpponentHero>")
	{
		ReplacedStr := StrReplace(A_LoopReadLine, "<OpponentHero>")
		ReplacedStr := StrReplace(ReplacedStr, "</OpponentHero>")
		currentgame["oclass"] := Trim(ReplacedStr, " `t")
	}
	Else If InStr(A_LoopReadLine, "<GameMode>")
	{
		ReplacedStr := StrReplace(A_LoopReadLine, "<GameMode>")
		ReplacedStr := StrReplace(ReplacedStr, "</GameMode>")
		If !InStr(ReplacedStr, "Ranked")
			currentgame["rank"] := ""
		currentgame["mode"] := Trim(ReplacedStr, " `t")
	}
	Else If InStr(A_LoopReadLine, "<Result>")
	{
		ReplacedStr := StrReplace(A_LoopReadLine, "<Result>")
		ReplacedStr := StrReplace(ReplacedStr, "</Result>")
		If InStr(ReplacedStr, "Win")
			currentgame["result"] := "Won"
		Else If InStr(ReplacedStr, "Loss")
			currentgame["result"] := "Lost"
		Else
			currentgame["result"] := Trim(ReplacedStr, " `t")
	}
	Else If InStr(A_LoopReadLine, "<Turns>")
	{
		ReplacedStr := StrReplace(A_LoopReadLine, "<Turns>")
		ReplacedStr := StrReplace(ReplacedStr, "</Turns>")
		currentgame["turns"] := Trim(ReplacedStr, " `t")
	}
	Else If InStr(A_LoopReadLine, "<OpponentName>")
	{
		ReplacedStr := StrReplace(A_LoopReadLine, "<OpponentName>")
		ReplacedStr := StrReplace(ReplacedStr, "</OpponentName>")
		ReplacedStrArray := StrSplit(ReplacedStr, "#")
		currentgame["opponent"] := Trim(ReplacedStrArray.1, " `t")
	}
	Else If InStr(A_LoopReadLine, "<Rank>")
	{
		ReplacedStr := StrReplace(A_LoopReadLine, "<Rank>")
		ReplacedStr := StrReplace(ReplacedStr, "</Rank>")
		currentgame["rank"] := Trim(ReplacedStr, " `t")
	}
	Else If InStr(A_LoopReadLine, "<StartTime>")
	{
		starttime := Trim(A_LoopReadLine, " `t")
		startdate := SubStr(starttime, 12, 10)
		startdatearray := StrSplit(startdate, "-")
		starttime := SubStr(starttime, 23, 8)
		starttimearray := StrSplit(starttime, ":")
		starttime := startdatearray[1].=startdatearray[2].=startdatearray[3].=starttimearray[1].=starttimearray[2].=starttimearray[3]
	}
	Else If InStr(A_LoopReadLine, "<EndTime>")
	{
		endtime := Trim(A_LoopReadLine, " `t")
		enddate := SubStr(endtime, 10, 10)
		enddatearray := StrSplit(enddate, "-")
		endtime := SubStr(endtime, 21, 8)
		endtimearray := StrSplit(endtime, ":")
		endtime := enddatearray[1].=enddatearray[2].=enddatearray[3].=endtimearray[1].=endtimearray[2].=endtimearray[3]
		
		endtime -= starttime, m
		currentgame["duration"] := endtime
	}
	Else If InStr(A_LoopReadLine, "</Game>")
	{
		cg := ""
		For k, v in currentgame
		{
			If k != duration
				cg .= v "|"
		}
		If InStr(gameshistory, cg)
			Continue
		Else
			gameshistory .= cg "`n"
	}
	Else If InStr(A_LoopReadLine, "</DeckStatsList>")
		Break
}


myreplayscheck:

	IfWinNotExist, My Replays - HSReplay.net - Google Chrome
	{
		MsgBox, 1, ,Please open My Replays on HSReplay.net`nand display in list view.
			IfMsgBox OK
			{	
				Goto, myreplayscheck
			}
			else IfMsgBox Cancel
			{
				return
			}
	}

WinRestore, My Replays - HSReplay.net - Google Chrome
WinMove, My Replays - HSReplay.net - Google Chrome, , 0, 0, 1936, 1096

winreplayscheck:

IfWinNotExist, Hearthstone Deck Tracker
{
	MsgBox, 1, , Please open Hearthstone Deck Tracker
		IfMsgBox OK
		{
			Sleep, 5000
			Goto, winreplayscheck
		}
		else IfMsgBox Cancel
		{
			return
		}
}

WinActivate, Hearthstone Deck Tracker
WinWaitActive, Hearthstone Deck Tracker
WinRestore, Hearthstone Deck Tracker
WinMove, Hearthstone Deck Tracker, , , , 1469, 814
ImageSearch, hdtx, hdty, 34, 43, 176, 208, *TransWhite *n2 hdtd.bmp
	If ErrorLevel >=1
		ImageSearch, hdtx, hdty, 34, 43, 176, 208, *TransWhite *n2 hdtd2.bmp
			If ErrorLevel >=1
			{
				MsgBox, ImageSearch Error`nHDT Import will exit
				exitapp
			}
				
hdtally := hdty-44
mouseclick, left, 67, %hdtally%

IfWinNotExist, Stats
{
	WinActivate, Hearthstone Deck Tracker
	WinWaitActive, Hearthstone Deck Tracker
	Click, 320, 46
	Sleep, 250
	;Click, 346, 104
	Send {Down 2}{Enter}
	Sleep, 500
	IfWinNotExist, Stats
		Click, 76, 75
		Sleep, 250
	WinRestore, Stats
	WinActivate, Stats
	WinWaitActive, Stats
	Click 66, 232
	Sleep, 250
}

WinRestore, Stats
WinMove, Stats, , , , 829, 672
	
getgames:

WinActivate, My Replays - HSReplay.net - Google Chrome
WinWaitActive, My Replays - HSReplay.net - Google Chrome

clipboard := ""
send ^a
sleep, 250
send ^c
clipwait, 1

parseready := ""

Loop, Parse, clipboard, `n
{
	If A_LoopField contains  HSReplay HSReplay.net
		Break
	
	If parseready = 1
		Goto ParseGames
	
	If A_LoopField contains MATCH						OPPONENT	RESULT	MODE	DURATION	TURNS	PLAYED
		parseready := 1
	continue
	
	ParseGames:
	
	++gameline
	
	If gameline = 1
	{
		Loop, parse, A_LoopField, %A_Tab%
		{
			If A_Index = 2
				currentgame["Class"] := A_LoopField
			Else If A_Index = 5
				currentgame["oclass"] := A_LoopField
			Else If A_Index = 7
				currentgame["opponent"] := A_LoopField
			Else If A_Index = 8
				currentgame["result"] := A_LoopField
		}
		Continue
	}
	Else If gameline = 2
	{
		Loop, parse, A_LoopField, %A_Space%
		{	
			If A_Index = 1
				currentgame["mode"] := Trim(A_LoopField,"`r")
			If currentgame["mode"] = "Adventure"
				currentgame["mode"] := "Practice"
			Else If currentgame["mode"] = "Tavern"
				currentgame["mode"] := "Brawl"
		}
		Continue
	}
	Else If gameline = 3
	{
		Loop, parse, A_LoopField, %A_Space%
		{
			If A_Index = 1
				Continue
			If A_Index = 2
				currentgame["rank"] := Trim(A_LoopField,"`r")
		}
		If currentgame["mode"] != "Ranked"
			currentgame["rank"] := ""
		Continue
	}
	Else If gameline = 4
	{
		Loop, parse, A_LoopField, %A_Tab%
		{
			If A_Index = 1
				currentgame["duration"] := Trim(A_LoopField, " minutesseconds")
			Else If A_Index = 2
				currentgame["turns"] := A_LoopField
				
			gameline := ""
		}
	}
	
	cg := ""
	For k, v in currentgame
	{
		If k != duration
			cg .= v "|"
	}
	If InStr(gameshistory, cg)
		Continue
		
;	viranked
;	vicasual
;	viarena
;	vibrawl
;	vifriendly
;	vipractice
	
	
	If currentgame["mode"] = "Ranked" and iranked = 0
		Continue
	Else If currentgame["mode"] = "Casual" and icasual = 0
		Continue
	Else If currentgame["mode"] = "Arena" and iarena = 0
		Continue
	Else If currentgame["mode"] = "Brawl" and ibrawl = 0
		Continue
	Else If currentgame["mode"] = "Friendly" and ifriendly = 0
		Continue
	Else If currentgame["mode"] = "Practice" and ipractice = 0
		Continue
	
	gameshistory .= cg "`n"
	
	;enter games	
	
	;use function
	hdtyuse := hdty+66
	use()
	{
	global
	mouseclick, left, 815, %hdtyuse%
	}
	
	sleep, 250
	
	If currentgame["class"] != lastclass
	{
		lastclass := currentgame["class"]

		WinActivate, Hearthstone Deck Tracker
		WinWaitActive, Hearthstone Deck Tracker
		
		If InStr(currentgame["class"], "Druid")
		{	
			mouseclick, left, 131, %hdty%
			use()
		}
		else If InStr(currentgame["class"], "Hunter")
		{
			mouseclick, left, 213, %hdty%
			use()
		}
		else If InStr(currentgame["class"], "Mage")
		{
			mouseclick, left, 297, %hdty%
			use()
		}
		else If InStr(currentgame["class"], "Paladin")
		{
			mouseclick, left, 378, %hdty%
			use()
		}
		else If InStr(currentgame["class"], "Priest")
		{
			mouseclick, left, 463, %hdty%
			use()
		}
		else If InStr(currentgame["class"], "Rogue")
		{
			mouseclick, left, 543, %hdty%
			use()
		}
		else If InStr(currentgame["class"], "Shaman")
		{
			mouseclick, left, 628, %hdty%
			use()
		}
		else If InStr(currentgame["class"], "Warlock")
		{
			mouseclick, left, 713, %hdty%
			use()
		}
		else If InStr(currentgame["class"], "Warrior")
		{
			mouseclick, left, 793, %hdty%
			use()
		}
		sleep, 250
	}
	
	WinActivate, Stats
	WinWaitActive, Stats
	
	;Click "ADD NEW GAME TO ACTIVE DECK"
	click, 292, 643
	
	sleep, 500
	
	If !InStr(currentgame["result"], "Won")
	{
		sleep, 250
		
		;Result
		Click, 449, 148
		
		sleep, 250
		
		If InStr(currentgame["result"], "Lost")
			Send {l}{Enter}
		Else If InStr(currentgame["result"], "Draw")
			Send {d}{Enter}
			
		sleep, 250
	}
	
	If !InStr(currentgame["oclass"], "Druid")
	{
		Sleep, 250
		
		;VS
		Click, 441, 177
		
		sleep, 250
		
		If InStr(currentgame["oclass"], "Hunter")
			Send {h}
		else If InStr(currentgame["oclass"], "Mage")
			Send {m}
		else If InStr(currentgame["oclass"], "Paladin")
			Send {p}
		else If InStr(currentgame["oclass"], "Priest")
			Send {p 2}
		else If InStr(currentgame["oclass"], "Rogue")
			Send {r}
		else If InStr(currentgame["oclass"], "Shaman")
			Send {s}
		else If InStr(currentgame["oclass"], "Warlock")
			Send {w}
		else If InStr(currentgame["oclass"], "Warrior")
			Send {w 2}
		
		Send {enter}
		sleep, 250
	}
	
	If !InStr(currentgame["mode"], "Ranked")
	{
		mm := 2
		
		sleep, 250
		
		;Mode
		Click, 434, 203
		sleep, 250
		
		If InStr(currentgame["mode"], "Casual")
		{
			Send {c}{Enter}
			mm := 3
		}
		else If InStr(currentgame["mode"], "Arena")
			Send {a}{Enter}
		else If InStr(currentgame["mode"], "Brawl")
			Send {b}{Enter}
		else If InStr(currentgame["mode"], "Friendly")
			Send {f}{Enter}
		else If InStr(currentgame["mode"], "Practice")
			Send {p}{Enter}
			
		sleep, 250
	}
	else
	{
		r := currentgame["rank"]
		mm := 1
		
		sleep, 250
		
		;Mode
		Click, 434, 203
		sleep, 250
		send {r}{enter}
		
		;Rank
		Click, 381, 287, 2
		send, %r%
		sleep, 250
	}
	
	t := currentgame["turns"]
	op := currentgame["opponent"]
	d := currentgame["duration"]

	If mm = 1 ;Ranked
	{
		;Turns
		click, 388, 399, 2
		send, %t%
		sleep, 250
		
		;Duration
		click, 388, 427, 2
		send, %d%
		sleep, 250
		
		;Opponent
		click, 398, 483
		send, %op%
		sleep, 250
		
		;Note
		click, 400, 454
		send, %note%
		sleep, 250
		
		;add game
		click, 345, 568
		sleep, 250
	}
	else If mm = 2 ;Arena, Brawl, Friendly, Practice
	{
		;Turns
		click, 388, 315, 2
		send, %t%
		sleep, 250
		
		;Duration
		click, 388, 342, 2
		send, %d%
		sleep, 250
		
		;Opponent
		click, 402, 399
		send, %op%
		sleep, 250
		
		;Note
		click, 389, 370
		send, %note%
		sleep, 250
		
		;add game
		click, 344, 484
		sleep, 250
	}
	else If mm = 3 ;Casual
	{
		;Turns
		click, 388, 343, 2
		send, %t%
		sleep, 250
		
		;Duration
		click, 388, 371, 2
		send, %d%
		sleep, 250
		
		;Opponent
		click, 391, 428
		send, %op%
		sleep, 250
		
		;Note
		click, 398, 399
		send, %note%
		sleep, 250
		
		;add game
		click, 345, 514
		sleep, 250
	}
}

msgbox, Done.
gui, show

Esc::
	exitapp














