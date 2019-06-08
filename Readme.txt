HDT Import v1.0.0

Requirements:

AHK: AutoHotkey,  https://www.autohotkey.com/
Google Chrome

------------------------------------------------------------------

Instructions:

1.  Navigate to https://hsreplay.net/games/mine/ in a Chrome browser and display in list view.  (Click "List View" in the left side bar.

2.  Open Hearthstone Deck Tracker.

3.  Run HDT Import.exe

Note:  "hdtd.bmp" & "hdtd2.bmp" MUST be in the same directory as "HDT Import.exe"

------------------------------------------------------------------

Menu:

Modes To Import -
HDT Import will only import checked game modes.

Note:
This note will be entered into the "note" field when importing games.

Import:
Starts importing.  HDT Import will remember games which it has already imported and not enter them again, unless you click "Clear History" first.

**This will import any matches not previously imported by HDT Import, but HDT import does not (as of yet) check HDT for matches already recorded by HDT itself (i.e. not entered by HDT import.) This means, these matches will have duplicates which will need to be deleted after HDT Import runs, but this will only happen once, as HDT Import will remembers the games it imports and won't import them a second time.

Clear History:
This will delete the GamesHistory.txt file, allowing HDT Import to import games previously imported to HDT.  

**This does not remove and match history form HDT, and running HDT Import again will create duplicate matched in HDT unless the previous ones were manually deleted.

------------------------------------------------------------------

Data imported by HDT Import:

- Player Class (but not the deck's name, see "notes" section below.)
- Opponent's Class
- Opponent Name
- Result (Win/Lose/Draw)
- Mode (Ranked, casual, brawl, etc.)
- Rank
- Duration
- # of Turns

Data NOT imported by HDT Import: 
(See "Notes" section below)

- Deck Names
- Format (Standard/Wild)
- Coin
- Conceded (Yes/No)
- Date Played

-------------------------------------------------------------------

Notes:

-Deck Names-
HSReplay does not record your deck's name, and therefore it cannot be retrieved and entered by HDT Import.  The top deck listed in HDT for a given class will be chosen as the active deck when importing.  I have found it helpful to create a deck in HDT named "00" or similar for each class, making it easy to spot newly entered matches.  These matches can then be selected (using shift/ctrl + Lclick to select multiple) and moved to the proper active deck in HDT.  Note that HDT will need to be restarted before the new deck name shows in the "matches" window.

-Coin card/Conceded/Format-
Although HDT has field to enter this data when manually importing, HSReplays does not keep track of this info.  It would require actually watching the replay to obtain.  Which, while admitedly possible with AHK, is beyond the scope of this project, and would slow the import process down by a significant amount.

-Dates/times played-
Although HSReplay does keep track of when games were played - HDT has no field to enter this info into when manually entering a match.  HDT automatically fills in the "Started" field with the date & time the match was manually entered.