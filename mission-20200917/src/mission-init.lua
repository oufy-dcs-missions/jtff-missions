
-- ---------------------------------------------------------------------------
--Skynet IADS Settings
-- ---------------------------------------------------------------------------


redSkynet = SkynetIADS:create('redSkyNet')

--local iadsDebug = redSkynet:getDebugSettings()
--iadsDebug.IADSStatus = true
--iadsDebug.samWentDark = true
--iadsDebug.contacts = true
--iadsDebug.radarWentLive = true
--iadsDebug.ewRadarNoConnection = true
--iadsDebug.samNoConnection = true
--iadsDebug.jammerProbability = true
--iadsDebug.addedEWRadar = true
--iadsDebug.hasNoPower = true
--iadsDebug.addedSAMSite = true
--iadsDebug.warnings = true
--iadsDebug.harmDefence = true
--iadsDebug.samSiteStatusEnvOutput = true
--iadsDebug.earlyWarningRadarStatusEnvOutput = true

redSkynet:addEarlyWarningRadarsByPrefix('EWR-')
redSkynet:addSAMSitesByPrefix('SA')

local ewCenterPowerSource = StaticObject.getByName('GPU-1')
local ewCenterConnNode = StaticObject.getByName('CommandTower')
redSkynet:getEarlyWarningRadarByUnitName('EWR-Tuapse'):addPowerSource(ewCenterPowerSource):addConnectionNode(ewCenterConnNode)
--
--
local commandCenter = StaticObject.getByName("RedCommandCenter")
local comPowerSource = StaticObject.getByName("GPU-2")
redSkynet:addCommandCenter(commandCenter):addPowerSource(comPowerSource)
redSkynet:setupSAMSitesAndThenActivate(60)



-- ---------------------------------------------------------------------------
--AIRBOSS settings
-- ---------------------------------------------------------------------------
airboss_enable = true

airboss_enable_markzones = true

airboss_enable_smokezones = false

airboss_enable_niceguy = false

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
    airbossCVN:SetPatrolAdInfinitum(false)
    airbossCVN:SetCarrierControlledArea(50)
    airbossCVN:SetStaticWeather(true)
    airbossCVN:SetMenuSingleCarrier()
    airbossCVN:SetRecoveryCase(3)
    airbossCVN:SetMaxLandingPattern(5)
    airbossCVN:SetDefaultPlayerSkill(AIRBOSS.Difficulty.NORMAL) -- other options EASY / HARD
    airbossCVN:SetHandleAIOFF()
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
    local window1 = airbossCVN:AddRecoveryWindow("19:45", "21:30", 3, 30, true)

    airbossCVN:Start()

    if airboss_enable_tanker == true then
        carrierTanker = RECOVERYTANKER:New(UNIT:FindByName("roosevelt"), "texaco-1")
        carrierTanker:SetUseUncontrolledAircraft()
        function carrierTanker:OnAfterStart(From,Event,To)
            airbossCVN:SetRecoveryTanker(carrierTanker)
        end
        carrierTanker:SetTACAN(51, "TEX")
        carrierTanker:SetRadio(276.2, "AM")
        carrierTanker:SetRespawnOn()
        carrierTanker:SetAltitude(12500)
        carrierTanker:SetSpeed(270)
        carrierTanker:Start()
    end

    if airboss_enable_awacs == true then
        CVNAwacs=RECOVERYTANKER:New(UNIT:FindByName("roosevelt"), "overlord-1")
        CVNAwacs:SetUseUncontrolledAircraft()
        CVNAwacs:SetAWACS()
        CVNAwacs:SetRadio(265.8)
        CVNAwacs:SetAltitude(28000)
        CVNAwacs:SetSpeed(270)
        CVNAwacs:SetRespawnOn()
        CVNAwacs:SetCallsign(CALLSIGN.AWACS.Overlord)
        CVNAwacs:SetRacetrackDistances(30, 30)
        CVNAwacs:SetModex(611)
        CVNAwacs:SetTACAN(50, "OVR")
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


-- ---------------------------------------------------------------------------
--Fleet Defense
-- ---------------------------------------------------------------------------
SpawnPatrol = nil
timer.scheduleFunction(function()
    CVNAirbase = AIRBASE:FindByName("roosevelt")
    PatrolZoneGroup = GROUP:FindByName( "Zone_FleetPatrol" )
    CapPatrolZone = ZONE_POLYGON:New( "Zone_FleetPatrol", PatrolZoneGroup )
    SpawnPatrol = SPAWN:New( "CAPCVN" )
                       :OnSpawnGroup(
            function ( SpawnGroup )
                AICapZone = AI_CAP_ZONE:New(CapPatrolZone, 500, 40000, 250, 1500)
                AICapZone:SetControllable( SpawnGroup )
                EngageZoneGroup = GROUP:FindByName( "Zone_FleetDefense" )
                CapEngageZone = ZONE_POLYGON:New( "Zone_FleetDefense", EngageZoneGroup )
                AICapZone:SetEngageZone(CapEngageZone)
                AICapZone:__Start( 1 )
            end
    ):InitLimit(2,6):InitGrouping(2):InitRepeatOnEngineShutDown():InitSkill("Excellent"):InitAirbase(CVNAirbase, SPAWN.Takeoff.Cold)
    SpawnPatrol:SpawnAtAirbase(CVNAirbase,GROUP.Takeoff.Cold)
    SpawnPatrol:SpawnAtAirbase(CVNAirbase,GROUP.Takeoff.Cold)
end, {}, timer.getTime() + 25*60)


-- ---------------------------------------------------------------------------
--RAT
-- ---------------------------------------------------------------------------
RAT_A320_AirFrance = RAT:New("A320-Airfrance")
RAT_A320_Aeroflot = RAT:New("A320-Aeroflot")
RAT_A380_China = RAT:New("A380-China")
RAT_A380_China:SetTakeoffAir()
RAT_A380_China:SetDeparture({"RAT_Ukraine" , "RAT_Europe" , "RAT_Russia", "RAT_UAE"})
RAT_A320_AirFrance:SetDestination("RAT_France")
RAT_A320_Aeroflot:SetDestination({AIRBASE.Caucasus.Krasnodar_Center ,
                                  AIRBASE.Caucasus.Krasnodar_Pashkovsky,
                                  AIRBASE.Caucasus.Mineralnye_Vody,
                                  AIRBASE.Caucasus.Vaziani,
                                  AIRBASE.Caucasus.Sochi_Adler,
                                  AIRBASE.Caucasus.Batumi,
                                  AIRBASE.Caucasus.Sukhumi_Babushara})
RAT_A380_China:SetDestination({AIRBASE.Caucasus.Krasnodar_Center ,
                                  AIRBASE.Caucasus.Krasnodar_Pashkovsky,
                                  AIRBASE.Caucasus.Mineralnye_Vody,
                                  AIRBASE.Caucasus.Vaziani,
                                  AIRBASE.Caucasus.Sochi_Adler,
                                  AIRBASE.Caucasus.Batumi,
                                  AIRBASE.Caucasus.Sukhumi_Babushara})
RAT_A320_AirFrance:Invisible():Spawn(2)
RAT_A320_Aeroflot:Invisible():Spawn(3)
RAT_A380_China:Invisible():Spawn(1)