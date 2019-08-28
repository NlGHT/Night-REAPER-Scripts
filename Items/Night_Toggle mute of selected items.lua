selected_items_count = reaper.CountSelectedMediaItems(0)
--[[
if selected_items_count == 0 then
  reaper.ShowMessageBox("You need to select an item!", "Error", 0)
  do return end
end
--]]
reaper.Undo_BeginBlock()
-- INITIALIZE loop through selected items
for i = 0, selected_items_count-1  do
  -- GET ITEMS
  item = reaper.GetSelectedMediaItem(0, i) -- Get selected item i
  
  if reaper.GetMediaItemInfo_Value(item, "B_MUTE") == 0 then
    reaper.SetMediaItemInfo_Value(item, "B_MUTE", 1)
  else
    reaper.SetMediaItemInfo_Value(item, "B_MUTE", 0)
  end
  
end

reaper.Undo_EndBlock("Toggle mute of selected items", -1)

reaper.UpdateArrange()
