HDT Import v1.6

HDT Import is a simple AHK script which parses the info from https://hsreplay.net/games/mine/, then enters it into Hearthstone Deck Tracker.

The main reason for me writing this was to create a quick way to enter matches saved to HSReplay from the mobile app "Arcane Tracker" into HDT, so that I could see all my matches and deck statistics together, as HDT and Arcane Tracker do not sync with each other. (not yet anyway)

------------------------------------------------------------------

Requirements:

AHK: AutoHotkey,  https://www.autohotkey.com/
Google Chrome (I wrote this for use with google chrome, if enough people ask for compatibility with another browser, I may add it in the future.)

------------------------------------------------------------------

Instructions:

1.  Navigate to https://hsreplay.net/games/mine/ in a Chrome browser and display in list view.  (Click "List View" in the left side bar.

2.  Open Hearthstone Deck Tracker.

3.  In HDT:  Goto options > settings and uncheck "show news bar"

4.  Run "HDT Import.exe"

------------------------------------------------------------------

Menu:

Modes To Import -
HDT Import will only import checked game modes.

Note:
This note will be entered into the "note" field when importing matches.

Import:
Starts importing.  HDT Import will check against any matches already in Hearthstone Deck Tracker and will not create duplicate entries.

------------------------------------------------------------------

Data imported by HDT Import:

- Player Class (but not the deck's name, see "notes" section below.)
- Opponent's Class
- Opponent Name
- Result (Win/Lose/Draw)
- Mode (Ranked, casual, brawl, etc.)
- Rank
- Duration
- Number of Turns

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
HSReplay does not record your deck's name, and therefore it cannot be retrieved and entered by HDT Import.  The top deck listed in Hearthstone Deck Tracker for a given class will be chosen as the active deck when importing.  I have found it helpful to create a deck in Hearthstone Deck Tracker named "00" or similar for each class so it is the first in the list, making it easy to spot newly entered matches.  These matches can then be selected (using shift/ctrl + Lclick to select multiple) and moved to the proper deck in Hearthstone Deck Tracker.  Note that Hearthstone Deck Tracker will need to be restarted before the new deck name shows in the "Matches" window.

-Coin card/Conceded/Format-
Although Hearthstone Deck Tracker has fields to enter this data when manually importing, HSReplays does not keep track of this info.  It would require actually watching the replay to obtain.  Which, while admittedly possible with AHK, is beyond the scope of this project, and would slow the import process down by a significant amount.

-Dates/times played-
Although HSReplay does keep track of when games were played - Hearthstone Deck Tracker has no field to enter this info into when manually entering a match.  Hearthstone Deck Tracker automatically fills in the "Started" field with the date & time the match was manually entered.