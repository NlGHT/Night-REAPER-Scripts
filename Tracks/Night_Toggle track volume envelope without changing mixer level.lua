reaper.PreventUIRefresh(1)
if reaper.CountSelectedTracks( 0 ) == 1 then
  reaper.Undo_BeginBlock()
  track = reaper.GetSelectedTrack(0, 0)
  retval, vol, pan = reaper.GetTrackUIVolPan(track)
  reaper.SetMediaTrackInfo_Value(track, "D_VOL", 1)
  reaper.Main_OnCommand(40406, 0)
  reaper.SetMediaTrackInfo_Value(track, "D_VOL", vol)
end
reaper.Undo_EndBlock("Toggle volume envelope without changing mixer", -1)
reaper.PreventUIRefresh(-1)
reaper.UpdateArrange()

--[[

BY NIGHT
Hope this helped someone out there! :) <3

--]]
