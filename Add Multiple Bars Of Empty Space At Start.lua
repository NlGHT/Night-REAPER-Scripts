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
--reaper.ShowConsoleMsg(numberBars)


if retval == false then
  do return end
  reaper.Undo_DoUndo2(0)
end



reaper.Undo_BeginBlock()
reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_SAVETIME1"), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup("_BR_SAVE_CURSOR_POS_SLOT_1"), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_SAVESELITEMS1"), 0)

reaper.Main_OnCommand(40042, 0)
reaper.Main_OnCommand(40625, 0)

reaper.ApplyNudge(0, 0, 6, 16, numberBars, 0, 0)

reaper.Main_OnCommand(40626, 0)
reaper.Main_OnCommand(40200, 0)

reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_RESTTIME1"), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup("_BR_RESTORE_CURSOR_POS_SLOT_1"), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_RESTSELITEMS1"), 0)

reaper.UpdateArrange()
reaper.PreventUIRefresh(-1)
reaper.Undo_EndBlock(script_title, 0)

--[[

BY NIGHT
Hope this helped someone out there! :) <3

--]]

