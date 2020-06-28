--[[

DEACTIVATE AWACS script (by Bear)

This script adds seperate commands to each coalition in the mission to deactivate active awacs.

You need to select the option 3 times to deactivate it.
A message is shown only to the coalition that deactivates the awacs.

All above events are logged in c:\users\<username>\Saved Games\DCS\Logs\DCS.log
Relevant lines include text "SATAL" so they can be found with text find tool.

]]

--editable variables
local redA50 = 'Red A-50'
local redE3A = 'Red E-3A'
local blueA50 = 'Blue A-50'
local blueE3A = 'Blue E-3A'

env.info( "SATAL -- deactivateawacs_v1.lua loaded");

function deactivateAwacs(coalit,awacs)
	if Group.getByName(awacs) then
		trigger.action.deactivateGroup(Group.getByName(awacs));
		trigger.action.outTextForCoalition(coalit, awacs.." Deactivated.", 10);
		env.info( "SATAL -- ".. awacs.." deactivated.")
	end;
end;
		
local rlevel1 = {};
rlevel1[1] = missionCommands.addSubMenuForCoalition(coalition.side.RED,"DEACTIVATE AWACS", nil)	
local rlevel2 = {};
rlevel2[1] = missionCommands.addSubMenuForCoalition(coalition.side.RED,redA50, rlevel1[1], nil)
rlevel2[2] = missionCommands.addSubMenuForCoalition(coalition.side.RED,redE3A, rlevel1[1], nil)
local rlevel3 = {};
rlevel3[1] = missionCommands.addCommandForCoalition(coalition.side.RED,redA50.." (3 times to deactivate)",rlevel2[1], function() 
	missionCommands.removeItemForCoalition(coalition.side.RED,rlevel3[1]);
	env.info( "SATAL -- "..redA50.." first time.");
	rlevel3[2] = missionCommands.addCommandForCoalition(coalition.side.RED,redA50.." (2 more times to deactivate)", rlevel2[1], function()
		missionCommands.removeItemForCoalition(coalition.side.RED,rlevel3[2]);
		env.info( "SATAL -- "..redA50.." second time.");
		rlevel3[3] = missionCommands.addCommandForCoalition(coalition.side.RED,redA50.." (1 last time to deactivate)",rlevel2[1], function() 
			missionCommands.removeItemForCoalition(coalition.side.RED,rlevel3[3]);
			missionCommands.removeItemForCoalition(coalition.side.RED,rlevel2[1]);
			deactivateAwacs(coalition.side.RED,redA50);
			end, nil)	
		end, nil)
	end, nil)
rlevel3[4] = missionCommands.addCommandForCoalition(coalition.side.RED,redE3A.." (3 times to deactivate)",rlevel2[2], function() 
	missionCommands.removeItemForCoalition(coalition.side.RED,rlevel3[4]);
	env.info( "SATAL -- "..redE3A.." first time.");
	rlevel3[5] = missionCommands.addCommandForCoalition(coalition.side.RED,redE3A.." (2 more times to deactivate)", rlevel2[2], function()
		missionCommands.removeItemForCoalition(coalition.side.RED,rlevel3[5]);
		env.info( "SATAL -- "..redE3A.." second time.");
		rlevel3[6] = missionCommands.addCommandForCoalition(coalition.side.RED,redE3A.." (1 last time to deactivate)",rlevel2[2], function() 
			missionCommands.removeItemForCoalition(coalition.side.RED,rlevel3[6]);
			missionCommands.removeItemForCoalition(coalition.side.RED,rlevel2[2]);
			deactivateAwacs(coalition.side.RED,redE3A);			
			end, nil)	
		end, nil)
	end, nil)
	
local blevel1 = {};
blevel1[1] = missionCommands.addSubMenuForCoalition(coalition.side.BLUE,"DEACTIVATE AWACS", nil)	
local blevel2 = {};
blevel2[1] = missionCommands.addSubMenuForCoalition(coalition.side.BLUE,blueA50, blevel1[1], nil)
blevel2[2] = missionCommands.addSubMenuForCoalition(coalition.side.BLUE,blueE3A, blevel1[1], nil)
local blevel3 = {};
blevel3[1] = missionCommands.addCommandForCoalition(coalition.side.BLUE,blueA50.." (3 times to deactivate)",blevel2[1], function() 
	missionCommands.removeItemForCoalition(coalition.side.BLUE,blevel3[1]);
	env.info( "SATAL -- "..blueA50.." first time.");
	blevel3[2] = missionCommands.addCommandForCoalition(coalition.side.BLUE,blueA50.." (2 more times to deactivate)", blevel2[1], function()
		missionCommands.removeItemForCoalition(coalition.side.BLUE,blevel3[2]);
		env.info( "SATAL -- "..blueA50.." second time.");
		blevel3[3] = missionCommands.addCommandForCoalition(coalition.side.BLUE,blueA50.." (1 last time to deactivate)",blevel2[1], function() 
			missionCommands.removeItemForCoalition(coalition.side.BLUE,blevel3[3]);
			missionCommands.removeItemForCoalition(coalition.side.BLUE,blevel2[1]);
			deactivateAwacs(coalition.side.BLUE,blueA50);
			end, nil)	
		end, nil)
	end, nil)
blevel3[4] = missionCommands.addCommandForCoalition(coalition.side.BLUE,blueE3A.." (3 times to deactivate)",blevel2[2], function() 
	missionCommands.removeItemForCoalition(coalition.side.BLUE,blevel3[4]);
	env.info( "SATAL -- "..blueE3A.." first time.");
	blevel3[5] = missionCommands.addCommandForCoalition(coalition.side.BLUE,blueE3A.." (2 more times to deactivate)", blevel2[2], function()
		missionCommands.removeItemForCoalition(coalition.side.BLUE,blevel3[5]);
		env.info( "SATAL -- "..blueE3A.." second time.");
		blevel3[6] = missionCommands.addCommandForCoalition(coalition.side.BLUE,blueE3A.." (1 last time to deactivate)",blevel2[2], function() 
			missionCommands.removeItemForCoalition(coalition.side.BLUE,blevel3[6]);
			missionCommands.removeItemForCoalition(coalition.side.BLUE,blevel2[2]);
			deactivateAwacs(coalition.side.BLUE,blueE3A);			
			end, nil)	
		end, nil)
	end, nil)