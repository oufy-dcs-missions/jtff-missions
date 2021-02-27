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
--
-- Generic Group functions
--

-- *****************************************************************************
-- *                               Mission init                                *
-- *****************************************************************************
--                     **                     Tankers                         **
--                     *********************************************************
tankersArray = {}
compteur = 0
for index, tankerconfig in ipairs(TankersConfig) do
    if tankerconfig.enable == true then
        compteur = compteur + 1
        env.info('creation Tanker : '.. tankerconfig.groupName..'...')
        local objTanker = RECOVERYTANKER:New(UNIT:FindByName(tankerconfig.patternUnit), tankerconfig.groupName)
                                        :SetTakeoffCold()
                                        :SetRespawnOnOff(tankerconfig.autorespawn)
                                        :SetLowFuelThreshold(tankerconfig.fuelwarninglevel)
                                        :SetAltitude(tankerconfig.altitude)
                                        :SetSpeed(tankerconfig.speed)
                                        :SetHomeBase(AIRBASE:FindByName(tankerconfig.baseUnit),tankerconfig.terminalType)
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
        tankersArray[compteur] = objTanker
        tankersArray[compteur]:Start()
    end
end


-- *****************************************************************************
--                     **                     Awacs                           **
--                     *********************************************************
AwacsArray = {}
compteur = 0
for index, awacsconfig in ipairs(AwacsConfig) do
    if awacsconfig.enable == true then
        compteur = compteur + 1
        env.info('creation AWACS : '.. awacsconfig.groupName..'...')
        local objAwacs = RECOVERYTANKER:New(UNIT:FindByName(awacsconfig.patternUnit), awacsconfig.groupName)
                                       :SetAWACS(true, true)
                                       :SetTakeoffCold()
                                       :SetRespawnOnOff(awacsconfig.autorespawn)
                                       :SetLowFuelThreshold(awacsconfig.fuelwarninglevel)
                                       :SetAltitude(awacsconfig.altitude)
                                       :SetSpeed(awacsconfig.speed)
                                       :SetHomeBase(AIRBASE:FindByName(awacsconfig.baseUnit),awacsconfig.terminalType)
                                       :SetCallsign(awacsconfig.callsign.name, awacsconfig.callsign.number)
                                       :SetRecoveryAirboss(awacsconfig.airboss_recovery)
                                       :SetRadio(awacsconfig.freq)
                                       :SetModex(awacsconfig.modex)
                                       :SetTACAN(awacsconfig.tacan.channel , awacsconfig.tacan.morse)
                                       :SetRacetrackDistances(awacsconfig.racetrack.front, awacsconfig.racetrack.back)
        objAwacs.customconfig = awacsconfig
        if awacsconfig.escortgroupname then
            function objAwacs:OnAfterStart(from, event, to)
                env.info('popup AWACS : '..self.tanker.GroupName)
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
        AwacsArray[compteur] = objAwacs
        AwacsArray[compteur]:Start()
    end
end

-- *****************************************************************************
--                     **                     Rescue Hello                    **
--                     *********************************************************
PedroArray = {}
compteur = 0
for index,pedro in ipairs(PedrosConfig) do
    if pedro.enable == true then
        compteur = compteur +1
        local rescuehelo = RESCUEHELO:New(UNIT:FindByName(pedro.patternUnit),pedro.groupName)
                                     :SetHomeBase(AIRBASE:FindByName(pedro.baseUnit))
                                     :SetTakeoffCold()
                                     :SetRespawnOnOff(pedro.autorespawn)
                                     :SetRescueDuration(1)
                                     :SetModex(pedro.modex)
        function rescuehelo:OnAfterStart(from, event, to)
            self.helo:CommandSetFrequency(pedro.freq, radio.modulation.AM)
        end
        PedroArray[compteur] = rescuehelo
        PedroArray[compteur]:Start()
    end
end

-- *****************************************************************************
--                     **                       AirBoss                       **
--                     *********************************************************
AIRBOSSArray = {}
compteur = 0
for index, airbossconfig in ipairs(AirBossConfig) do
    if airbossconfig.enable == true then
        compteur = compteur +1
        local objAirboss = AIRBOSS:New(airbossconfig.carriername, airbossconfig.alias)
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
                    airbossconfig.menurecovery.uturn,
                    airbossconfig.menurecovery.offset)
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
        objAirboss:AddRecoveryWindow(
                60*45,
                60*(airbossconfig.menurecovery.duration+45),
                airbossconfig.recoverycase,
                airbossconfig.menurecovery.offset,
                true,
                airbossconfig.menurecovery.windondeck,
                airbossconfig.menurecovery.uturn
        )
        AIRBOSSArray[compteur] = objAirboss
        AIRBOSSArray[compteur]:Start()
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
RATArray = {}
compteur = 0
for index, ratconfig in ipairs(RATConfig) do
    if ratconfig.enable == true then
        compteur = compteur +1
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
                RATArray[compteur] = RATGroup
                RATArray[compteur]:Spawn(planegroupconfig.spawns)
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


-- *****************************************************************************
--                     **                    SAM Defenses                     **
--                     *********************************************************
SAMNetworkArray = {}
compteur = 0
for index, mantisconfig in ipairs(MantisConfig) do
    if mantisconfig.enable == true then
        compteur = compteur +1
        env.info('creation Mantis : '.. mantisconfig.name..'...')
        local objMantis = nil
        if mantisconfig.dynamic.enable == true then
            if mantisconfig.dynamic.AwacsTemplateName == '' then
                mantisconfig.dynamic.AwacsTemplateName = nil
            else
                mantisconfig.dynamic.AwacsGroupName = nil
                for index, awacsObject in ipairs(AwacsArray) do
                    if awacsObject.customconfig.groupName == mantisconfig.dynamic.AwacsTemplateName then
                        env.info('found AWACS linked to template '..mantisconfig.dynamic.AwacsTemplateName..' : it is '..awacsObject.tanker.GroupName)
                        mantisconfig.dynamic.AwacsGroupName = awacsObject.tanker.GroupName
                    end
                end
            end
            objMantis = MANTIS:New(
                    mantisconfig.name,
                    mantisconfig.SAMPrefix,
                    mantisconfig.EWRPrefix,
                    mantisconfig.dynamic.HQGroupName,
                    mantisconfig.coalition,
                    mantisconfig.dynamic.enable,
                    mantisconfig.dynamic.AwacsGroupName)
            env.info('MANTIS creation : SAM = '..objMantis.SAM_Templates_Prefix..' EWR = '..objMantis.EWR_Templates_Prefix)
            env.info('MANTIS creation : HQ = ' .. objMantis.HQ_Template_CC)
            env.info('MANTIS creation : AWACS = ' .. objMantis.AWACS_Prefix)
            objMantis:SetAutoRelocate(mantisconfig.dynamic.autorelocate.hq,mantisconfig.dynamic.autorelocate.ewr)
            if mantisconfig.dynamic.advanced == true then
                objMantis:SetAdvancedMode(mantisconfig.dynamic.advanced, mantisconfig.dynamic.ratio)
            end

        else
            objMantis = MANTIS:New(
                    mantisconfig.name,
                    mantisconfig.SAMPrefix,
                    mantisconfig.EWRPrefix,
                    nil,
                    mantisconfig.coalition,
                    false,
                    nil)
            env.info('MANTIS creation : SAM = '..objMantis.SAM_Templates_Prefix..' EWR = '..objMantis.EWR_Templates_Prefix)
        end
        objMantis:SetEWRGrouping(mantisconfig.EWRGrouping)
        objMantis:SetEWRRange(mantisconfig.EWRRange)
        objMantis:SetSAMRange(mantisconfig.SAMRange)
        objMantis:SetSAMRadius(mantisconfig.SAMRadius)
        objMantis:SetDetectInterval(mantisconfig.DetectInterval)
        objMantis:Debug(mantisconfig.debug)
        objMantis.verbose = mantisconfig.debug
        SAMNetworkArray[compteur] = objMantis
        SAMNetworkArray[compteur]:Start()
        --objMantis:Start()
    end
end

-- *****************************************************************************
--                     **                    Coalition Squadrons              **
--                     *********************************************************
A2AArray = {}
compteur = 0
for index, coalitionsquadconfig in ipairs(CoalitionSquadrons) do
    if coalitionsquadconfig.enable == true then
        compteur = compteur +1
        if not(coalitionsquadconfig.AwacsTemplateName == '') then
            for index, awacsObject in ipairs(AwacsArray) do
                if awacsObject.customconfig.groupName == coalitionsquadconfig.AwacsTemplateName then
                    env.info('found AWACS linked to template '..coalitionsquadconfig.AwacsTemplateName..' : it is '..awacsObject.tanker.GroupName)
                    table.insert(coalitionsquadconfig.detectionprefixarray,awacsObject.tanker.GroupName)
                end
            end
        end
        local DispatcherObject = AI_A2A_DISPATCHER:New(
                DETECTION_AREAS:New(
                        SET_GROUP:New()
                                 :FilterPrefixes(coalitionsquadconfig.detectionprefixarray)
                                 :FilterStart(),
                        coalitionsquadconfig.groupingrange)
        )
                                                  :SetDefaultFuelThreshold(coalitionsquadconfig.fuelthreshold)
                                                  :SetDefaultLanding(coalitionsquadconfig.landingtype)
                                                  :SetDefaultTakeoff(coalitionsquadconfig.takeofftype)
                                                  :SetDefaultCapLimit(coalitionsquadconfig.cappatrolpersquadron)
                                                  :SetDefaultGrouping(coalitionsquadconfig.defaultpatrolgrouping)
                                                  :SetEngageRadius(coalitionsquadconfig.engageradius)
                                                  :SetDisengageRadius(coalitionsquadconfig.abortradius)
                                                  :SetGciRadius(coalitionsquadconfig.gciradius)
        if not(coalitionsquadconfig.bordersgroup == '' or coalitionsquadconfig.bordersgroup == nil) then
            DispatcherObject = DispatcherObject:SetBorderZone(
                    ZONE_POLYGON:New(coalitionsquadconfig.bordersgroup,
                            GROUP:FindByName(coalitionsquadconfig.bordersgroup)
                    )
            )
        end
        for index, squadconfig in ipairs(coalitionsquadconfig.squadrons) do
            if squadconfig.enable then
                DispatcherObject:SetSquadron(
                        squadconfig.name,
                        squadconfig.base,
                        squadconfig.templatearray,
                        math.floor(squadconfig.numberofsplanes*squadconfig.availabilityrate)
                )
                if not(squadconfig.landingtype == '' or squadconfig.landingtype == nil) then
                    DispatcherObject:SetSquadronLanding(squadconfig.name,squadconfig.landingtype)
                end
                if not(squadconfig.takeofftype == '' or squadconfig.takeofftype == nil) then
                    DispatcherObject:SetSquadronTakeoff(squadconfig.name,squadconfig.takeofftype)
                end
                if ((squadconfig.capzonegroup == '' or squadconfig.capzonegroup == nil) and (squadconfig.capzone == '' or squadconfig.capzone == nil)) then
                    DispatcherObject:SetSquadronGci2(squadconfig.name, 920, 3000, 30, 14000, 'BARO')
                else
                    if (squadconfig.capzone == '' or squadconfig.capzone == nil) then
                        squadconfig.CAPZone = ZONE_POLYGON:New(squadconfig.name .. 'CAPZone', GROUP:FindByName(squadconfig.capzonegroup))
                    else
                        squadconfig.CAPZone = ZONE:New(squadconfig.capzone)
                    end
                    DispatcherObject:SetSquadronCap2(squadconfig.name, 740, 3000, 30, 14000, 'BARO', squadconfig.CAPZone, 400, 900, 4500, 9100, 'BARO')
                    DispatcherObject:SetSquadronCapInterval(squadconfig.name, 1, 2*60, 15*60)
                end
            end
        end
        DispatcherObject:SetTacticalDisplay(coalitionsquadconfig.debug)
        A2AArray[compteur] = DispatcherObject
        A2AArray[compteur]:Start()
    end
end
