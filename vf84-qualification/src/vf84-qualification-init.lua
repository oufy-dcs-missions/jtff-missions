-- *****************************************************************************
-- *                         Global Objects creation                           *
-- *****************************************************************************
--
-- Beacons
--

--
-- Scheduler Object
--
Scheduler = SCHEDULER:New( nil )
--
-- Spawns Tankers
--
spawnTexaco = SPAWN:New("texaco")
spawnShell = SPAWN:New("shell")
spawnEscortTexaco = SPAWN:New("escort-texaco")
spawnEscortShell = SPAWN:New("escort-shell")
--
-- Civilian aircrafts
--

--
-- Spawns Mission triggers
--

spawnoverlord = SPAWN:New("overlord")
spawnEscortOverlord = SPAWN:New("escort-overlord")
--
-- Sound Objects
--
snd1020HzTone = USERSOUND:New( "1020Hz_DF_tone.wav" )
--
-- Spawns BVR
--
spawnbomber = SPAWN:New("bomber")
spawnBVR33 = SPAWN:New("BVRnaval")
spawnBVR27 = SPAWN:New("BVR27")
spawnBVR29 = SPAWN:New("BVR29")
--
-- Spawns WVR
--
spawnbandit = SPAWN:New("bandit")
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
--                     **                     Tankers                         **
--                     *********************************************************
--
-- Texaco --
--
local ObjEspacementTankers = POINT_VEC3:New( 1000, 0, 1000 )
groupTexaco = spawnTexaco:InitSkill("Excellent"):Spawn()
groupEscortTexaco = spawnEscortTexaco:InitSkill("Excellent"):Spawn():OptionAlarmStateRed():OptionROEReturnFire()
taskEscortTexaco = groupEscortTexaco:TaskFollow(groupTexaco,ObjEspacementTankers:GetVec3(), 4)
groupEscortTexaco:SetTask( taskEscortTexaco, 1 )
groupTexaco:GetUnit(1):GetBeacon():AATACAN(15, "TXC", true)
--
-- Shell --
--
groupShell = spawnShell:InitSkill("Excellent"):Spawn()
groupEscortShell = spawnEscortShell:InitSkill("Excellent"):Spawn():OptionAlarmStateRed():OptionROEReturnFire()
taskEscortShell = groupEscortShell:TaskFollow(groupShell,ObjEspacementTankers:GetVec3(), 4)
groupEscortShell:SetTask( taskEscortShell, 1 )
groupShell:GetUnit(1):GetBeacon():AATACAN(14, "SHL", true)
-- *****************************************************************************
--                     **                 bomber Raid                         **
--                     *********************************************************
groupbomber = spawnbomber:InitSkill("Excellent"):InitUnControlled():Spawn()
ScheduleIDGroupbomber = Scheduler:Schedule(nil, startUncontrolledAirGroup, { groupbomber }, 600, 20 )
-- *****************************************************************************
--                     **                 AG training                         **
--                     *********************************************************
fctSuspendSAM({"SeadTraining", true})
fctSuspendSAM({"groupe_blinde", true})

-- *****************************************************************************
-- *                               Mission Menus                               *
-- *****************************************************************************
-- Menus Blue Game Master
local MenuCoalitionBlue = MENU_COALITION:New( coalition.side.BLUE, "Game Master Blue" )
-- Menus missions
-- Menus Red Game Master

-- Menus tankers
menuResetTexaco = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "reset Texaco", MenuCoalitionBlue , fctResetTankerAndEscort, {spawnTexaco, spawnEscortTexaco, "texaco", 15, "TXC"})
menuResetShell = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "reset Shell", MenuCoalitionBlue , fctResetTankerAndEscort, {spawnShell, spawnEscortShell, "shell", 14, "SHL"})
menuResetOverlord = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "reset Overlord", MenuCoalitionBlue , fctResetAWACS, {spawnoverlord, spawnEscortOverlord, "overlord"})
-- Menus BVR
local MenuBVRBlue = MENU_COALITION:New( coalition.side.BLUE, "BVR Blue" )
menuRaidBomber = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "Reset Bombardier Russe", MenuBVRBlue, fctResetBomber, {"bomber"} )
menuSu33_BVR = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "Su 33", MenuBVRBlue, ActivateBVR, {spawnBVR33, "Su-33"} )
menuSu27_BVR = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "Su 27", MenuBVRBlue, ActivateBVR, {spawnBVR27, "Su-27"} )
menuMig29_BVR = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "Mig 29S", MenuBVRBlue, ActivateBVR, {spawnBVR29, "Mig-29S"} )
menuKillAllBVRPlanes = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "sweep de la zone BVR", MenuBVRBlue, fctKillSpawnObjectArray, {{spawnBVR33, spawnBVR27, spawnBVR29}, "Zone BVR dégagée !!"})
-- Menus WVR
local MenuWVRBlue = MENU_COALITION:New( coalition.side.BLUE, "BFM Blue" )
menuSu27_WVR = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "Su 27", MenuWVRBlue, ActivateWVR, {spawnbandit, "Su-27"} )
menuKillAllWVRPlanes = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "sweep de la zone BFM", MenuWVRBlue, fctKillSpawnObjectArray, {{spawnbandit}, "Zone BFM dégagée !!"})
-- Menu A/G
local MenuAGBlue = MENU_COALITION:New( coalition.side.BLUE, "A/G Blue" )
menuSA3On = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "SA3 Actif", MenuAGBlue, fctActivateSAM, {"SeadTraining", false, 45} )
menuSA3Off = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "SA3 Inactif", MenuAGBlue, fctSuspendSAM, {"SeadTraining", false, 45} )
menuAGOn = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "Groupe blindé défendu", MenuAGBlue, fctActivateSAM, {"groupe_blinde", false, 45} )
menuAGOff = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "Groupe blindé non-défendu", MenuAGBlue, fctSuspendSAM, {"groupe_blinde", false, 45} )

