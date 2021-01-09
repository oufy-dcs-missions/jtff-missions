VikingsConfig = {
    {
        enable = true,
        autorespawn = true,
        patternUnit = '⚓ CVN-1-2',
        baseUnit = '⚓ CVN-1-1',
        groupName = 'viking-template',
        altitude = 8000,
        speed = 270,
        tacan = {
            channel = 50,
            morse = 'ARC',
        },
        freq = 264,
        racetrack = {
            front = 25,
            back = 5
        },
        modex = 511,
        callsign = {
            name = CALLSIGN.Tanker.Arco,
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = true,
        patternUnit = '⚓ CVN-2-2',
        baseUnit = '⚓ CVN-2-1',
        groupName = 'viking-template',
        altitude = 7000,
        speed = 270,
        tacan = {
            channel = 51,
            morse = 'SHL',
        },
        freq = 264,
        racetrack = {
            front = 25,
            back = 5
        },
        modex = 511,
        callsign = {
            name = CALLSIGN.Tanker.Shell,
            number = 1
        }
    }
}

PedrosConfig =
{
    {
        enable = true,
        autorespawn = true,
        patternUnit = '⚓ CVN-1-1',
        baseUnit = '⚓ CVN-1-4',
        groupName = 'pedro_template',
        freq = 127.5,
        modex = 704
    },
    {
        enable = true,
        autorespawn = true,
        patternUnit = '⚓ CVN-2-1',
        baseUnit = '⚓ CVN-2-4',
        groupName = 'pedro_template',
        freq = 127.4,
        modex = 705
    }
}


HawkEyesConfig = {
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'anchor-awacs-1-1',
        baseUnit = '⚓ CVN-1-1',
        groupName = 'hawkeye_template',
        altitude = 28000,
        speed = 290,
        freq = 265.8,
        fuelwarninglevel=35,
        racetrack = {
            front = 30,
            back = 30
        },
        modex = 603,
        callsign = {
            name = CALLSIGN.AWACS.Magic,
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'anchor-awacs-2-1',
        baseUnit = '⚓ CVN-2-1',
        groupName = 'hawkeye_template',
        altitude = 27000,
        speed = 290,
        freq = 261,
        fuelwarninglevel=35,
        racetrack = {
            front = 30,
            back = 30
        },
        modex = 601,
        callsign = {
            name = CALLSIGN.AWACS.Darkstar,
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = false,
        patternUnit = 'anchor-awacs-3-1',
        baseUnit = 'Adana Sakirpasa',
        groupName = 'E3_template',
        altitude = 37000,
        speed = 410,
        freq = 307,
        fuelwarninglevel=60,
        racetrack = {
            front = 10,
            back = 10
        },
        modex = 605,
        callsign = {
            name = CALLSIGN.AWACS.Wizard,
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = false,
        patternUnit = 'anchor-awacs-red-1',
        baseUnit = 'Damascus',
        groupName = 'A50_template',
        altitude = 34000,
        speed = 410,
        freq = 251,
        fuelwarninglevel=35,
        racetrack = {
            front = 50,
            back = 50
        },
        modex = 058,
        callsign = {
            name = CALLSIGN.AWACS.Darkstar,
            number = 1
        }
    }
}
