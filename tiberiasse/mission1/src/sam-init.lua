tiberiasseMantis = MANTIS:New(
        'tiberiasse',
        'SAM RED',
        'EWR RED',
        'HQ RED-1',
        'red',
        true,
        'A50_template')

tiberiasseMantis:SetAdvancedMode(true, 80)
tiberiasseMantis:SetEWRGrouping(5000)
tiberiasseMantis:SetEWRRange(200000)
tiberiasseMantis:SetSAMRadius(20000)
tiberiasseMantis:SetSAMRange(60)
tiberiasseMantis:SetDetectInterval(30)
tiberiasseMantis:SetAutoRelocate(false,true)
tiberiasseMantis:Debug(true)
tiberiasseMantis:Start()
