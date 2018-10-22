reaper.PreventUIRefresh(1)
if reaper.CountSelectedTracks( 0 ) == 1 then
  reaper.Undo_BeginBlock()
  track = reaper.GetSelectedTrack(0, 0)
  retval, vol, pan = reaper.GetTrackUIVolPan(track)
  reaper.SetMediaTrackInfo_Value(track, "D_VOL", 1)
  reaper.Main_OnCommand(40406, 0)
  reaper.SetMediaTrackInfo_Value(track, "D_VOL", vol)
end
reaper.Undo_EndBlock("Toggle volume envelope without changing mixer", 0)
reaper.PreventUIRefresh(-1)
reaper.UpdateArrange()

--[[

BY NIGHT
Hope this helped someone out there! :) <3

--]]






















--[[

OLD JUNK

if reaper.CountSelectedTracks( 0 ) == 1 then
  track = reaper.GetSelectedTrack(0, 0)
  
  -- get envelope (if envelope doesn't exist -> don't create envelope)
  local env = reaper.GetTrackEnvelopeByName(track, "<VOLENV")
  --local env = reaper.GetTrackEnvelopeByName(track, "VOLUME")
  local br_env = reaper.BR_EnvAlloc(env, false)
  local active, visible, armed, inLane, laneHeight, defaultShape, minValue, maxValue, centerValue, type, faderScaling = reaper.BR_EnvGetProperties(br_env)
  
  if active == true and visible == true then
    -- It's opened
    active = false
    visible = false
    reaper.BR_EnvSetProperties(br_env, active, visible, armed, inLane, laneHeight, defaultShape, minValue, maxValue, centerValue, type, faderScaling)
    reaper.BR_EnvFree(br_env, true)
  else
    -- It's not opened
    active = true
    visible = true
    armed = true
    reaper.BR_EnvSetProperties(br_env, active, visible, armed, inLane, laneHeight, defaultShape, minValue, maxValue, centerValue, type, faderScaling)
    reaper.BR_EnvFree(br_env, true)
  end
  
  --[[
  local valid_env_pointer = reaper.ValidatePtr2(0, env, "TrackEnvelope*")
  if not valid_env_pointer then
    -- get envelope (if envelope doesn't exist -> create envelope)
    fx_env = reaper.GetFXEnvelope(tr, fx_index, i-1, true)
    reaper.TrackList_AdjustWindows(false)
    return -- skip BR functions
  end
  if env ~= nil then
    local br_env = reaper.BR_EnvAlloc(fx_env, true)
    local active, visible, armed, in_lane, lane_height, default_shape, min_val, max_val, center_val, env_type, fader_scale = reaper.BR_EnvGetProperties(br_env)
    reaper.BR_EnvSetProperties(br_env, active, not visible, armed, in_lane, lane_height, default_shape, fader_scale)
    reaper.BR_EnvFree(br_env, true)
  end
  reaper.TrackList_AdjustWindows(false)
  
  --]]

--end
--]]
