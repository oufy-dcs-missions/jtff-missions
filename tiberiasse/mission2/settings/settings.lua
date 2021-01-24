-- *****************************************************************************
-- *                         AIRBOSS settings                                  *
-- *****************************************************************************
AirBossConfig = {
    {
        enable = true,
        carriername = '⚓ CVN-1-1',
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
        infintepatrol = false,
        controlarea = 50,
        recoverycase = 3,
        maxpatterns = 5,
        difficulty = AIRBOSS.Difficulty.NORMAL,
        menurecovery = {
            enable = true,
            duration = 30,
            offset = 20,
            windondeck = 20,
            uturn = true
        },
        releayunit = {
            marshall = 'MarshallRelay_71',
            lso = 'LSORelay_71',
        },
        singlecarrier = false
    },
    {
        enable = true,
        carriername = '⚓ CVN-2-1',
        alias = 'washington',
        enable_markzones = true,
        enable_smokezones = false,
        enable_niceguy = true,
        handleAI = true,
        tacan = {
            channel = 73,
            mode = 'X',
            morse = 'WSN',
        },
        icls = {
            channel = 13,
            morse = 'WSNLSO',
        },
        freq = {
            base = 128,
            marshall = 252.25,
            lso = 127
        },
        infintepatrol = false,
        controlarea = 50,
        recoverycase = 3,
        maxpatterns = 5,
        difficulty = AIRBOSS.Difficulty.NORMAL,
        menurecovery = {
            enable = true,
            duration = 30,
            offset = -20,
            windondeck = 20,
            uturn = true
        },
        releayunit = {
            marshall = 'MarshallRelay_73',
            lso = 'LSORelay_73',
        },
        singlecarrier = false
    }
}

-- *****************************************************************************
-- *                         RAT settings                                      *
-- *****************************************************************************
RATConfig = {
    {
        name = 'civil',
        enable = false,
        aircrafts_groupconfigs = {
            {
                templatename = 'RAT-civil-1',
                spawns = 1,
                flightlevel = 260,
                inactive_timer = 300,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = true,
                airbases_names = {
                    departure = {
                        AIRBASE.Syria.Rene_Mouawad
                    },
                    arrival = {
                        AIRBASE.Syria.King_Hussein_Air_College
                    }
                }
            },
            {
                templatename = 'RAT-civil-2',
                spawns = 1,
                flightlevel = 220,
                inactive_timer = 1200,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = false,
                airbases_names = {
                    departure = {
                        AIRBASE.Syria.King_Hussein_Air_College
                    },
                    arrival = {
                        AIRBASE.Syria.Beirut_Rafic_Hariri
                    }
                }
            },
            {
                templatename = 'RAT-civil-3',
                spawns = 1,
                flightlevel = 380,
                inactive_timer = 1200,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = false,
                airbases_names = {
                    departure = {
                        AIRBASE.Syria.Adana_Sakirpasa,
                        AIRBASE.Syria.Haifa
                    },
                    arrival = {
                        AIRBASE.Syria.Haifa,
                        AIRBASE.Syria.Palmyra
                    }
                }
            }
        }
    },
    {
        name = 'military',
        enable = false,
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
        patternUnit = '⚓ CVN-1-2',
        baseUnit = '⚓ CVN-1-1',
        terminalType = AIRBASE.TerminalType.OpenMedOrBig,
        groupName = 'viking71',
        airboss_recovery = true,
        escortgroupname = 'escort_31',
        altitude = 8000,
        speed = 270,
        tacan = {
            channel = 50,
            morse = 'ARC',
        },
        freq = 276.2,
        fuelwarninglevel = 15,
        racetrack = {
            front = 25,
            back = -5
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
        terminalType = AIRBASE.TerminalType.OpenMedOrBig,
        groupName = 'viking73',
        airboss_recovery = true,
        escortgroupname = 'escort_143',
        altitude = 12000,
        speed = 270,
        tacan = {
            channel = 51,
            morse = 'SHL',
        },
        freq = 317.5,
        fuelwarninglevel = 15,
        racetrack = {
            front = 25,
            back = -5
        },
        modex = 511,
        callsign = {
            name = CALLSIGN.Tanker.Shell,
            number = 1
        }
    }
}

PedrosConfig = {
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
        freq = 128,
        modex = 705
    }
}


AwacsConfig = {
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'anchor-magic',
        baseUnit = '⚓ CVN-1-1',
        terminalType = AIRBASE.TerminalType.OpenMedOrBig,
        groupName = 'hawkeye_template',
        airboss_recovery = true,
        escortgroupname = 'escort_84',
        altitude = 28000,
        speed = 380,
        freq = 265.8,
        fuelwarninglevel=35,
        racetrack = {
            front = 60,
            back = 0
        },
        tacan = {
            channel = 30,
            morse = 'MGC',
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
        patternUnit = 'anchor-darkstar',
        baseUnit = '⚓ CVN-2-1',
        terminalType = AIRBASE.TerminalType.OpenMedOrBig,
        groupName = 'hawkeye_template73',
        airboss_recovery = true,
        escortgroupname = 'escort_131',
        altitude = 27000,
        speed = 380,
        freq = 261,
        fuelwarninglevel=35,
        racetrack = {
            front = 60,
            back = 0
        },
        tacan = {
            channel = 31,
            morse = 'DKS',
        },
        modex = 601,
        callsign = {
            name = CALLSIGN.AWACS.Darkstar,
            number = 1
        }
    },
    {
        enable = false,
        autorespawn = false,
        patternUnit = 'anchor-awacs-3-1',
        baseUnit = 'Adana Sakirpasa',
        terminalType = AIRBASE.TerminalType.OpenBig,
        groupName = 'E3_template',
        airboss_recovery = false,
        escortgroupname = 'escort_79',
        altitude = 37000,
        speed = 410,
        freq = 307,
        fuelwarninglevel=60,
        racetrack = {
            front = 10,
            back = 10
        },
        tacan = {
            channel = 32,
            morse = 'WZD',
        },
        modex = 605,
        callsign = {
            name = CALLSIGN.AWACS.Wizard,
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'anchor-awacs-red-1',
        baseUnit = 'Damascus',
        terminalType = AIRBASE.TerminalType.OpenBig,
        groupName = 'A50_template',
        airboss_recovery = false,
        escortgroupname = 'escort_F4',
        altitude = 34000,
        speed = 410,
        freq = 251,
        fuelwarninglevel=35,
        racetrack = {
            front = 50,
            back = 50
        },
        tacan = {
            channel = 100,
            morse = 'FCS',
        },
        modex = 058,
        callsign = {
            name = CALLSIGN.AWACS.Focus,
            number = 1
        }
    }
}


CoalitionSquadrons = {
    {
        enable = true,
        bordersgroup = 'tiberiasse_etendue',
        takeofftype = AI_A2A_DISPATCHER.Takeoff.Cold,
        landingtype = AI_A2A_DISPATCHER.Landing.AtEngineShutdown,
        detectionprefixarray = {'EWR RED'},
        AwacsTemplateName = 'A50_template',
        groupingrange = 30000,
        engageradius = 150000,
        abortradius = 300000,
        gciradius = 250000,
        fuelthreshold = 0.25,
        cappatrolpersquadron = 1,
        defaultpatrolgrouping = 2,
        debug = false,
        squadrons = {
            {
                enable = true,
                name = 'PalmyreF4',
                base = AIRBASE.Syria.Palmyra,
                templatearray = {'F4_template'},
                numberofsplanes = 18,
                availabilityrate = 0.6
            },
            {
                enable = true,
                name = 'PalmyreF4CAP',
                base = AIRBASE.Syria.Palmyra,
                templatearray = {'F4_template'},
                numberofsplanes = 6,
                availabilityrate = 0.6,
                capzonegroup = 'tiberiasse'
            },
            {
                enable = true,
                name = 'PalmyreA4',
                base = AIRBASE.Syria.Palmyra,
                templatearray = {'A4_template'},
                numberofsplanes = 8,
                availabilityrate = 0.6
            },
            {
                enable = true,
                name = 'PalmyreA4CAP',
                base = AIRBASE.Syria.Palmyra,
                templatearray = {'A4_template'},
                numberofsplanes = 4,
                availabilityrate = 0.6
            },
            {
                enable = true,
                name = 'Ramat_David_intercept',
                base = AIRBASE.Syria.Ramat_David,
                templatearray = {'F16_template'},
                takeofftype = AI_A2A_DISPATCHER.Takeoff.Runway,
                landingtype = AI_A2A_DISPATCHER.Landing.NearAirbase,
                numberofsplanes = 10,
                availabilityrate = 0.6
            },
            {
                enable = true,
                name = 'Ramat_David_cap',
                base = AIRBASE.Syria.Ramat_David,
                templatearray = {'F16_template'},
                takeofftype = AI_A2A_DISPATCHER.Takeoff.Runway,
                landingtype = AI_A2A_DISPATCHER.Landing.NearAirbase,
                numberofsplanes = 6,
                availabilityrate = 0.6,
                capzonegroup = 'tiberiasse'
            },
            {
                enable = true,
                name = 'Mezzeh',
                base = AIRBASE.Syria.Mezzeh,
                templatearray = {'F15_template'},
                takeofftype = AI_A2A_DISPATCHER.Takeoff.Runway,
                landingtype = AI_A2A_DISPATCHER.Landing.AtRunway,
                numberofsplanes = 6,
                availabilityrate = 0.6
            },
            {
                enable = true,
                name = 'Mezzeh_CAP',
                base = AIRBASE.Syria.Mezzeh,
                templatearray = {'F15_template'},
                takeofftype = AI_A2A_DISPATCHER.Takeoff.Runway,
                landingtype = AI_A2A_DISPATCHER.Landing.AtRunway,
                numberofsplanes = 2,
                availabilityrate = 0.6,
                capzonegroup = 'tiberiasse'
            }
        }
    }
}

MantisConfig = {
    {
        enable = true,
        debug = false,
        name = 'tiberiasse',
        coalition = 'red',
        EWRPrefix = 'EWR RED',
        SAMPrefix = 'SAM RED',
        dynamic = {
            enable = true,
            HQGroupName = 'HQ RED-1',
            AwacsTemplateName = 'A50_template',
            advanced = true,
            ratio = 80,
            autorelocate = {
                hq = true,
                ewr = true
            }
        },
        EWRGrouping = 5000,
        EWRRange = 400000,
        SAMRadius = 40000,
        SAMRange = 60,
        DetectInterval = 30
    }
}
