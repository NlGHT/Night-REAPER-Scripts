selected_items_count = reaper.CountSelectedMediaItems(0)
if selected_items_count == 0 then
  reaper.ShowMessageBox("You need to select an item!", "Error", 0)
  do return end
  reaper.Undo_DoUndo2(0)
end

--while true do
::DialogBox::
  retval, retvals_csv = reaper.GetUserInputs("Volume Randomiser For Items (Humaniser)", 2, "Minimum Value (dB),Maximum Value (dB)", "0,0")
  MinValue, MaxValue = retvals_csv:match("([^,]+),([^,]+)")
  MinValue = tonumber(MinValue)
  MaxValue = tonumber(MaxValue)
  --if MinValue <= MaxValue then break end
  --reaper.ShowMessageBox("The Minimum is larger than the Maximum value!".. "\n".. "Please select a lower Minimum value than the Maximum", "Error", 0)
--end


if retval == false then
  do return end
end


if MinValue == nil then
  reaper.ShowMessageBox("You forgot a value!", "Error", 0)
  goto DialogBox
end

if MaxValue == nil then
  reaper.ShowMessageBox("You forgot a value!", "Error", 0)
  goto DialogBox
end



-- Catch 'em if they write the things the wrong way around
if MinValue > MaxValue then
  tempMin = MinValue
  MinValue = MaxValue
  MaxValue = tempMin
end
reaper.Undo_BeginBlock()
-- INITIALIZE loop through selected items
for i = 0, selected_items_count-1  do
  -- GET ITEMS
  item = reaper.GetSelectedMediaItem(0, i) -- Get selected item i
  
  randchange = math.random()*(MaxValue-MinValue)+MinValue
  vol_log = math.exp(randchange * 0.115129254) 
   
  reaper.SetMediaItemInfo_Value(item, "D_VOL", vol_log)
  
end -- ENDLOOP through selected items
reaper.Undo_EndBlock("Randomise selected item volumes", -1)
reaper.UpdateArrange()
--reaper.ShowMessageBox("The minvalue is: ".. MinValue.. " and the max is: ".. MaxValue, "Error", 0)


--[[--[=====[

BY NIGHT
Hope I help someone out there! :) <3

--]=====]--]]
