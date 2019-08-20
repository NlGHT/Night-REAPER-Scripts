script_title = "Add Bar Empty Space At Start"
  
reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)

numberBars = 1 -- Rest of this is imported from the "Add multiple bars of empty space at start" so the amount of bars is always 1 this time

arrangeStart, arrangeEnd = reaper.GetSet_ArrangeView2(0, false, 0, 0)

timeSelStart, timeSelEnd = reaper.GetSet_LoopTimeRange2(0, false, false, 0, 0, false)

curPos = reaper.GetCursorPositionEx(0)

reaper.Main_OnCommand(40042, 0)
reaper.Main_OnCommand(40625, 0)

reaper.ApplyNudge(0, 0, 6, 16, numberBars, 0, 0)

reaper.Main_OnCommand(40626, 0)
reaper.Main_OnCommand(40200, 0)

retval, measures, _, _, cdenom = reaper.TimeMap2_timeToBeats(0, timeSelStart)
newStartPosition = reaper.TimeMap2_beatsToTime(0, retval + numberBars * cdenom, measures)

retval, measures, _, _, cdenom = reaper.TimeMap2_timeToBeats(0, timeSelEnd)
newEndPosition = reaper.TimeMap2_beatsToTime(0, retval + numberBars * cdenom, measures)

if timeSelEnd == 0 then
	reaper.Main_OnCommand(40635, 0) -- Remove time selection
else

	reaper.GetSet_LoopTimeRange2(0, true, false, math.floor(newStartPosition+0.5), math.floor(newEndPosition+0.5), false)
end

reaper.Main_OnCommand(40042, 0)

retval, measures, _, _, cdenom = reaper.TimeMap2_timeToBeats(0, curPos)
newCursorPos = reaper.TimeMap2_beatsToTime(0, retval + numberBars * cdenom, measures)
reaper.MoveEditCursor(newCursorPos, false)

reaper.GetSet_ArrangeView2(0, true, math.floor(arrangeStart+0.5), math.floor(arrangeEnd+0.5)) -- Not sure why this doesn't work

reaper.UpdateArrange()
reaper.PreventUIRefresh(-1)
reaper.Undo_EndBlock(script_title, 0)

--[[

BY NIGHT
Hope this helped someone out there! :) <3

--]]
