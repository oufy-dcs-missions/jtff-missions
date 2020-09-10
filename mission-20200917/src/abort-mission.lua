carrierTanker:RTB(carrierTanker.airbase)
carrierTanker:SetRespawnOff()
CVNAwacs:RTB(CVNAwacs.airbase)
CVNAwacs:SetRespawnOff()
airbossCVN:AddRecoveryWindow(UTILS.SecondsToClock(timer.getAbsTime()), UTILS.SecondsToClock(timer.getAbsTime()+90*60),3,30,true,27,true)
local GroupPlane, Index = SpawnPatrol:GetFirstAliveGroup()
while GroupPlane ~= nil do
    GroupPlane:RouteRTB(carrierTanker.airbase)
    GroupPlane, Index = SpawnPatrol:GetNextAliveGroup( Index )
end
