-- *****************************************************************************
-- *                         Global Objects creation                           *
-- *****************************************************************************
--
-- Beacons
--

--
-- Scheduler Object
--

--
-- Sound Objects
--
snd1020HzTone = USERSOUND:New( "1020Hz_DF_tone.wav" )
-- *****************************************************************************
-- *                           Mission functions                               *
-- *****************************************************************************
--
-- Generic Spawn object functions
--
function taskTankerEscort(param)
  local recoveryTankerConfig = param[1]
  local recoveryTankerObject = param[2]
  local EscortGroup = param[3]
  EscortGroup:OptionAlarmStateRed()
  --EscortGroup:OptionROEReturnFire()
  EscortGroup:TraceOn()
  EscortGroup:OptionRTBAmmo(true)
  EscortGroup:OptionRTBBingoFuel(true)
  EscortGroup:SetTask(
          EscortGroup:TaskEscort(
                  GROUP:FindByName(recoveryTankerObject.tanker.GroupName),
                  POINT_VEC3:New( 0, 10, 150 ):GetVec3(),
                  20,
                  40*1800,
                  {'Air'}),
          1)
  env.info('Escort group spawned : '.. EscortGroup.GroupName..'. Escorting '..recoveryTankerObject.tanker.GroupName)
end
function spawnRecoveryTankerEscort(escortSpawnObject,customconfig)
  return escortSpawnObject
          :SpawnAtAirbase(AIRBASE:FindByName(customconfig.baseUnit),SPAWN.Takeoff.Cold, customconfig.altitude)
end
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
-- Tu_Raid trigger function
--
function Activatebomber(param)
  local arrGroups = param[1]
  for index, bomber in ipairs(arrGroups)
  do
    startUncontrolledAirGroup(bomber)
  end
end
function fctResetBomber(param)
  local bomber = param[1]
    GROUP:FindByName(bomber):Destroy(nil)
  local GroupBomber = SPAWN:New(bomber):InitSkill("Excellent"):Spawn()
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
for index, tankerconfig in ipairs(TankersConfig) do
  if tankerconfig.enable == true then
    env.info('creation Tanker : '.. tankerconfig.groupName..'...')
    local objTanker = RECOVERYTANKER:New(UNIT:FindByName(tankerconfig.patternUnit), tankerconfig.groupName)
            :SetTakeoffCold()
            :SetRespawnOnOff(tankerconfig.autorespawn)
            :SetLowFuelThreshold(tankerconfig.fuelwarninglevel)
            :SetAltitude(tankerconfig.altitude)
            :SetSpeed(tankerconfig.speed)
            :SetHomeBase(AIRBASE:FindByName(tankerconfig.baseUnit))
            :SetCallsign(tankerconfig.callsign.name, tankerconfig.callsign.number)
            :SetRecoveryAirboss(tankerconfig.airboss_recovery)
            :SetRadio(tankerconfig.freq)
            :SetModex(tankerconfig.modex)
            :SetTACAN(tankerconfig.tacan.channel, tankerconfig.tacan.morse)
            :SetRacetrackDistances(tankerconfig.racetrack.front, tankerconfig.racetrack.back)
    objTanker.customconfig = tankerconfig
    if tankerconfig.escortgroupname then
      function objTanker:OnAfterStart(from, event, to)
        self.escortSpawnObject = SPAWN:NewWithAlias(self.customconfig.escortgroupname,'escort-'.. self.customconfig.groupName)
                :InitRepeatOnEngineShutDown()
                :InitSkill("Excellent")
                :OnSpawnGroup(function(SpawnGroup)
          taskTankerEscort({self.customconfig, self, SpawnGroup})
        end)
        self.escortGroupObject = spawnRecoveryTankerEscort(self.escortSpawnObject,self.customconfig)
      end
      function objTanker:OnAfterRTB(from, event, to, airbase)
        env.info('Tanker RTB: '..self.tanker.GroupName..'...')
        if self.escortGroupObject:IsAirborne(false) == true then
          env.info('escort RTB : '.. self.escortGroupObject.GroupName..' Tanker : '..self.tanker.GroupName..'...')
          self.escortGroupObject:RouteRTB(airbase)
        else
          --self.escortGroupObject:Destroy(nil, 5)
        end
      end
      function objTanker:OnEventKill(event)
        env.info(event.target' Killed !! Sending escort Home')
        self.escortGroupObject:RouteRTB(AIRBASE:FindByName(self.customconfig.baseUnit))
      end
      function objTanker:OnAfterStatus(from, event, to)
        if not(GROUP:FindByName(self.escortGroupObject.GroupName)) then
          env.info('Respawning escort Group '..self.escortGroupObject.GroupName)
          self.escortGroupObject = self.escortSpawnObject
                                       :SpawnAtAirbase(AIRBASE:FindByName(self.customconfig.baseUnit),SPAWN.Takeoff.Cold, self.customconfig.altitude)
        end
      end
    end
    objTanker:Start()
    --arrayOfTankers[index] = objTanker
  end
end


-- *****************************************************************************
--                     **                     Awacs                           **
--                     *********************************************************
for index, awacsconfig in ipairs(AwacsConfig) do
  if awacsconfig.enable == true then
    env.info('creation AWACS : '.. awacsconfig.groupName..'...')
    local objAwacs = RECOVERYTANKER:New(UNIT:FindByName(awacsconfig.patternUnit), awacsconfig.groupName)
            :SetAWACS(true, true)
            :SetTakeoffCold()
            :SetRespawnOnOff(awacsconfig.autorespawn)
            :SetLowFuelThreshold(awacsconfig.fuelwarninglevel)
            :SetAltitude(awacsconfig.altitude)
            :SetSpeed(awacsconfig.speed)
            :SetHomeBase(AIRBASE:FindByName(awacsconfig.baseUnit))
            :SetCallsign(awacsconfig.callsign.name, awacsconfig.callsign.number)
            :SetRecoveryAirboss(awacsconfig.airboss_recovery)
            :SetRadio(awacsconfig.freq)
            :SetModex(awacsconfig.modex)
            :SetTACAN(awacsconfig.tacan.channel , awacsconfig.tacan.morse)
            :SetRacetrackDistances(awacsconfig.racetrack.front, awacsconfig.racetrack.back)
    objAwacs.customconfig = awacsconfig
    if awacsconfig.escortgroupname then
      function objAwacs:OnAfterStart(from, event, to)
        self.escortSpawnObject = SPAWN:NewWithAlias(self.customconfig.escortgroupname,'escort-'.. self.customconfig.groupName)
                                      :InitRepeatOnEngineShutDown()
                                      :InitSkill("Excellent")
                                      :OnSpawnGroup(function(SpawnGroup)
          taskTankerEscort({self.customconfig, self, SpawnGroup})
        end)
        self.escortGroupObject = spawnRecoveryTankerEscort(self.escortSpawnObject,self.customconfig)
      end
      function objAwacs:OnAfterRTB(from, event, to, airbase)
        env.info('AWACS RTB: '..self.tanker.GroupName..'...')
        if self.escortGroupObject:IsAirborne(false) == true then
          env.info('escort RTB : '.. self.escortGroupObject.GroupName..' AWACS : '..self.tanker.GroupName..'...')
          self.escortGroupObject:RouteRTB(airbase)
        else
          --self.escortGroupObject:Destroy(nil, 5)
        end
      end
      function objAwacs:OnEventKill(event)
        env.info(event.target' Killed !! Sending escort Home')
        self.escortGroupObject:RouteRTB(AIRBASE:FindByName(self.customconfig.baseUnit))
      end
      function objAwacs:OnAfterStatus(from, event, to)
        if not(GROUP:FindByName(self.escortGroupObject.GroupName)) then
          env.info('Respawning escort Group '..self.escortGroupObject.GroupName)
          self.escortGroupObject = self.escortSpawnObject
                                       :SpawnAtAirbase(AIRBASE:FindByName(self.customconfig.baseUnit),SPAWN.Takeoff.Cold, self.customconfig.altitude)
        end
      end
    end
    objAwacs:Start()
    --arrayOfAwacs[index] = objAwacs
  end
end

-- *****************************************************************************
--                     **                     Rescue Hello                    **
--                     *********************************************************
for index,pedro in ipairs(PedrosConfig) do
  if pedro.enable == true then
    rescuehelo = RESCUEHELO:New(UNIT:FindByName(pedro.patternUnit),pedro.groupName)
                           :SetHomeBase(AIRBASE:FindByName(pedro.baseUnit))
                           :SetTakeoffCold()
                           :SetRespawnOnOff(pedro.autorespawn)
                           :SetRescueDuration(1)
                           :SetModex(pedro.modex)
    function rescuehelo:OnAfterStart(from, event, to)
      self.helo:CommandSetFrequency(pedro.freq, radio.modulation.AM)
    end
  end
  rescuehelo:Start()
end

-- *****************************************************************************
--                     **                       AirBoss                       **
--                     *********************************************************
for index, airbossconfig in ipairs(AirBossConfig) do
  if airbossconfig.enable == true then
    objAirboss = AIRBOSS:New(airbossconfig.carriername, airbossconfig.alias)
    objAirboss:SetTACAN(airbossconfig.tacan.channel, airbossconfig.tacan.mode, airbossconfig.tacan.morse)
    objAirboss:SetICLS(airbossconfig.icls.channel, airbossconfig.icls.morse)
    objAirboss:SetLSORadio(airbossconfig.freq.lso)
    objAirboss:SetMarshalRadio(airbossconfig.freq.marshall)
    objAirboss:SetPatrolAdInfinitum(airbossconfig.infintepatrol)
    objAirboss:SetCarrierControlledArea(airbossconfig.controlarea)
    objAirboss:SetStaticWeather(true)
    objAirboss:SetRecoveryCase(airbossconfig.recoverycase)
    objAirboss:SetMaxLandingPattern(airbossconfig.maxpatterns)
    objAirboss:SetDefaultPlayerSkill(airbossconfig.difficulty) -- other options EASY / HARD
    if airbossconfig.handleAI == true then
      objAirboss:SetHandleAION()
    else
      objAirboss:SetHandleAIOFF()
    end
    if airbossconfig.menurecovery.enable == true then
      objAirboss:SetMenuRecovery(airbossconfig.menurecovery.duration,
              airbossconfig.menurecovery.windondeck,
              airbossconfig.menurecovery.uturn)
    end
    objAirboss:SetMenuMarkZones(airbossconfig.enable_markzones)
    objAirboss:SetMenuSmokeZones(airbossconfig.enable_smokezones)
    objAirboss:SetAirbossNiceGuy(airbossconfig.enable_niceguy)
    objAirboss:SetRadioRelayMarshal(airbossconfig.releayunit.marshall)
    objAirboss:SetRadioRelayLSO(airbossconfig.releayunit.lso)
    objAirboss:SetSoundfilesFolder("Airboss Soundfiles/")
    if airbossconfig.singlecarrier == true then
      objAirboss:SetMenuSingleCarrier()
    end
    --airbossCVN:Load(nil, "Greenie Board.csv")
    --airbossCVN:SetAutoSave(nil, "Greenie Board.csv")

    -- create fake recovery window at the end of the mission play
    --local window1 = airbossCVN:AddRecoveryWindow("15:00", "16:30", 3, 30, true, 20, false)
    --local window2 = airbossCVN:AddRecoveryWindow("18:00", "20:30", 3, 30, true, 20, false)
    objAirboss:Start()
    trigger.action.outText('AIRBOSS scripts Loaded for unit '..airbossconfig.carriername, 10)
    timer.scheduleFunction(function()
      trigger.action.outText(	"<< If the AIRBOSS option does not appear in your F10 - Other Menu, try switching slots a few times and you will get the AIRBOSS message popups! Check the AIRBOSS documentation (link in briefing for more info) >>", 30)
    end, nil, timer.getTime() + 30  )
  else
    timer.scheduleFunction(function()
      trigger.action.outText('AIRBOSS script disabled for unit '..airbossconfig.carriername, 10)
    end, nil, timer.getTime() + 8  )
  end
end

-- *****************************************************************************
--                     **                    Random Air Traffic               **
--                     *********************************************************
for index, ratconfig in ipairs(RATConfig) do
  if ratconfig.enable == true then
    for index_planegroup, planegroupconfig in ipairs(ratconfig.aircrafts_groupconfigs) do
      if planegroupconfig.spawns > 0 then
        local RATGroup = RAT:New(planegroupconfig.templatename)
        RATGroup:SetDeparture(planegroupconfig.airbases_names.departure)
        RATGroup:SetDestination(planegroupconfig.airbases_names.arrival)
        RATGroup:TimeDestroyInactive(planegroupconfig.inactive_timer)
        RATGroup:ATC_Messages(planegroupconfig.atcmessage_enable)
        RATGroup:SetFLcruise(planegroupconfig.flightlevel)
        if planegroupconfig.allow_immortal == true then
          RATGroup:Immortal()
        end
        if planegroupconfig.allow_invisible == true then
          RATGroup:Invisible()
        end
        RATGroup:Spawn(planegroupconfig.spawns)
      end
    end
    timer.scheduleFunction(function()
      trigger.action.outText('Random Air Traffic '..ratconfig.name..' is ENABLED...', 10)
    end, nil, timer.getTime() + 8  )
  else
    timer.scheduleFunction(function()
      trigger.action.outText('Random Air Traffic '..ratconfig.name..' is DISABLED', 10)
    end, nil, timer.getTime() + 8)
  end
end
