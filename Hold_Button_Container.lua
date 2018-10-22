-- Template and Script developed by Night --

--[[

How it works:
1.  Create a sectioncode which should be completely unique.
	If not then it's probably not too much trouble unless another script uses the same Section Code AND a key with name "time".
	Otherwise just change every ExtState modification to what you want.
2.  Set a callstack rate, this is the delay(ms) after a key press until the script ends.
	By default this is set to 500 which appears to be the time taken for fast key input to sink in after initial press.
3.  Change the init_press() function for what to happen on the initial script run.
4.  Change what to run in the background with background_tasks().
5.  Change what to run after the key is released inside end_tasks().

The script's initial start time is stored within script_time, string format in str_script_time.

]]--

sectioncode = "23456";
callstack_rate = 500;





function init_press()
	reaper.ShowConsoleMsg("Start\n");
end

function background_tasks()
	reaper.ShowConsoleMsg("Background\n");
end

function end_tasks()
	reaper.ShowConsoleMsg("End\n");
end







function checkCallstack(ms)
	ms = ms / 1000;
	if reaper.time_precise() - script_time < ms then
		savedTime = reaper.GetExtState(sectioncode, "time")
		floatSavedTimeAfter = tonumber(savedTime)
		--reaper.ShowConsoleMsg(savedTime .. "\n")
		--reaper.ShowConsoleMsg(script_time .. "\n")
		if tostring(script_time) == tostring(floatSavedTimeAfter) then
			reaper.defer(checkCallstack(callstack_rate))
		else
			background_tasks()
		end
	else
		savedTime = reaper.GetExtState(sectioncode, "time")
		floatSavedTimeAfter = tonumber(savedTime)
		--reaper.ShowConsoleMsg(savedTime)
		--reaper.ShowConsoleMsg(script_time)
		if tostring(script_time) == tostring(floatSavedTimeAfter) then
			reaper.DeleteExtState(sectioncode, "time", 1)
			end_tasks()
		else
			background_tasks()
		end
	end
end


script_time = reaper.time_precise()

str_script_time = tostring(script_time)

if reaper.HasExtState(sectioncode, "time") then
	reaper.SetExtState(sectioncode, "time", str_script_time, 0)
	reaper.defer(checkCallstack(callstack_rate))
else
	reaper.SetExtState(sectioncode, "time", str_script_time, 0)
	init_press()
	reaper.defer(checkCallstack(callstack_rate))
end