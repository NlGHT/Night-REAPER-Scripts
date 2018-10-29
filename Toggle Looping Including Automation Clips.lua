reaper.Undo_BeginBlock()
if reaper.GetSelectedEnvelope(0) then
	reaper.Main_OnCommand(42196,0);
else
	reaper.Main_OnCommand(40636,0);
end
reaper.Undo_EndBlock("Toggle Looping",0);