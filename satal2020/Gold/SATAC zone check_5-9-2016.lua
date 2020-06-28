--[[

SATAC bubble rule script (by Bushmanni)

updated 5.9.2016
* changed bubble control logic
	- 	5 min rule now only applies to the start of the round
		if you remove all bandits from inside the bubble you get straight win
	- 	bubble rule check is disabled after bubble control has been achieved
		(no more warning when crossing the border during RTB)

updated 3.9.2016
* fixed bubble timer not resetting after one side has bubble control and both sides have vacated the bubble
* fixed error in log message time codes


*************************************************
This script uses MIST and was tested on v. 4.3.73
*************************************************

This script applies bubble rules to all planes in the mission.

You need to load Mist script file before loading this script file.
You also need to include sound files in the mission.
You can do that by creating a ME trigger that plays the sounds but that never actually triggers.
You need to edit the zone and sound file names (lines 35-38) in this script to match the ones used in the mission.
(Or change the zone names and sound file names alternatively)

Script logic description:
When plane enters the inner zone, a message is sent to the group to inform them entering the zone.
When plane exits the inner zone the group will get warning about exiting battle area.
When plane exits the outer zone, it is counted as being out of the battle area and message is sent to the group.
When plane re-enters the outer zone a warning is given about re-entering the battle area.
When plane re-enters the inner zone it's blown up.
When plane (inside the zone) speed reaches below 5 m/s and altitude above ground less than 7 m it will be exploded.
When plane crashes the slot is reset so that it can enter the battle area again.

If only one side has planes inside the bubble a timer is started (each side has it's own timer).
If the planes exit the bubble or planes from the other side enter the zone the timer is reset.
If the timer reaches 300 seconds, message is sent to declare winner.
If battle area control is awarded to one side and the opposing team doen't have any planes outside the bubble
	that can still enter the bubble, winner is declared.

When winner is awarded (time limit reached or bandits shot down or driven out), bubble rule enforcement stops.
Bubble rule enforcement can't be started by any other means but reloading the mission.

All above events are logged in c:\users\<username>\Saved Games\DCS\Logs\DCS.log
Relevant lines include text "SATAC" so they can be found with text find tool.
The line ends with timecode (time since start of the mission).

]]

-- you can edit these variables
local warningSound = "ribbit.ogg";  -- filename for warning message sound
local infoSound = "whu.ogg";   -- filename for info message sound
local innerZone = "innerzone";  -- ME name for inner bubble trigger zone
local outerZone = "outerzone";  -- ME name for outer bubble trigger zone


-- non-editable variables
local planes = mist.makeUnitTable ({"[all][plane]"});
local PlanesInZone = {};
local PlanesOutOfZone = {};
local redwin = false;
local bluewin = false;
local pilotNames = {};
local battleSituation = 0;

-- function to turning number of seconds into hh:mm:ss
function timeTostr(seconds)
	local secs = string.format('%02.0f', math.fmod(seconds, 60));
	local minutes = string.format('%02.0f', math.fmod(seconds/60, 60));
	local hours = string.format('%.0f', math.modf(seconds/3600));
	
	return (hours .. ":" .. minutes .. ":" .. secs) ;	
end;

-- function for calculating lenght of velocity vector
function getSpeed(velVector)	
	local speed = (velVector.x^2 + velVector.y^2 + velVector.z^2)^0.5;
	return speed;
end;


-- function to check if plane has landed (speed < 5m/s and altitude above ground < 7m)
function hasLanded(unitName)
	local rval = false;
	if unitName and Unit.getByName(unitName) then
		local planeUnit = Unit.getByName(unitName);
		local location3d = planeUnit:getPoint();
		local location2d = mist.utils.makeVec2(location3d);
		local agl = location3d.y - land.getHeight(location2d);
		local speed = getSpeed(planeUnit:getVelocity());
		if (speed < 5) and (agl < 7) then
			rval = true;
		end;			
	end;
	return rval;
end;

function mainLoop()
	mist.scheduleFunction(mainLoop, {}, timer.getTime() + 1);
	
	if (not redwin) and (not bluewin) then
		
		-- checking for planes in zone
		for index, plane in ipairs(planes) do
			if plane then
				
				local planeGroupID = mist.DBs.unitsByName[plane].groupId;
				if Unit.getByName(plane) and planeGroupID then
					local unitTable = mist.getUnitsInZones ( {plane}, {innerZone}, "cylinder");
					if #unitTable > 0 then
						table.insert(PlanesInZone, plane);
						table.remove(planes, index);
						env.info( "SATAC -- " .. Unit.getByName(plane):getPlayerName() .. " entered combat area. Time:" .. timeTostr(timer.getTime()) );
						pilotNames[plane] = Unit.getByName(plane):getPlayerName();
						trigger.action.outTextForGroup(planeGroupID, "You or a member of your group are inside combat area.", 30);
						trigger.action.outSoundForGroup(planeGroupID, infoSound);
					end;
				end;
			end;
		end;
		
		-- checking for landed planes inside the area and blowing them up
		for index, plane in ipairs(PlanesInZone) do
			if plane and Unit.getByName(plane) then
				if hasLanded(plane) then
					local planeGroupID = mist.DBs.unitsByName[plane].groupId;
					env.info( "SATAC -- " .. Unit.getByName(plane):getPlayerName() .. " was blown up after landing inside combat area. Time:" .. timeTostr(timer.getTime()) );
					trigger.action.explosion(Unit.getByName(plane):getPoint(), 500);
					table.remove(PlanesInZone, index);
				end;			
			end;
		end;	
		
		-- checking for planes about to go outside of zone
		for index, plane in ipairs(PlanesInZone) do
			if plane then
				local unitTable = mist.getUnitsInZones ( {plane}, {innerZone}, "cylinder");
				if #unitTable == 0 then
					--trigger.action.outText("plane left the zone", 60);
					local planeGroupID = mist.DBs.unitsByName[plane].groupId;
					trigger.action.outTextForGroup(planeGroupID, "You or a member of your group are about to leave combat area.", 1);
					trigger.action.outSoundForGroup(planeGroupID, infoSound);
				end;
			end;
		end;
		
		-- checking for planes outside of zone
		for index, plane in ipairs(PlanesInZone) do
			if plane then
				local unitTable = mist.getUnitsInZones ( {plane}, {outerZone}, "cylinder");
				if #unitTable == 0 then
					table.insert(PlanesOutOfZone, plane);
					table.remove(PlanesInZone, index);
					local planeGroupID = mist.DBs.unitsByName[plane].groupId
					env.info( "SATAC -- " .. pilotNames[plane] .. " exited combat area. Time:" .. timeTostr(timer.getTime()) );
					trigger.action.outTextForGroup(planeGroupID, "You or a member of your group are outside combat area and cannot return.", 60);
					trigger.action.outSoundForGroup(planeGroupID, infoSound);
				end;
			end;
		end;
		
		-- checking for returning planes in warning zone
		for index, plane in ipairs(PlanesOutOfZone) do
			if plane then
				local unitTable = mist.getUnitsInZones ( {plane}, {outerZone}, "cylinder");
				if #unitTable > 0 then
					local planeGroupID = mist.DBs.unitsByName[plane].groupId;
					trigger.action.outTextForGroup(planeGroupID, "\nWarning! Warning! You or a member of your group can't return to combat area. Turn around!", 1);
					trigger.action.outSoundForGroup(planeGroupID, warningSound);
				end;
			end;
		end;	

		-- checking for planes in detonation zone
		for index, plane in ipairs(PlanesOutOfZone) do
			if plane then
				local unitTable = mist.getUnitsInZones ( {plane}, {innerZone}, "cylinder");
				if #unitTable > 0 then
					env.info( "SATAC -- " .. Unit.getByName(plane):getPlayerName() .. " was blown up trying to re-enter combat area. Time:" .. timeTostr(timer.getTime()) );
					trigger.action.explosion(Unit.getByName(plane):getPoint(), 500);
				end;
			end;
		end;		

		-- checking for dead planes and resetting the slot
		for index, plane in ipairs(PlanesOutOfZone) do
			if plane then
				if not Unit.getByName(plane) then
					table.insert(planes, plane);
					table.remove(PlanesOutOfZone, index);
				end;
			end;
		end;
		
		-- checking for combat area control
		local redsInside = 0;
		local bluesInside = 0;
		local redsOutside = 0;
		local bluesOutside = 0;
		
		
		-- counting red and blue planes in zone
		for index, plane in ipairs(PlanesInZone) do
			if plane then
				local planeCoal = Unit.getByName(plane):getCoalition();
				if planeCoal == 1 then
					redsInside = redsInside + 1;
				elseif planeCoal == 2 then
					bluesInside = bluesInside + 1;
				end;
			end;
		end;
		
		-- counting red and blue planes out of zone that can still enter zone
		for index, plane in ipairs(planes) do
			if plane then
				if Unit.getByName(plane) then
					local planeCoal = Unit.getByName(plane):getCoalition();
					if planeCoal == 1 then
						redsOutside = redsOutside + 1;
					elseif planeCoal == 2 then
						bluesOutside = bluesOutside + 1;
					end;
				end;
			end;
		end;

		-- logic for determining who has control of battle area
		if (redsInside > 0) and (bluesInside == 0) and (not redWinTimer) then
			redWinTimer = timer.getTime();
			blueWinTimer = false;
			trigger.action.outText("Red has taken control of the battle area.", 30);
			trigger.action.outSound(infoSound);
			env.info("SATAC -- Red takes control of battle area. Time:" .. timeTostr(timer.getTime()) );
			if (battleSituation == 1) and (bluesOutside == 0) then  -- all blues are shot down or RTB
				trigger.action.outText("All Blues are out of the fight. Red has control of the battle area.\nRTB.", 60);
				env.info("SATAC -- All Blues are out of the fight. Red has control of the battle area. Time:" .. timeTostr(timer.getTime()) );
				redwin = true;
			end;
		elseif (redsInside == 0) and (bluesInside > 0) and (not blueWinTimer) then
			blueWinTimer = timer.getTime();
			redWinTimer = false;
			trigger.action.outText("Blue has taken control of battle area.", 30);
			trigger.action.outSound(infoSound);
			env.info("SATAC -- Blue takes control of the battle area. Time:" .. timeTostr(timer.getTime()) );
			if (battleSituation == 1) and (redsOutside == 0) then  -- all reds are shot down or RTB
				trigger.action.outText("All Reds are out of the fight. Blue has control of the battle area.\nRTB.", 60);
				env.info("SATAC -- All Reds are out of the fight. Blue has control of the battle area. Time:" .. timeTostr(timer.getTime()) );
				bluewin = true;
			end;
		elseif ( (redsInside == 0) and (bluesInside == 0) ) and (redWinTimer or blueWinTimer) then
			redWinTimer = false;
			blueWinTimer = false;
			trigger.action.outText("Battle area is empty. Battle area control is neutralized.", 30);
			trigger.action.outSound(infoSound);
			env.info("SATAC -- Battle area is empty. Battle area control is neutralized. Time:" .. timeTostr(timer.getTime()) );
			battleSituation = 0;
		elseif ((redsInside > 0) and (bluesInside > 0)) and (redWinTimer or blueWinTimer) then
			redWinTimer = false;
			blueWinTimer = false;
			trigger.action.outText("Battle area is contested. Battle area control is neutralized.", 30);
			trigger.action.outSound(infoSound);
			env.info("SATAC -- Battle area is contested. Battle area control is neutralized. Time:" .. timeTostr(timer.getTime()) );
			battleSituation = 1;
		end;

		-- checking timer for victory condition
		if redWinTimer and (timer.getTime() - redWinTimer) > 300 and ((not bluewin) and (not redwin) ) then
			trigger.action.outText("Red has controlled battle area for 5 mins.\nRTB", 60);
			redwin = true;
			env.info("SATAC -- Red has controlled the battle area for 5 mins. Time:" .. timeTostr(timer.getTime()) );
		end;
		
		if blueWinTimer and (timer.getTime() - blueWinTimer) > 300 and ((not bluewin) and (not redwin) ) then
			trigger.action.outText("Blue has controlled battle area for 5 mins.\nRTB", 60);
			bluewin = true;
			env.info("SATAC -- Blue has controlled the battle area for 5 mins. Time:" .. timeTostr(timer.getTime()) );
		end;

	end;
	
end

env.info("SATAC -- Mission started. Time:" .. timeTostr(timer.getTime()) );
mainLoop();
