-- ---------------------------------------------------------------------------
--AIRBOSS settings
-- ---------------------------------------------------------------------------
airboss_enable = true

airboss_enable_markzones = true

airboss_enable_smokezones = true

airboss_enable_niceguy = false

airboss_enable_tanker = true
airboss_enable_rescue_helo = true
airboss_enable_awacs = false

airbossCVN = nil
carrierTanker = nil  --Ops.RecoveryTanker#RECOVERYTANKER
RescueHelo = nil
CVNAwacs = nil

if airboss_enable == true then

    airbossCVN = AIRBOSS:New("roosevelt", "roosevelt")
    airbossCVN:SetTACAN(71, "X", "RSV")
    airbossCVN:SetICLS(11, "RSVLSO")
    airbossCVN:SetLSORadio(127.3)
    airbossCVN:SetMarshalRadio(127.5)
    airbossCVN:SetPatrolAdInfinitum(false)
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
    local window1 = airbossCVN:AddRecoveryWindow("16:30", "20:30", 1, 0, true, 20, false)

    airbossCVN:Start()

    if airboss_enable_tanker == true then
        carrierTanker = RECOVERYTANKER:New(UNIT:FindByName("roosevelt"), "shell-1")
        carrierTanker:SetUseUncontrolledAircraft()
        function carrierTanker:OnAfterStart(From,Event,To)
            airbossCVN:SetRecoveryTanker(carrierTanker)
        end
        carrierTanker:SetTACAN(51, "SHL")
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

-- *****************************************************************************
-- *                         Global Objects creation                           *
-- *****************************************************************************
--
-- Spawns IAFighters
--
arrSpanwGuns = {
    SPAWN:New("WVRIAGun-1"),
    SPAWN:New("WVRIAGun-2"),
    SPAWN:New("WVRIAGun-3")
}
arrSpanwFox2 = {
    SPAWN:New("WVRIAFox2-1"),
    SPAWN:New("WVRIAFox2-2")
}
arrSpanwFox1 = {
    SPAWN:New("BVRIAFox1-1"),
    SPAWN:New("BVRIAFox1-2")
}
arrSpanwFox3 = {
    SPAWN:New("BVRIAFox3-1"),
    SPAWN:New("BVRIAFox3-2"),
	SPAWN:New("BVRIAFox3-3")
}

-- *****************************************************************************
-- *                           Mission functions                               *
-- *****************************************************************************
function RandomPopUp(param)
    local arrSpawn = param[1]
    local strSkillLevel = param[2]
    local strFlightName = param[3]
    local intMessageTempo = param[4] or 45
    local strMessage = param[5] or "Groupe %s activé !"
    local blnSilent = param[6] or false
    local count = 0
    for _ in pairs(arrSpawn) do
        count = count + 1
    end
    local spawnObject = arrSpawn[math.random(1, count)]
    ActivateGroup({spawnObject ,strSkillLevel, strFlightName, intMessageTempo, strMessage, blnSilent })
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




-- *****************************************************************************
-- *                               Mission Menus                               *
-- *****************************************************************************
--MenuFox31Blue = MENU_GROUP:New(GROUP:FindByName("Fox3-1"), "BVR Fox3"  , nil )
--MenuFox32Blue = MENU_GROUP:New(GROUP:FindByName("Fox3-2"), "BVR Fox3"  , nil )
--MenuFox11Blue = MENU_GROUP:New(GROUP:FindByName("Fox1-1"), "BVR Fox1"  , nil )
--MenuFox12Blue = MENU_GROUP:New(GROUP:FindByName("Fox1-2"), "BVR Fox1"  , nil )
--MenuFox21Blue = MENU_GROUP:New(GROUP:FindByName("Fox1-1"), "WVR Fox2"  , nil )
--MenuFox22Blue = MENU_GROUP:New(GROUP:FindByName("Fox1-2"), "WVR Fox2"  , nil )
--MenuGuns1Blue = MENU_GROUP:New(GROUP:FindByName("Gun-1"), "WVR Guns"  , nil )
--MenuGuns2Blue = MENU_GROUP:New(GROUP:FindByName("Gun-2"), "WVR Guns"  , nil )
menuPopFox31 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "PopUp groupe BVR Fox 3", nil , RandomPopUp, {arrSpanwFox3, "Excellent", "IA Fox3", 45} )
--menuPopFox32 = MENU_COALITION_COMMAND:New(GROUP:FindByName("Fox3-2"), "PopUp groupe BVR Fox 3", nil , RandomPopUp, {arrSpanwFox3, "Excellent", "IA Fox3", 45} )
menuPopFox11 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "PopUp groupe BVR Fox 1", nil , RandomPopUp, {arrSpanwFox1, "Excellent", "IA Fox1", 45} )
--menuPopFox12 = MENU_COALITION_COMMAND:New(GROUP:FindByName("Fox1-2"), "PopUp groupe BVR Fox 1", nil , RandomPopUp, {arrSpanwFox1, "Excellent", "IA Fox1", 45} )
menuPopFox21 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "PopUp groupe WVR Fox 2", nil , RandomPopUp, {arrSpanwFox2, "Excellent", "IA Fox2", 45} )
--menuPopFox22 = MENU_COALITION_COMMAND:New(GROUP:FindByName("Fox2-2"), "PopUp groupe WVR Fox 2", nil , RandomPopUp, {arrSpanwFox2, "Excellent", "IA Fox2", 45} )
menuPopGuns1 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "PopUp groupe WVR Guns", nil , RandomPopUp, {arrSpanwGuns, "Excellent", "IA Guns", 45} )
--menuPopGuns2 = MENU_COALITION_COMMAND:New(GROUP:FindByName("Fox2-2"), "PopUp groupe WVR Guns", nil , RandomPopUp, {arrSpanwGuns, "Excellent", "IA Guns", 45} )

menuKillAllFox3Planes = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "sweep de la zone Fox3", nil, fctKillSpawnObjectArray, {arrSpanwFox3, "Zone Fox 3 dégagée !!"})
menuKillAllFox1Planes = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "sweep de la zone Fox1", nil, fctKillSpawnObjectArray, {arrSpanwFox1, "Zone Fox 1 dégagée !!"})
menuKillAllFox2Planes = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "sweep de la zone Fox2", nil, fctKillSpawnObjectArray, {arrSpanwFox2, "Zone Fox 2 dégagée !!"})
menuKillAllGunsPlanes = MENU_COALITION_COMMAND:New( coalition.side.BLUE, "sweep de la zone Guns", nil, fctKillSpawnObjectArray, {arrSpanwGuns, "Zone Guns dégagée !!"})

