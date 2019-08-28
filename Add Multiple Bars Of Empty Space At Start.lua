script_title = "Add Multiple Bars Empty Space At Start"

reaper.PreventUIRefresh(1)

::DialogBox::
retval, retvals_csv = reaper.GetUserInputs("Add how many bars to start?", 1, "Bars at start: ", "1")
numberBars = retvals_csv:match("([^,]+)")
if numberBars == nil then
	reaper.ShowMessageBox("You forgot a value!", "Error", 0)
	goto DialogBox
end
numberBars = math.floor(tonumber(numberBars)+0.5)


if retval == false then
  do return end
  reaper.Undo_DoUndo2(0)
end



reaper.Undo_BeginBlock()

arrangeStart, arrangeEnd = reaper.GetSet_ArrangeView2(0, false, 0, 0) -- Get start of arrangement

timeSelStart, timeSelEnd = reaper.GetSet_LoopTimeRange2(0, false, false, 0, 0, false) -- Get time selection

curPos = reaper.GetCursorPositionEx(0) -- Get cursor position

reaper.Main_OnCommand(40042, 0) -- Go to start of project
reaper.Main_OnCommand(40625, 0) -- Time selection: Set start point

reaper.ApplyNudge(0, 0, 6, 16, numberBars, 0, 0)

reaper.Main_OnCommand(40626, 0) -- Time selection: Set end point
reaper.Main_OnCommand(40200, 0) -- Time selection: Insert empty space at time selection (moving later items)

if timeSelEnd == 0 then
	reaper.Main_OnCommand(40635, 0) -- Remove time selection if there is not one previously in place before script run
else
	retval, measures, _, _, cdenom = reaper.TimeMap2_timeToBeats(0, timeSelStart) -- Get time selection start in beats
	newStartPosition = reaper.TimeMap2_beatsToTime(0, retval + numberBars * cdenom, measures) -- Calculate new time selection start in time

	retval, measures, _, _, cdenom = reaper.TimeMap2_timeToBeats(0, timeSelEnd) -- Get time selection end in beats
	newEndPosition = reaper.TimeMap2_beatsToTime(0, retval + numberBars * cdenom, measures) -- Calculate new time selection end in time

	reaper.GetSet_LoopTimeRange2(0, true, false, math.floor(newStartPosition+0.5), math.floor(newEndPosition+0.5), false) -- Set new time selection
end

reaper.Main_OnCommand(40042, 0) -- Go to start of project in preparation to move cursor

retval, measures, _, _, cdenom = reaper.TimeMap2_timeToBeats(0, curPos) -- Get cursor position in beats
newCursorPos = reaper.TimeMap2_beatsToTime(0, retval + numberBars * cdenom, measures) -- Calculate new cursor position
reaper.MoveEditCursor(newCursorPos, false) -- Move cursor by calculated amount

reaper.GetSet_ArrangeView2(0, true, math.floor(arrangeStart+0.5), math.floor(arrangeEnd+0.5)) -- Not sure why this doesn't work

reaper.UpdateArrange()
reaper.PreventUIRefresh(-1)
reaper.Undo_EndBlock(script_title, 0)

--[[

BY NIGHT
Hope this helped someone out there! :) <3

--]]

