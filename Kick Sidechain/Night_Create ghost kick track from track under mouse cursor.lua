-- Script by Night

-- Creates a ghost kick track based off track under mouse cursor


function main()
	reaper.Main_OnCommand(41110, 0)
	trackUnderCursorNumber = reaper.GetSelectedTrack(0, 0)
	originalTrackID = reaper.GetMediaTrackInfo_Value(trackUnderCursorNumber, "IP_TRACKNUMBER")
	reaper.Main_OnCommand(40062, 0)

	duplicateTrack = reaper.GetTrack(0, originalTrackID)
	reaper.GetSetMediaTrackInfo_String(duplicateTrack, "P_NAME", "Ghost Kick Sample", true)
	reaper.InsertTrackAtIndex(reaper.GetMediaTrackInfo_Value(duplicateTrack, "IP_TRACKNUMBER")-1, true)
	parentedTrack = reaper.GetTrack(0,reaper.GetMediaTrackInfo_Value(duplicateTrack, "IP_TRACKNUMBER")-2)
	reaper.GetSetMediaTrackInfo_String(parentedTrack, "P_NAME", "Ghost Kick", true)
	reaper.SetMediaTrackInfo_Value(parentedTrack,"I_FOLDERDEPTH",1)
	reaper.SetMediaTrackInfo_Value(duplicateTrack,"I_FOLDERDEPTH",-1)

	for i = 0, reaper.CountTrackMediaItems(duplicateTrack)-1 do
		item = reaper.GetTrackMediaItem(duplicateTrack,i)

		reaper.SetMediaItemInfo_Value(item,"D_LENGTH",0.1*reaper.GetMediaItemInfo_Value(item,"D_LENGTH"))
	end



	-- Set parent track to not send to master
	reaper.SetMediaTrackInfo_Value(parentedTrack,"B_MAINSEND",0)
end

reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)
main()
reaper.PreventUIRefresh(-1)
reaper.Undo_EndBlock("Create ghost kick track from track under mouse cursor", -1)
