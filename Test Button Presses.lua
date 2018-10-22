_,_,_ = reaper.BR_GetMouseCursorContext()
reaper.BR_GetMouseCursorContext_MIDI()
mouse_position = reaper.BR_GetMouseCursorContext_Position()

media_item = reaper.GetSelectedMediaItem(0,0)

item_track = reaper.GetMediaItem_Track(media_item)

media_item_take = reaper.GetMediaItemTake(media_item,0)

midi_mouse_position = reaper.MIDI_GetPPQPosFromProjTime(media_item_take, mouse_position )



number_of_notes = reaper.MIDI_CountEvts(media_item_take)






note_to_play = {}

getoriginalnoteselected = {}
                                                      
isitoverundermouse = {}
--
function stopmidi()
		local y = 0
	while y < 2 do

		reaper.SetMediaTrackInfo_Value(item_track,"I_RECARM",0)
		reaper.SetMediaTrackInfo_Value(item_track,"I_RECARM",1)
	 y = y + 1
	end
end

--determining original selected notes--
--

function getoriginalnotesel()
	for to = 0, number_of_notes - 1 do
	retval, isselected,  mutedOut, startpos,  endpos, chanOut, pitchOut, velOut = reaper.MIDI_GetNote(media_item_take,to)
	getoriginalnoteselected[to] = isselected
  

	end
end

--
p = 0
y = 0
--
function main()
		-- Determine if note is under/over the mouse cursor
			for i = 0, (number_of_notes)-1 do

			-- Determining values for note start and note end
			retval, selectedOut,  mutedOut, startpos,  endpos, chanOut, pitchOut, velOut = reaper.MIDI_GetNote(media_item_take,i)
	            
            --determine if note is over/under mouse position
            if startpos > midi_mouse_position and endpos > midi_mouse_position 
            		or
            	startpos < midi_mouse_position and endpos < midi_mouse_position 
            		then
					-- false
            		isnoteselected = false
            		y = y + 1
          	                
            	elseif startpos < midi_mouse_position and endpos > midi_mouse_position then	           
				   -- true
            		isnoteselected = true
            end
            isitoverundermouse[i] = isnoteselected					 
			end
--------------------------------------------------
-- No notes selected?
------------------------------------------------/
			if y == number_of_notes then				
				mousenotunderovernote = true 
				stopmidi()
								
			end					
			--------------------------------------------------
			-- unselect unwanted notes--Select notes and record chan/pitch/velocity
			--------------------------------------------------
				for j = 0, number_of_notes - 1 do 

						trueorfalse = isitoverundermouse[j]

					-- reaper.MIDI_SetNote(media_item_take, j,trueorfalse,NULL,NULL,NULL,NULL,NULL,NULL,NULL)

								if trueorfalse == true then

				 		retval2, selectedOut2, mutedOut2, startppqposOut2, endppqposOut2, chanOut2, note_pitch, note_velocity = reaper.MIDI_GetNote( media_item_take, j )					         
										  note_to_play[p] = 144 + chanOut2;
									      note_to_play[p+1] = note_pitch;
									      note_to_play[p+2] = note_velocity;
									     
									      p = p + 3
								end	      

				end

			for s = 0, number_of_notes - 1 do 


				if getoriginalnoteselected[s] == false then
		 
				reaper.MIDI_SetNote(media_item_take, s, getoriginalnoteselected[s],NULL,NULL,NULL,NULL,NULL,NULL,NULL)

			    end
				reaper.MIDI_Sort(media_item_take)	
			end
				
	--------------------------------------------/
	-- Get lenght of selected notes table			
	length= note_to_play + 1
	--------------------------------------------	 	
		if mousenotunderovernote ~= true then	

		local ctr = 0 
			while ctr < length  do				
				reaper.StuffMIDIMessage(0, note_to_play[ctr], note_to_play[ctr + 1], note_to_play[ctr+2])
			    ctr = ctr + 3
			end			
	end
end

----------------------------------/

--getoriginalnotesel()

--reaper.MIDI_SelectAll(media_item_take,true)
--main()




--[[
A demonstration of how to check for specific keypresses,
and/or when a key is being held down
]]--

local name, x, y, w, h = "Keypress demo", 200, 200, 250, 100

-- ASCII code for the letter D
local D = 100

-- Declare our variables beforehand so that they aren't flushed when the script loops
local char, char_D, down_time, held

local function onExit()
	--reaper.UpdateArrange()
	gfx.quit()
	reaper.SN_FocusMIDIEditor()
end

local function Main()
	exit = false

	-- See if the user pressed Escape (27) or closed the window (-1) to quit
	char = gfx.getchar()
	if char == 27 or char == -1 then
		return 0
	else
		reaper.defer(Main)
	end

	-- If we want to know a specific key's state, we need to specifically ask for that key
	char_D = gfx.getchar(D)


	-- Is the key pressed and it wasn't pressed already?
	if char_D ~= 0 and not down_time then

		-- If yes, note the time
		down_time = reaper.time_precise()

	-- Was the key down before and now it isn't?
	elseif char_D == 0 and down_time then
		exit = true
		onExit()
		-- Don't treat it as a click if it was being held
		if not held then

			-- Put your "on click" function here
			gfx.x, gfx.y = 50, 75
			gfx.drawstr("clicked!")

		end

		-- If you *do* want to send a click event when the button is let up
		-- from being held, put your function here instead.


		held = false
		down_time = nil

	end

	gfx.x, gfx.y = 50, 25
	gfx.drawstr("'D' pressed: "..(tostring(char_D == 1)))

	-- Is the key pressed?
	if down_time then

		-- How long has it been pressed?
		local len = reaper.time_precise() - down_time

		-- We don't need that many decimal places; let's round it
		-- (multiplying and dividing by 10 = 1 decimal, by 100 = 2 decimals, etc)
		len = math.floor(len * 100) / 100
		gfx.x, gfx.y = 50, 50
		gfx.drawstr(len)

		if len > 1 then
			gfx.x, gfx.y = 50, 75
			gfx.drawstr("held")

			held = true

		end

	end

	--[[
	if char_D == 0 then
		onExit()
		exit = true
	end
	]]--

	if exit ~= true then
		gfx.update()
		--reaper.UpdateArrange()
	end

end

loopcount = 0

gfx.init(name, w, h, 0, x, y)
Main()
