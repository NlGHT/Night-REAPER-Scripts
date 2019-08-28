reaper.Undo_BeginBlock()
if reaper.GetSelectedEnvelope(0) then
	reaper.Main_OnCommand(42196,0); -- Envelope: Toggle automation item loop
else
	reaper.Main_OnCommand(40636,0); -- Item properties: Loop item source
end
reaper.Undo_EndBlock("Toggle Looping",0);
