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
--spawnShell = SPAWN:New("shell")
spawnEscortTexaco = SPAWN:New("escort-texaco")
--spawnEscortShell = SPAWN:New("escort-shell")
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
--groupShell = spawnShell:InitSkill("Excellent"):Spawn()
--groupEscortShell = spawnEscortShell:InitSkill("Excellent"):Spawn():OptionAlarmStateRed():OptionROEReturnFire()
--taskEscortShell = groupEscortShell:TaskFollow(groupShell,ObjEspacementTankers:GetVec3(), 4)
--groupEscortShell:SetTask( taskEscortShell, 1 )
--groupShell:GetUnit(1):GetBeacon():AATACAN(14, "SHL", true)
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
--menuResetShell = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "reset Shell", MenuCoalitionBlue , fctResetTankerAndEscort, {spawnShell, spawnEscortShell, "shell", 14, "SHL"})
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

-- *****************************************************************************
-- *                         AIRBOSS settings                                  *
-- *****************************************************************************
airboss_enable = true

airboss_enable_markzones = true

airboss_enable_smokezones = false

airboss_enable_niceguy = true

airboss_enable_tanker = true
airboss_enable_rescue_helo = true
airboss_enable_awacs = true

airbossCVN = nil
carrierTanker = nil  --Ops.RecoveryTanker#RECOVERYTANKER
RescueHelo = nil
CVNAwacs = nil

if airboss_enable == true then

  airbossCVN = AIRBOSS:New("roosevelt", "roosevelt")
  airbossCVN:SetTACAN(71, "X", "RSV")
  airbossCVN:SetICLS(11, "RSVLSO")
  airbossCVN:SetLSORadio(126.5)
  airbossCVN:SetMarshalRadio(251.75)
  airbossCVN:SetPatrolAdInfinitum(true)
  airbossCVN:SetCarrierControlledArea(50)
  airbossCVN:SetStaticWeather(true)
  airbossCVN:SetRecoveryCase(3)
  airbossCVN:SetMaxLandingPattern(5)
  airbossCVN:SetDefaultPlayerSkill(AIRBOSS.Difficulty.NORMAL) -- other options EASY / HARD
  airbossCVN:SetHandleAION()
  airbossCVN:SetMenuRecovery(30, 20, true)
  airbossCVN:SetMenuMarkZones(airboss_enable_markzones)
  airbossCVN:SetMenuSmokeZones(airboss_enable_smokezones)
  airbossCVN:SetAirbossNiceGuy(airboss_enable_niceguy)
  airbossCVN:SetRadioRelayMarshal("MarshallRelay")
  airbossCVN:SetRadioRelayLSO("LSORelay")
  airbossCVN:SetSoundfilesFolder("Airboss Soundfiles/")
  airbossCVN:SetMenuSingleCarrier()
  --airbossCVN:Load(nil, "Greenie Board.csv")
  --airbossCVN:SetAutoSave(nil, "Greenie Board.csv")

  -- create fake recovery window at the end of the mission play
  local window1 = airbossCVN:AddRecoveryWindow("15:00", "16:30", 3, 30, true, 20, false)
  local window2 = airbossCVN:AddRecoveryWindow("18:00", "20:30", 3, 30, true, 20, false)

  airbossCVN:Start()

  if airboss_enable_tanker == true then
    carrierTanker = RECOVERYTANKER:New(UNIT:FindByName("roosevelt"), "shell-1")
    carrierTanker:SetUseUncontrolledAircraft()
    function carrierTanker:OnAfterStart(From,Event,To)
      airbossCVN:SetRecoveryTanker(carrierTanker)
    end
    carrierTanker:SetTACAN(14, "SHL")
    carrierTanker:SetRadio(276.2, "AM")
    carrierTanker:SetRespawnOn()
    carrierTanker:SetAltitude(12500)
    carrierTanker:SetSpeed(270)
    carrierTanker:SetRacetrackDistances(15,25)
    carrierTanker:SetRecoveryAirboss(true)
    carrierTanker:SetModex(702)
    carrierTanker:Start()
  end

  if airboss_enable_awacs == true then
    CVNAwacs=RECOVERYTANKER:New(UNIT:FindByName("roosevelt"), "wizzard-1")
    CVNAwacs:SetUseUncontrolledAircraft()
    CVNAwacs:SetAWACS()
    CVNAwacs:SetRadio(261, "AM")
    CVNAwacs:SetAltitude(28000)
    CVNAwacs:SetSpeed(270)
    CVNAwacs:SetRespawnOn()
    CVNAwacs:SetCallsign(CALLSIGN.AWACS.Wizard)
    CVNAwacs:SetRacetrackDistances(30, 30)
    CVNAwacs:SetModex(611)
    CVNAwacs:SetTACAN(16, "WZD")
    CVNAwacs:SetRecoveryAirboss(true)
    CVNAwacs:Start()

  end

  if airboss_enable_rescue_helo == true then
    RescueHelo =RESCUEHELO:New(UNIT:FindByName("roosevelt"), "Pedro-1")
    RescueHelo:SetUseUncontrolledAircraft()
    RescueHelo:SetTakeoffCold()
    RescueHelo:Start()
  end

  env.info('Airboss ... OK')
  trigger.action.outText("AIRBOSS scripts Loaded...", 10)
  -- ADD TO CONFIG FILE
  -- airboss_enable_markzones = true
  -- airboss_enable_smokezones = true
  -- airboss_enable_niceguy = true

  timer.scheduleFunction(function()
    trigger.action.outText(	"<< If the AIRBOSS option does not appear in your F10 - Other Menu, try switching slots a few times and you will get the AIRBOSS message popups! Check the AIRBOSS documentation (link in briefing for more info) >>", 30)
  end, nil, timer.getTime() + 30  )

end

if airboss_enable == false then

  timer.scheduleFunction(function()
    trigger.action.outText("AIRBOSS script disabled...", 10)
  end, nil, timer.getTime() + 8  )

end


-- *****************************************************************************
-- *                         RAT settings                                      *
-- *****************************************************************************
--ADJUST RANDOM AI AIR TRAFFIC SPAWN SETTINGS HERE
--READ THE MISSION SETTINGS --README FILE FOR MORE DETAILS

random_civ_air_traffic = true


-- # of civ aircraft spawns PER TYPE,
civ_rat_spawns = 1

air_traffic_flight_level = 330
--example:  200 = 20000ft

max_distance_destination = 5000
--the max distance in KM
--of the ai aircaft's final destination airfield, which are chosen at random

civ_allow_immortal = false
civ_allow_invisible = true

-- enable or disable ai aircraft types that will spawn in (use true or false)
-- civilian
enable_yak = false
enable_c130 = true
enable_c5 = true
enable_an26 = true
enable_a320 = true
enable_a380 = true
enable_b737 = true

airbase_1 = "Sochi-Adler"
airbase_2 = "Tbilisi-Lochini"
airbase_3 = "Mineralnye Vody"
airbase_4 = "Sukhumi-Babushara"

inactive_timer = 300

if random_civ_air_traffic == true then

  if enable_yak == true then
    local yak=RAT:New("RAT_YAK")
    yak:SetDeparture({airbase_1, airbase_2, airbase_3, airbase_4})
    --yak:SetMaxDistance(max_distance_destination/10)
    yak:SetDestination({airbase_1, airbase_2, airbase_3, airbase_4})
    yak:TimeDestroyInactive(inactive_timer)
    yak:ATC_Messages(false)
    yak:SetFLcruise(air_traffic_flight_level)
    if civ_allow_immortal == true then
      yak:Immortal()
    end
    if civ_allow_invisible == true then
      yak:Invisible()
    end
    yak:Spawn(civ_rat_spawns)
  end

  if enable_c130 == true then
    local c130=RAT:New("RAT_C130")
    c130:SetDeparture({airbase_1, airbase_2, airbase_3, airbase_4})
    --c130:SetMaxDistance(max_distance_destination/5)
    c130:SetDestination({airbase_1, airbase_2, airbase_3, airbase_4})
    c130:TimeDestroyInactive(inactive_timer)
    c130:ATC_Messages(false)
    c130:SetFLcruise(air_traffic_flight_level)
    if civ_allow_immortal == true then
      c130:Immortal()
    end
    if civ_allow_invisible == true then
      c130:Invisible()
    end
    c130:Spawn(civ_rat_spawns)
  end

  if enable_c5 == true then
    local c5 =RAT:New("RAT_C5")
    c5:SetDeparture({ airbase_1, airbase_2, airbase_3, airbase_4})
    --c5:SetMaxDistance(max_distance_destination)
    c5:SetDestination({airbase_1, airbase_2, airbase_3, airbase_4})
    c5:TimeDestroyInactive(inactive_timer)
    c5:ATC_Messages(false)
    c5:SetFLcruise(air_traffic_flight_level)
    if civ_allow_immortal == true then
      c5:Immortal()
    end
    if civ_allow_invisible == true then
      c5:Invisible()
    end
    c5:Spawn(civ_rat_spawns)
  end

  if enable_an26 == true then
    local an26=RAT:New("RAT_AN26")
    an26:SetDeparture({airbase_1, airbase_2, airbase_3, airbase_4})
    --an26:SetMaxDistance(max_distance_destination/5)
    an26:SetDestination({airbase_1, airbase_2, airbase_3, airbase_4})
    an26:TimeDestroyInactive(inactive_timer)
    an26:ATC_Messages(false)
    an26:SetFLcruise(air_traffic_flight_level)
    if civ_allow_immortal == true then
      an26:Immortal()
    end
    if civ_allow_invisible == true then
      an26:Invisible()
    end
    an26:Spawn(civ_rat_spawns)
  end

  if enable_a320 == true then
    local a320 =RAT:New("RAT_A320")
    a320:SetDeparture({ airbase_1, airbase_2, airbase_3, airbase_4})
    --a320:SetMaxDistance(max_distance_destination)
    a320:SetDestination({airbase_1, airbase_2, airbase_3, airbase_4})
    a320:TimeDestroyInactive(inactive_timer)
    a320:ATC_Messages(false)
    a320:SetFLcruise(air_traffic_flight_level)
    if civ_allow_immortal == true then
      a320:Immortal()
    end
    if civ_allow_invisible == true then
      a320:Invisible()
    end
    a320:Spawn(civ_rat_spawns)
  end

  if enable_a380 == true then
    local a380 =RAT:New("RAT_A380")
    a380:SetDeparture({ airbase_1, airbase_2, airbase_3, airbase_4})
    --a380:SetMaxDistance(max_distance_destination)
    a380:SetDestination({airbase_1, airbase_2, airbase_3, airbase_4})
    a380:TimeDestroyInactive(inactive_timer)
    a380:ATC_Messages(false)
    a380:SetFLcruise(air_traffic_flight_level)
    if civ_allow_immortal == true then
      a380:Immortal()
    end
    if civ_allow_invisible == true then
      a380:Invisible()
    end
    a380:Spawn(civ_rat_spawns)
  end

  if enable_b737 == true then
    local b737 =RAT:New("RAT_B737")
    b737:SetDeparture({ airbase_1, airbase_2, airbase_3, airbase_4})
    --b737:SetMaxDistance(max_distance_destination)
    b737:SetDestination({airbase_1, airbase_2, airbase_3, airbase_4})
    b737:TimeDestroyInactive(inactive_timer)
    b737:ATC_Messages(false)
    b737:SetFLcruise(air_traffic_flight_level)
    if civ_allow_immortal == true then
      b737:Immortal()
    end
    if civ_allow_invisible == true then
      b737:Invisible()
    end
    b737:Spawn(civ_rat_spawns)
  end
  timer.scheduleFunction(function()
    trigger.action.outText("Random Civilian Air Traffic is ENABLED...", 10)
  end, nil, timer.getTime() + 8  )


end

if random_civ_air_traffic == false then
  timer.scheduleFunction(function()
    trigger.action.outText("Random Civilian Air Traffic is DISABLED...", 10)
  end, nil, timer.getTime() + 8  )

end


env.info('RAT Script complete')