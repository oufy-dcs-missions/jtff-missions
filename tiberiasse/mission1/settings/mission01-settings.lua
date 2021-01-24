VikingsConfig = {
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'speedtexaco',
        baseUnit = 'ros',
        groupName = 'TEXACO',
        altitude = 12000,
        speed = 270,
        tacan = {
            channel = 103,
            morse = 'TEX',
        },
        freq = 123.6,
        racetrack = {
            front = 20,
            back = 10
        },
        modex = 511,
        callsign = {
            name = CALLSIGN.Tanker.Texaco,
            number = 1
        }
    }
}

PedrosConfig =
{
}

HawkEyesConfig = {
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'speedoverlord',
        baseUnit = 'ros',
        groupName = 'OVERLORD',
        altitude = 20000,
        speed = 290,
        freq = 123.75,
        fuelwarninglevel=20,
        racetrack = {
            front = 20,
            back = 30
        },
        modex = 603,
        callsign = {
            name = CALLSIGN.AWACS.Overlord,
            number = 1
        }
    }
}
