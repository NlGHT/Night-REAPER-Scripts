script_title = "Add Bar Empty Space At Start"
  
reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)

count_sel_items = reaper.CountSelectedMediaItems(0)

reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_SAVETIME1"), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup("_BR_SAVE_CURSOR_POS_SLOT_1"), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_SAVESELITEMS1"), 0)

reaper.Main_OnCommand(40042, 0)
reaper.Main_OnCommand(40625, 0)

reaper.ApplyNudge(0, 0, 6, 16, 1, 0, 0)

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
