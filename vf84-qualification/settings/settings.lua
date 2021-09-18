-- *****************************************************************************
-- *                         AIRBOSS settings                                  *
-- *****************************************************************************
AirBossConfig = {
    {
        enable = true,
        carriername = 'roosevelt',
        alias = 'roosevelt',
        enable_markzones = true,
        enable_smokezones = false,
        enable_niceguy = true,
        handleAI = true,
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
            base = 127.5,
            marshall = 251.75,
            lso = 126.5
        },
        infintepatrol = true,
        controlarea = 50,
        recoverycase = 1,
        maxpatterns = 5,
        difficulty = AIRBOSS.Difficulty.NORMAL,
        menurecovery = {
            enable = true,
            duration = 30,
            windondeck = 20,
            uturn = true
        },
        releayunit = {
            marshall = 'MarshallRelay',
            lso = 'LSORelay',
        },
        singlecarrier = true
    }
}

-- *****************************************************************************
-- *                         RAT settings                                      *
-- *****************************************************************************
RATConfig = {
    {
        name = 'civil',
        enable = true,
        aircrafts_groupconfigs = {
            {
                templatename = 'RAT_YAK@IFF:5555UN',
                spawns = 3,
                flightlevel = 260,
                inactive_timer = 300,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = true,
                airbases_names = {
                    departure = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    },
                    arrival = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    }
                }
            },
            {
                templatename = 'RAT_A320@IFF:5554UN',
                spawns = 1,
                flightlevel = 330,
                inactive_timer = 1200,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = false,
                airbases_names = {
                    departure = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    },
                    arrival = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    }
                }
            },
            {
                templatename = 'RAT_A380@IFF:5556FR',
                spawns = 1,
                flightlevel = 380,
                inactive_timer = 1200,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = false,
                airbases_names = {
                    departure = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    },
                    arrival = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    }
                }
            },
            {
                templatename = 'RAT_B737@IFF:5557FR',
                spawns = 1,
                flightlevel = 370,
                inactive_timer = 1200,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = false,
                airbases_names = {
                    departure = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    },
                    arrival = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    }
                }
            }
        }
    },
    {
        name = 'military',
        enable = true,
        aircrafts_groupconfigs = {
            {
                templatename = 'RAT_C130@IFF:5551FR',
                spawns = 1,
                flightlevel = 140,
                inactive_timer = 300,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = false,
                airbases_names = {
                    departure = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    },
                    arrival = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    }
                }
            },
            {
                templatename = 'RAT_C5@IFF:5552FR',
                spawns = 1,
                flightlevel = 260,
                inactive_timer = 1200,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = false,
                airbases_names = {
                    departure = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    },
                    arrival = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    }
                }
            },
            {
                templatename = 'RAT_AN26@IFF:5553UN',
                spawns = 1,
                flightlevel = 260,
                inactive_timer = 900,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = false,
                airbases_names = {
                    departure = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    },
                    arrival = {
                        AIRBASE.Caucasus.Sochi_Adler,
                        AIRBASE.Caucasus.Tbilisi_Lochini,
                        AIRBASE.Caucasus.Mineralnye_Vody,
                        AIRBASE.Caucasus.Sukhumi_Babushara
                    }
                }
            }
        }
    }
}


TankersConfig = {
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'anchor-129-1-1',
        baseUnit = AIRBASE.Caucasus.Novorossiysk,
        groupName = '129',
        airboss_recovery = false,
        escortgroupname = 'escort-4',
        altitude = 26000,
        speed = 430,
        tacan = {
            channel = 25,
            morse = '129',
        },
        freq = 251.2,
        fuelwarninglevel = 20,
        racetrack = {
            front = 0,
            back = -40
        },
        modex = 129,
        callsign = {
            name = '129',
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'roosevelt',
        baseUnit = 'roosevelt',
        groupName = 'shell-1',
        airboss_recovery = true,
        escortgroupname = 'escort-2',
        altitude = 12500,
        speed = 270,
        tacan = {
            channel = 14,
            morse = 'SHL',
        },
        freq = 276.2,
        fuelwarninglevel = 20,
        racetrack = {
            front = 35,
            back = -10
        },
        modex = 702,
        callsign = {
            name = CALLSIGN.Tanker.Shell,
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'anchor-texaco-1-1',
        baseUnit = AIRBASE.Caucasus.Batumi,
        groupName = 'texaco',
        airboss_recovery = false,
        escortgroupname = 'escort-1',
        altitude = 28000,
        speed = 430,
        tacan = {
            channel = 15,
            morse = 'TEX',
        },
        freq = 317.500,
        fuelwarninglevel = 20,
        racetrack = {
            front = 45,
            back = 0
        },
        modex = 345,
        callsign = {
            name = CALLSIGN.Tanker.Texaco,
            number = 1
        }
    }
}

PedrosConfig = {
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'roosevelt',
        baseUnit = 'Unit #005',
        groupName = 'Pedro-1',
        freq = 127.5,
        modex = 704
    }
}


AwacsConfig = {
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'anchor-wizzard-1-1',
        baseUnit = 'roosevelt',
        groupName = 'wizzard-1',
        airboss_recovery = true,
        escortgroupname = 'escort-3',
        altitude = 24000,
        speed = 370,
        freq = 261,
        fuelwarninglevel=25,
        racetrack = {
            front = 40,
            back = 0
        },
        tacan = {
            channel = 16,
            morse = 'WZD',
        },
        modex = 611,
        callsign = {
            name = CALLSIGN.AWACS.Wizard,
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = false,
        patternUnit = 'anchor-overlord-1-1',
        baseUnit = AIRBASE.Caucasus.Batumi,
        groupName = 'overlord',
        airboss_recovery = false,
        escortgroupname = 'escort-1',
        altitude = 37000,
        speed = 410,
        freq = 265.8,
        fuelwarninglevel=15,
        racetrack = {
            front = 40,
            back = 0
        },
        tacan = {
            channel = 17,
            morse = 'OVL',
        },
        modex = 605,
        callsign = {
            name = CALLSIGN.AWACS.Overlord,
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'anchor-127-1-1',
        baseUnit = AIRBASE.Caucasus.Maykop_Khanskaya,
        groupName = '127',
        airboss_recovery = false,
        escortgroupname = 'escort-4',
        altitude = 32000,
        speed = 410,
        freq = 251,
        fuelwarninglevel=25,
        racetrack = {
            front = 40,
            back = 0
        },
        tacan = {
            channel = 18,
            morse = '127',
        },
        modex = 127,
        callsign = {
            name = '127',
            number = 1
        }
    }
}
