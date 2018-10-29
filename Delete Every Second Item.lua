for i = 1, reaper.CountSelectedMediaItems(0)-1 do
	if not (i % 2 == 0) then
		item = reaper.GetSelectedMediaItem(0,i)
		tr = reaper.GetMediaItem_Track(item)
		reaper.DeleteTrackMediaItem(tr, item)
		reaper.ShowConsoleMsg(i)
	end
end

reaper.UpdateArrange()