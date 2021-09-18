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

function EnterRecovery(objAirboss)
    local shipID = UNIT:FindByName(objAirboss.carrier:Name()):GetDCSObject():getID()
end

function LeaveRecovery(objAirboss)
    local shipID = UNIT:FindByName(objAirboss.carrier:Name()):GetDCSObject():getID()
end
function resetRecoveryTanker(recoveryTankerObject)
    recoveryTankerObject:SetRespawnOnOff(true)
    recoveryTankerObject.tanker:Destroy()
    recoveryTankerObject:SetRespawnOnOff(recoveryTankerObject.customconfig.autorespawn)
    if recoveryTankerObject.customconfig.escortgroupname then
        recoveryTankerObject.escortGroupObject:Destroy()
        --recoveryTankerObject.escortGroupObject = spawnRecoveryTankerEscort(recoveryTankerObject.escortSpawnObject,recoveryTankerObject.customconfig)
    end
end
function startCapZone(objCAPZone)
    AI_A2A_CAP:New2(
            objCAPZone.objSpawn:SpawnInZone(objCAPZone.objPatrolZone,
                    true
            ),
            UTILS.Round(objCAPZone.customconfig.capParameters.minEngageSpeed*1.852,0),
            UTILS.Round(objCAPZone.customconfig.capParameters.maxEngageSpeed*1.852,0),
            UTILS.Round(objCAPZone.customconfig.capParameters.engageFloor*0.3048,0),
            UTILS.Round(objCAPZone.customconfig.capParameters.engageCeiling*0.3048,0),
            AI.Task.AltitudeType.BARO,
            objCAPZone.objPatrolZone,
            UTILS.Round(objCAPZone.customconfig.capParameters.minPatrolSpeed*1.852,0),
            UTILS.Round(objCAPZone.customconfig.capParameters.maxPatrolSpeed*1.852,0),
            UTILS.Round(objCAPZone.customconfig.capParameters.patrolFloor*0.3048,0),
            UTILS.Round(objCAPZone.customconfig.capParameters.patrolCeiling*0.3048,0),
            AI.Task.AltitudeType.BARO
    )
            :SetEngageZone(objCAPZone.objEngageZone)
            :SetDetectionZone(objCAPZone.objEngageZone)
            :SetDetectionOn()
            :SetDetectionActivated()
            :Patrol()
    --local objAiCapZone = AI_CAP_ZONE:New(
    --        objCAPZone.objPatrolZone,
    --        UTILS.Round(objCAPZone.customconfig.capParameters.patrolFloor*0.3048,0),
    --        UTILS.Round(objCAPZone.customconfig.capParameters.patrolCeiling*0.3048,0),
    --        UTILS.Round(objCAPZone.customconfig.capParameters.minPatrolSpeed*1.852,0),
    --        UTILS.Round(objCAPZone.customconfig.capParameters.maxPatrolSpeed*1.852,0),
    --        AI.Task.AltitudeType.BARO
    --)
    --function objAiCapZone:OnAfterStart(from, event, to)
    --end

    --objAiCapZone:SetControllable(
    --        objCAPZone.objSpawn:SpawnInZone(objCAPZone.objPatrolZone,
    --                true
    --        )
    --)
end
function wipeCapZone(objCAPZone)
    fctKillSpawnObject(objCAPZone.objSpawn)
    trigger.action.outText('CAP Training Zone '..(objCAPZone.customconfig.name)..' cleaned !!', 30)
end
function fctKillSpawnObject(objSpawn)
    local GroupPlane, Index = objSpawn:GetFirstAliveGroup()
    while GroupPlane ~= nil do
        -- Do actions with the GroupPlane object.
        GroupPlane:Destroy(true)
        GroupPlane, Index = objSpawn:GetNextAliveGroup( Index )
    end
end
