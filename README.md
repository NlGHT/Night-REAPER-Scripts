# Night-REAPER-Scripts

A collection of scripts developed by Night for the DAW REAPER.

All of the current scripts should be up to date now and working.  Please feel free to make changes and point out issues, or contribute new ideas!  I will try to get around to everything as soon as possible.

A separate branch for WIP (Works in progress) will be for all the scripts that are not finished or even initial very early ideas.

## Highlights
### Arrange View Item Lasso Tool
Select all your items in whatever shape you want!  Just hold down the key assigned to the script and move the mouse!  (The first time you will need to select "Create a new instance" and make sure "Remember my choice" is checked)

### Select Chord Notes Above, Below and Under Mouse Cursor
This will select all the notes that cover the x coordinate of the mouse.  It can be used to select chords very easily.  Additionally there are scripts for adding to and subtracting from selection.  This way you can bind a key to each!  E.g 'c' for selecting the chord and 'Shift + c' for adding to selection.

### Hold Button Script Template
Part of the development for the lasso tool included making a new way of making scripts in REAPER.  Using the template provided, it is easy to design scripts that allow for holding buttons down as their interaction.  This is necessary for scripts such as the Lasso Tool, but can be applied to anything!  There are three customisable functions at the top:
- What to do on initial button press
- What to be run every frame the key is held down
- What to do on release
After this, just assign your own custom section code and go crazy!

### Efficient String Functions
Provided in "ScriptingTools/Night_EEL Extended String Functions.eel":
- **`getCharByPosition(posInString, inputString)`**
  - Get character at position index in string
- **`substringByLength(posInString, smolStringlength, inputString)`**
  - Get substring of string defined by a point in the string and the specified length
  - substring() has to calculate the length first so this function is ever so slightly quicker
- **`substring(indexStart, indexEnd, inputString)`**
  - Get substring of string defined by start and end indexes

### Place Duplicate of First Item on Track
Located at *"Items/Night_Place duplicate of first item on track at mouse cursor.eel"*, this is incredibly handy when working with percussion or many samples in REAPER.  Binding this to a key means that you can press the key on a track to place another snare/kick/hat item or whatever that track is used for under the mouse cursor.  *Yes, it does place it properly on the grid!*  **No more continuous item duplicating!**

### Toggle Volume Envelope Preserving Track Volume
> Okay... so I need to automate a volume fade-out to end the song, just finished mixing and getting all these track volumes juuuuust right.  Let me press `v` ... !??#$U(#!?  What's this!?  The envelope has the volume I spent so long mixing to and the track is at 0dB!!

Has this every happened to you?  Don't worry about this happening to you anymore with *"Tracks/Night_Toggle track volume envelope without changing mixer level.lua"*.  This will keep the volume level of that track you spent so long on right where it should be.  The volume envelope gets to be put to 0dB where it should be too.  Don't worry about toggling messing anything up, just toggle all you want as you normally would!

### Procedurally Generated Ghost Kick Track
Never worry about sidechaining or kicks every again with the *Kick Sidechain* directory.

Lay out your kicks how you want them, run *"Kick Sidechain/Night_Create ghost kick track from track under mouse cursor.lua"* to create a track below with all the ghost kicks.  Perfectly suited for the one button sidechaining with SWS/ReaPack!

Oh and you want to re-arrange your kicks?  Never fear, just run *"Kick Sidechain/Night_Update ghost kick track with kick info on track under mouse.eel"* with the mouse over your kick track and watch the ghost kick track follow suit!
