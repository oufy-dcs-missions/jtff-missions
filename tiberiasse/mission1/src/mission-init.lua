for index,viking in ipairs(VikingsConfig) do
    if viking.enable == true then
        RECOVERYTANKER:New(UNIT:FindByName(viking.patternUnit), viking.groupName)
                :SetTakeoffCold()
                :SetRespawnOnOff(viking.autorespawn)
                :SetAltitude(viking.altitude)
                :SetSpeed(viking.speed)
                :SetHomeBase(AIRBASE:FindByName(viking.baseUnit))
                :SetCallsign(viking.callsign.name, viking.callsign.number)
                :SetRadio(viking.freq)
                :SetModex(viking.modex)
                :SetTACAN(viking.tacan.channel, viking.tacan.morse)
                :SetRacetrackDistances(viking.racetrack.front, viking.racetrack.back)
                :Start()
    end
end

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

for index,hawkeye in ipairs(HawkEyesConfig) do
    if hawkeye.enable == true then
        RECOVERYTANKER:New(UNIT:FindByName(hawkeye.patternUnit), hawkeye.groupName)
                :SetAWACS()
                :SetTakeoffCold()
                :SetRespawnOnOff(hawkeye.autorespawn)
                :SetLowFuelThreshold(hawkeye.fuelwarninglevel)
                :SetAltitude(hawkeye.altitude)
                :SetSpeed(hawkeye.speed)
                :SetHomeBase(AIRBASE:FindByName(hawkeye.baseUnit))
                :SetCallsign(hawkeye.callsign.name, hawkeye.callsign.number)
                :SetRadio(hawkeye.freq)
                :SetModex(hawkeye.modex)
                :SetRacetrackDistances(hawkeye.racetrack.front, hawkeye.racetrack.back)
                :Start()
    end
end
