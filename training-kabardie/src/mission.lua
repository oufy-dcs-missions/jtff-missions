-- *****************************************************************************
-- *                         Global Objects creation                           *
-- *****************************************************************************
snd1020HzTone = USERSOUND:New( "1020Hz_DF_tone.wav" )

--
-- Spawns Tankers
--



-- *****************************************************************************
-- *                           Mission functions                               *
-- *****************************************************************************
--
-- Generic Spawn object functions
--
function ActivateGroup(param)
  local objSpawn = param[1]
  local strSkillLevel = param[2]
  local strFlightName = param[3]
  local intMessageTempo = param[4] or 45
  local strMessage = param[5] or "Groupe %s activé !"
  local blnSilent = param[6] or false
  objSpawn:InitSkill(strSkillLevel):Spawn()
  if not(blnSilent) then
    snd1020HzTone:ToCoalition( coalition.side.BLUE )
    MESSAGE:New(string.format(strMessage, strFlightName),intMessageTempo,"WARNING",false):ToBlue()
  end
end

function fctKillSpawnObjectArray(param)
  local arrGroups = param[1]
  local strMessage = param[2]
  local intMessageTempo = param[3] or 45
  local blnSilent = param[4] or false
  for index, objSpawn in pairs(arrGroups) do
    fctKillSpawnObject({objSpawn})
  end
  if not(blnSilent) then
    MESSAGE:New(string.format(strMessage),intMessageTempo,"WARNING",false):ToBlue()
  end
end
function fctKillSpawnObject(param)
  local objSpawn = param[1]
  local GroupPlane, Index = objSpawn:GetFirstAliveGroup()
  while GroupPlane ~= nil do
    -- Do actions with the GroupPlane object.
    GroupPlane:Destroy(true)
    GroupPlane, Index = objSpawn:GetNextAliveGroup( Index )
  end
end
--
-- Generic Group functions
--
function startUncontrolledAirGroup(AirGroup)
  BASE:E("Start")
  AirGroup:SetCommand({
    id = 'Start', 
    params = {}
  })
end
function StopMove( GroundGroup )
  BASE:E("Stop")
  local Command = GroundGroup:CommandStopRoute( true )
  GroundGroup:SetCommand(Command)
end
function StartMove( GroundGroup )
  BASE:E("Start")
  local Command = GroundGroup:CommandStopRoute( false )
  GroundGroup:SetCommand(Command)
end
--
-- Tankers functions
--
function fctResetTankerAndEscort(param)
  local GroupTanker, Index = param[1]:GetFirstAliveGroup()
  while GroupTanker ~= nil do
    -- Do actions with the GroupTanker object.
    GroupTanker:Destroy(true)
    GroupTanker, Index = (param[1]):GetNextAliveGroup( Index )
  end
  local groupEscort, Index = param[2]:GetFirstAliveGroup()
  while groupEscort ~= nil do
    -- Do actions with the groupEscort object.
    groupEscort:Destroy(true)
    groupEscort, Index = (param[2]):GetNextAliveGroup( Index )
  end
  local groupTanker = param[1]:InitSkill("Excellent"):Spawn()
  local groupEscort = param[2]:InitSkill("Excellent"):Spawn()
  groupEscort:OptionAlarmStateRed()
  groupEscort:OptionROEReturnFire()
  local PointVec3 = POINT_VEC3:New( 1000, 0, 1000 )
  local escortTask = groupEscort:TaskFollow(groupTanker,PointVec3:GetVec3(), 4)
  groupEscort:SetTask( escortTask, 1 )
  groupTanker:GetUnit(1):GetBeacon():AATACAN(param[4], param[5], true)
  MESSAGE:New(string.format("tanker %s recréé et re-intialisé", (GROUP:FindByName(param[3]):GetUnits()[1]):GetCallsign())):ToBlue()
  -- : " .. (GROUP:FindByName("tanker"):GetUnits()[1]):GetCallsign()):ToBlue()
end
--
-- Tu_Raid trigger function
--
function Activatebomber(param)
  local arrGroups = param[1]
  for index, groupB1 in ipairs(arrGroups)
  do
    startUncontrolledAirGroup(groupB1)
  end
end
function fctResetBomber(param)
    GROUP:FindByName(param[1]):Destroy(true)
  local GroupBomber = SPAWN:New(param[1]):InitSkill("Excellent"):Spawn()
  MESSAGE:New(string.format("Bombardier Russe %s recréé et re-intialisé", (GroupBomber:GetUnits()[1]):GetCallsign())):ToBlue()
end
--
-- BVR functions
--
function ActivateBVR(param)
  local objSpawn = param[1]
  local strFlightName = param[2]
  local strSkillLevel = "Excellent"
  local intMessageTempo = 45
  local strMessage = "Un %s activé dans la zone de training BVR."
  ActivateGroup({objSpawn, strSkillLevel, strFlightName, intMessageTempo, strMessage, true})
end
--
-- WVR functions
--
function ActivateWVR(param)
  local objSpawn = param[1]
  local strFlightName = param[2]
  local strSkillLevel = "Excellent"
  local intMessageTempo = 45
  local strMessage = "Un %s activé dans la zone de training BFM."
  ActivateGroup({objSpawn, strSkillLevel, strFlightName, intMessageTempo, strMessage, true})
end
--
-- AWACS functions
--
function fctResetAWACS(param)
  local GroupAWACS, Index = param[1]:GetFirstAliveGroup()
  while GroupAWACS ~= nil do
    -- Do actions with the GroupAWACS object.
    GroupAWACS:Destroy(true)
    GroupAWACS, Index = (param[1]):GetNextAliveGroup( Index )
  end
  local groupEscort, Index = param[2]:GetFirstAliveGroup()
  while groupEscort ~= nil do
    -- Do actions with the groupEscort object.
    groupEscort:Destroy(true)
    groupEscort, Index = (param[2]):GetNextAliveGroup( Index )
  end
  local GroupAWACS = param[1]:InitSkill("Excellent"):Spawn()
  local groupEscort = param[2]:InitSkill("Excellent"):Spawn()
  groupEscort:OptionAlarmStateRed()
  groupEscort:OptionROEReturnFire()
  local PointVec3 = POINT_VEC3:New( 1000, 0, 1000 )
  local escortTask = groupEscort:TaskFollow(GroupAWACS,PointVec3:GetVec3(), 4)
  groupEscort:SetTask( escortTask, 1 )
  MESSAGE:New(string.format("AWACS %s recréé et re-intialisé", (GROUP:FindByName(param[3]):GetUnits()[1]):GetCallsign())):ToBlue()
  -- : " .. (GROUP:FindByName("tanker"):GetUnits()[1]):GetCallsign()):ToBlue()
end
--
-- A/G functions
--
function fctActivateSAM(param)
  local SAMName = param[1]
  local blnSilent = param[2] or false
  local intMessageTempo = param[3] or 45
  local grpSAM = GROUP:FindByName(SAMName)
  if grpSAM then
    grpSAM:SetAIOn()
    if not(blnSilent) then
      snd1020HzTone:ToCoalition( coalition.side.BLUE )
      MESSAGE:New(string.format("%s IA Activé !!!",SAMName),intMessageTempo,"WARNING",false):ToBlue()
    end
  end
end
function fctSuspendSAM(param)
  local SAMName = param[1]
  local blnSilent = param[2] or false
  local intMessageTempo = param[3] or 45
  local grpSAM = GROUP:FindByName(SAMName)
  if grpSAM then
    grpSAM:SetAIOff()
    if not(blnSilent) then
      snd1020HzTone:ToCoalition( coalition.side.BLUE )
      MESSAGE:New(string.format("%s IA Désactivée...",SAMName),intMessageTempo,"WARNING",false):ToBlue()
    end
  end
end

-- *****************************************************************************
-- *                               Mission init                                *
-- *****************************************************************************
spawnSu27 = SPAWN:New("BVRSU27")
spawnMig21Ouest = SPAWN:New("BVRMIG21")
spawnMig29 = SPAWN:New("Mig29-Est")
spawnHornets = SPAWN:New("strike package")
spawnMig21Est = SPAWN:New("Mig21-est")
spawnBlueAWACS = SPAWN:New("Aerial-1")
spawnBlueTankers = SPAWN:New("texaco")
spawnBlueTankerEscort = SPAWN:New("TankerEscort")


flgEscortStarted = USERFLAG:New("escort-started")
flgEscortStarted:Set(0)
flgGirafeEstStarted = USERFLAG:New("girafe-est-started")
flgGirafeEstStarted:Set(0)
flgGirafeWestStarted = USERFLAG:New("girafe-west-started")
flgGirafeWestStarted:Set(0)
flgSweepStarted = USERFLAG:New("sweep-started")
flgSweepStarted:Set(0)

ActivateGroup({ spawnBlueTankers, "Excellent", "Vikings", 45, "", true})

function fctMissionReset()
  --{ spawn200, spawn203, spawnMig29 }, "Mission ré-initialisée !!"}
  fctKillSpawnObjectArray({ { spawnSu27, spawnMig21Ouest, spawnMig29, spawnHornets, spawnMig21Est, spawnBlueAWACS }, "Mission ré-initialisée !!"})
  flgEscortStarted:Set(0)
  flgGirafeEstStarted:Set(0)
  flgSweepStarted:Set(0)
  flgGirafeWestStarted:Set(0)
end

function fctEscortStart()
  if (flgEscortStarted:Get() == 0)  then
    ActivateGroup({spawnHornets, "Excellent", "Blue Hornet Strike", 45})
    flgEscortStarted:Set(1)
  end
end

function fctSweepStart()
  if (flgEscortStarted:Get() == 0)  then
    ActivateGroup({spawnSu27, "Excellent", "Su27", 45, "", true})
    --ActivateGroup({spawnMig21Ouest, "Excellent", "Mig21", 45, "", true})
    flgSweepStarted:Set(1)
  end
end


function fctGirafeEstStart()
  if (flgGirafeEstStarted:Get() == 0)  then
    ActivateGroup({spawnMig29, "Excellent", "Mig29", 45, "", true})
    ActivateGroup({spawnMig21Est, "Excellent", "Mig21", 45, "", true})
    flgGirafeEstStarted:Set(1)
  end
end


function fctGirafeWestStart()
  if (flgGirafeEstStarted:Get() == 0)  then
    ActivateGroup({spawnMig21Ouest, "Excellent", "Mig21", 45, "", true})
    flgGirafeWestStarted:Set(1)
  end
end

-- *****************************************************************************
-- *                               Mission Menus                               *
-- *****************************************************************************
-- Menus Blue Game Master

-- Menus BVR
local menuGameMaster = MENU_COALITION:New( coalition.side.BLUE, "Game Master" )
--menupop200 = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "popup BVR Su-27", MenuBVRBlue, ActivateGroup, {spawn200, "Excellent", "Su-27", 45} )
--menupop203 = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "popup BVR Mig21", MenuBVRBlue, ActivateGroup, {spawn203, "Excellent", "Mig21", 45} )
menupopAwacs = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "popup AWACS", menuGameMaster, ActivateGroup, { spawnBlueAWACS, "Excellent", "Hawkeye", 45} )
menuKillAllBVRPlanes = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "mission re-init", menuGameMaster, fctMissionReset)


