function smokeBlue(planeUnit)
    planeUnit:F2()
    trigger.action.smoke( planeUnit:GetVec3(), trigger.smokeColor.Blue )
    trigger.action.signalFlare(planeUnit:GetVec3(), trigger.flareColor.Red, 0)
    trigger.action.signalFlare(planeUnit:GetVec3(), trigger.flareColor.Red, 5)
    trigger.action.signalFlare(planeUnit:GetVec3(), trigger.flareColor.Red, 10)
    trigger.action.signalFlare(planeUnit:GetVec3(), trigger.flareColor.Red, 15)
    trigger.action.signalFlare(planeUnit:GetVec3(), trigger.flareColor.Red, 20)
    
end

vodooGroup = GROUP:FindByName("Voodoo-1")
hornetTest = GROUP:FindByName("hornet-test-1")
linerIntercepted = MESSAGE:New("OverLord , Voodoo,\nAvons intercepté le bogey. Il s'agit d'un liner visiblement radio HS.\nLe contact semble coopérant, demandons instructions.",60,nil,false )
if vodooGroup then
    linerIntercepted:ToGroup(vodooGroup)
end
if hornetTest then
    linerIntercepted:ToGroup(hornetTest)
end

linerStatus:Set(0)

bogeyGroup = GROUP:FindByName("liner civil")
bogeyUnit = UNIT:FindByName("liner civil-1")
bogeyGroup:RouteRTB(AIRBASE:FindByName(AIRBASE.Caucasus.Gudauta), bogeyGroup:GetSpeedMax())
bogeyGroup:OptionROEHoldFire():OptionAlarmStateGreen()
smokeBlue(bogeyUnit)