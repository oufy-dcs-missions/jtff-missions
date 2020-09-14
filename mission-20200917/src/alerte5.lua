-- ---------------------------------------------------------------------------
--Fleet Defense
-- ---------------------------------------------------------------------------
SpawnPatrol = nil
AICapZone = nil
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
end, {}, timer.getTime() + 2*60)
