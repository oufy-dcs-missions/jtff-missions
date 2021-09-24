AirBossConfig = {
    {
        enable = true,
        carriername = 'CSG-1 CVN-71-1',
        alias = 'roosevelt',
        coalition = 'blue',
        enable_menumarkzones = true,
        enable_menusmokezones = true,
        enable_niceguy = true,
        handleAI = true,
        recoverytanker = 'nanny-1 #IFF:4775FR',
        tacan = {
            channel = 71,
            mode = 'X',
            morse = 'RSV',
        },
        icls = {
            channel = 11,
            morse = 'RSVLSO',
        },
        freq = {
            base = 127.3,
            marshall = 127.5,
            lso = 127.4
        },
        infintepatrol = true,
        controlarea = 65,
        recoverycase = 1,
        maxpatterns = 5,
        maxstacks = 8,
        difficulty = AIRBOSS.Difficulty.NORMAL,
        menurecovery = {
            enable = true,
            duration = 30,
            windondeck = 20,
            offset = 0,
            uturn = false
        },
        releayunit = {
            marshall = 'MarshallRelay',
            lso = 'LSORelay',
        },
        singlecarrier = true,
        event_duration_minutes = 90,
        operationsstatspath = "C:/airboss-stats",
        operationstrapsheetpath = "C:/airboss-trapsheets"
    }
}


