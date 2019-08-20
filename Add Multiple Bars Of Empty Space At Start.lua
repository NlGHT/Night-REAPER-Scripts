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

