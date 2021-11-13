-- *****************************************************************************
-- *                         AIRBOSS settings                                  *
-- *****************************************************************************
AirBossConfig = {
    {
        enable = true,
        carriername = 'CVW-7-1',
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
            offset = 20,
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
                templatename = 'RAT-civil-1',
                spawns = 1,
                flightlevel = 260,
                inactive_timer = 300,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = true,
                airbases_names = {
                    departure = {
                        AIRBASE.PersianGulf.Fujairah_Intl
                    },
                    arrival = {
                        AIRBASE.PersianGulf.Bandar_Abbas_Intl
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
                        AIRBASE.PersianGulf.Al_Ain_International_Airport
                    },
                    arrival = {
                        AIRBASE.PersianGulf.Shiraz_International_Airport
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
                        AIRBASE.PersianGulf.Abu_Dhabi_International_Airport
                    },
                    arrival = {
                        'zone-RAT-Paris'
                    }
                }
            },
            {
                templatename = 'RAT-civil-4',
                spawns = 1,
                flightlevel = 380,
                inactive_timer = 1200,
                allow_immortal = false,
                allow_invisible = true,
                atcmessage_enable = false,
                airbases_names = {
                    departure = {
                        AIRBASE.PersianGulf.Shiraz_International_Airport
                    },
                    arrival = {
                        'zone-RAT-Sydney'
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
        patternUnit = 'CVW-7-6',
        baseUnit = 'CVW-7-1',
        terminalType = AIRBASE.TerminalType.OpenMedOrBig,
        groupName = 'shell-1',
        airboss_recovery = true,
        escortgroupname = 'escort-2',
        altitude = 12500,
        speed = 270,
        tacan = {
            channel = 14,
            morse = 'SHL',
        },
        freq = 276.200,
        fuelwarninglevel = 15,
        racetrack = {
            front = 40,
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
        patternUnit = 'anchor-texaco-1',
        baseUnit = AIRBASE.PersianGulf.Al_Dhafra_AB,
        terminalType = AIRBASE.TerminalType.OpenBig,
        groupName = 'texaco-1',
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
            front = 40,
            back = 0
        },
        modex = 345,
        callsign = {
            name = CALLSIGN.Tanker.Texaco,
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'anchor-arco-1',
        baseUnit = AIRBASE.PersianGulf.Al_Dhafra_AB,
        terminalType = AIRBASE.TerminalType.OpenBig,
        groupName = 'arco-1',
        airboss_recovery = false,
        escortgroupname = 'escort-1',
        altitude = 24000,
        speed = 430,
        tacan = {
            channel = 16,
            morse = 'ARC',
        },
        freq = 360.200,
        fuelwarninglevel = 20,
        racetrack = {
            front = 40,
            back = 10
        },
        modex = 347,
        callsign = {
            name = CALLSIGN.Tanker.Arco,
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'anchor-iranian-texaco-1',
        baseUnit = AIRBASE.PersianGulf.Kerman_Airport,
        terminalType = AIRBASE.TerminalType.OpenBig,
        groupName = 'KC135MPRS_template',
        airboss_recovery = false,
        escortgroupname = 'escort_F14',
        altitude = 28000,
        speed = 430,
        tacan = {
            channel = 101,
            morse = 'TEX',
        },
        freq = 129.250,
        fuelwarninglevel = 20,
        racetrack = {
            front = 60,
            back = 0
        },
        modex = 345,
        callsign = {
            name = CALLSIGN.Tanker.Texaco,
            number = 2
        }
    }
}

PedrosConfig = {
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'CVW-7-1',
        baseUnit = 'CVW-7-5',
        groupName = 'Pedro-1',
        freq = 127.5,
        modex = 704
    }
}



AwacsConfig = {
    {
        enable = true,
        autorespawn = true,
        patternUnit = 'CVW-7-5',
        baseUnit = 'CVW-7-1',
        terminalType = AIRBASE.TerminalType.OpenMedOrBig,
        groupName = 'wizzard-1',
        airboss_recovery = true,
        escortgroupname = 'escort-4',
        altitude = 24000,
        speed = 380,
        freq = 261,
        fuelwarninglevel=25,
        racetrack = {
            front = 10,
            back = 10
        },
        tacan = {
            channel = 17,
            morse = 'WZD',
        },
        modex = 611,
        callsign = {
            name = CALLSIGN.AWACS.Wizard,
            number = 1
        }
    },
    {
        enable = false,
        autorespawn = true,
        patternUnit = 'anchor-overlord-1',
        baseUnit = AIRBASE.PersianGulf.Al_Dhafra_AB,
        terminalType = AIRBASE.TerminalType.OpenBig,
        groupName = 'overlord-1',
        airboss_recovery = false,
        escortgroupname = 'escort-1',
        altitude = 34500,
        speed = 430,
        freq = 265.800,
        fuelwarninglevel=25,
        racetrack = {
            front = 80,
            back = -10
        },
        tacan = {
            channel = 18,
            morse = 'OVL',
        },
        modex = 705,
        callsign = {
            name = CALLSIGN.AWACS.Overlord,
            number = 1
        }
    },
    {
        enable = true,
        autorespawn = false,
        patternUnit = 'anchor-iranian-awacs-1',
        baseUnit = AIRBASE.PersianGulf.Kerman_Airport,
        terminalType = AIRBASE.TerminalType.OpenBig,
        groupName = 'A50_template',
        airboss_recovery = false,
        escortgroupname = 'escort_F14',
        altitude = 34500,
        speed = 430,
        freq = 125,
        fuelwarninglevel=25,
        racetrack = {
            front = 90,
            back = 0
        },
        tacan = {
            channel = 100,
            morse = 'DKS',
        },
        modex = 705,
        callsign = {
            name = CALLSIGN.AWACS.Darkstar,
            number = 2
        }
    }
}


CoalitionSquadrons = {
    {
        enable = true,
        bordersgroup = 'Iran',
        takeofftype = AI_A2A_DISPATCHER.Takeoff.Cold,
        landingtype = AI_A2A_DISPATCHER.Landing.AtEngineShutdown,
        detectionprefixarray = {'EWR_IRAN'},
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
                name = 'KermanF14CAP',
                base = AIRBASE.PersianGulf.Kerman_Airport,
                templatearray = {'F14_template'},
                numberofsplanes = 4,
                availabilityrate = 0.4,
                capzone = 'CAPKerman'
            },
            {
                enable = true,
                name = 'KermanF14Intercept',
                base = AIRBASE.PersianGulf.Kerman_Airport,
                templatearray = {'F14_template'},
                numberofsplanes = 4,
                availabilityrate = 0.4
            },
            {
                enable = true,
                name = 'LarF14CAP',
                base = AIRBASE.PersianGulf.Lar_Airbase,
                templatearray = {'F14_template'},
                numberofsplanes = 4,
                availabilityrate = 0.4,
                capzone = 'CAPLar'
            },
            {
                enable = true,
                name = 'LarF14Intercept',
                base = AIRBASE.PersianGulf.Lar_Airbase,
                templatearray = {'F14_template'},
                numberofsplanes = 4,
                availabilityrate = 0.4
            },
            {
                enable = true,
                name = 'BandarEJaskF14Intercept',
                base = AIRBASE.PersianGulf.Bandar_e_Jask_airfield,
                templatearray = {'F14_template'},
                numberofsplanes = 4,
                availabilityrate = 0.4
            },
            {
                enable = true,
                name = 'HavadariaF14Inteercept',
                base = AIRBASE.PersianGulf.Havadarya,
                templatearray = {'F14_template'},
                numberofsplanes = 4,
                availabilityrate = 0.4
            },
            {
                enable = true,
                name = 'HavadariaF4CAP',
                base = AIRBASE.PersianGulf.Havadarya,
                templatearray = {'F4_template'},
                numberofsplanes = 12,
                availabilityrate = 0.35,
                capzone = 'CAPAvadaria'
            },
            {
                enable = true,
                name = 'JiroftF4CAP',
                base = AIRBASE.PersianGulf.Jiroft_Airport,
                templatearray = {'F4_template'},
                takeofftype = AI_A2A_DISPATCHER.Takeoff.Runway,
                landingtype = AI_A2A_DISPATCHER.Landing.AtRunway,
                numberofsplanes = 12,
                availabilityrate = 0.35,
                capzone = 'CAPJiroft'
            },
            {
                enable = true,
                name = 'LarF4CAP',
                base = AIRBASE.PersianGulf.Lar_Airbase,
                templatearray = {'F4_template'},
                numberofsplanes = 12,
                availabilityrate = 0.35,
                capzone = 'CAPShiraz'
            },
            {
                enable = true,
                name = 'LavanF4Intercept',
                base = AIRBASE.PersianGulf.Lavan_Island_Airport,
                templatearray = {'F4_template'},
                numberofsplanes = 12,
                availabilityrate = 0.35
            },
            {
                enable = true,
                name = 'BandarAbbasF4Intercept',
                base = AIRBASE.PersianGulf.Bandar_Abbas_Intl,
                templatearray = {'F4_template'},
                numberofsplanes = 12,
                availabilityrate = 0.35
            },
            {
                enable = true,
                name = 'BandarLengehF4Intercept',
                base = AIRBASE.PersianGulf.Bandar_Lengeh,
                templatearray = {'F4_template'},
                numberofsplanes = 10,
                availabilityrate = 0.35
            },
            {
                enable = true,
                name = 'BandarLengehF5Intercept',
                base = AIRBASE.PersianGulf.Bandar_Lengeh,
                templatearray = {'F5_template'},
                numberofsplanes = 10,
                availabilityrate = 0.4
            },
            {
                enable = true,
                name = 'SirriF5CAP',
                base = AIRBASE.PersianGulf.Sirri_Island,
                templatearray = {'F5_template'},
                numberofsplanes = 10,
                availabilityrate = 0.4
            },
            {
                enable = true,
                name = 'KermanMig29Intercept',
                base = AIRBASE.PersianGulf.Kerman_Airport,
                templatearray = {'Mig29_template'},
                numberofsplanes = 6,
                availabilityrate = 0.6
            },
            {
                enable = true,
                name = 'KermanMig29CAP',
                base = AIRBASE.PersianGulf.Kerman_Airport,
                templatearray = {'Mig29_template'},
                numberofsplanes = 6,
                availabilityrate = 0.6,
                capzone = 'CAPKerman'
            },
            {
                enable = true,
                name = 'JiroftMig29Intercept',
                base = AIRBASE.PersianGulf.Jiroft_Airport,
                templatearray = {'Mig29_template'},
                landingtype = AI_A2A_DISPATCHER.Landing.AtRunway,
                numberofsplanes = 4,
                availabilityrate = 0.6
            },
            {
                enable = true,
                name = 'JiroftMig29CAP',
                base = AIRBASE.PersianGulf.Jiroft_Airport,
                templatearray = {'Mig29_template'},
                takeofftype = AI_A2A_DISPATCHER.Takeoff.Runway,
                landingtype = AI_A2A_DISPATCHER.Landing.AtRunway,
                numberofsplanes = 4,
                availabilityrate = 0.6,
                capzone = 'CAPBandarEJask'
            }
        }
    },
    {
        enable = true,
        bordersgroup = 'UAE',
        takeofftype = AI_A2A_DISPATCHER.Takeoff.Cold,
        landingtype = AI_A2A_DISPATCHER.Landing.AtEngineShutdown,
        detectionprefixarray = {'EWR_UAE'},
        AwacsTemplateName = 'overlord-1',
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
                name = 'AlMinhadCAP1',
                base = AIRBASE.PersianGulf.Al_Minhad_AB,
                templatearray = {'M2K_template-1'},
                numberofsplanes = 6,
                availabilityrate = 0.6,
                capzone = 'CAPKhaimah'
            },
            {
                enable = true,
                name = 'AlMinhadCAP2',
                base = AIRBASE.PersianGulf.Al_Minhad_AB,
                templatearray = {'M2K_template-1'},
                numberofsplanes = 6,
                availabilityrate = 0.6,
                capzone = 'CAPFujairah'
            },
            {
                enable = true,
                name = 'AlMinhadCAP3',
                base = AIRBASE.PersianGulf.Al_Minhad_AB,
                templatearray = {'F16_template-1'},
                numberofsplanes = 12,
                availabilityrate = 0.7,
                capzone = 'CAPMinhad'
            },
            {
                enable = true,
                name = 'AlDhafraCAP',
                base = AIRBASE.PersianGulf.Al_Dhafra_AB,
                templatearray = {'F16_template-1', 'M2K_template-1'},
                numberofsplanes = 24,
                availabilityrate = 0.65,
                capzone = 'CAPDhafra'
            },
            {
                enable = true,
                name = 'AlDhafraIntercept',
                base = AIRBASE.PersianGulf.Al_Dhafra_AB,
                templatearray = {'M2K_template-1'},
                numberofsplanes = 12,
                availabilityrate = 0.6
            },
            {
                enable = true,
                name = 'AlMinhadIntercept',
                base = AIRBASE.PersianGulf.Al_Minhad_AB,
                templatearray = {'M2K_template-1'},
                numberofsplanes = 12,
                availabilityrate = 0.6
            }
        }
    },
    {
        enable = true,
        bordersgroup = 'oman',
        takeofftype = AI_A2A_DISPATCHER.Takeoff.Cold,
        landingtype = AI_A2A_DISPATCHER.Landing.AtEngineShutdown,
        detectionprefixarray = {'EWR_OMAN'},
        AwacsTemplateName = '',
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
                name = 'KhasabCAP',
                base = AIRBASE.PersianGulf.Khasab,
                templatearray = {'M2K_template-2'},
                numberofsplanes = 12,
                availabilityrate = 0.6,
                capzonegroup = 'oman'
            },
            {
                enable = true,
                name = 'KhasabIntercept',
                base = AIRBASE.PersianGulf.Khasab,
                templatearray = {'M2K_template-2'},
                numberofsplanes = 6,
                availabilityrate = 0.8
            }
        }
    }
}

IADSConfig = {
    {
        enable = true,
        debug = false,
        name = 'defense_EST',
        EWRPrefix = 'EWR_IRAN_EST',
        SAMPrefix = 'SAM_IRAN_EST',
        CommandCenterGroup = 'HQ_IRAN_EST-1',
        coalition = coalition.side.RED,
        interconnectionsconfig = {
            EWR = {
                {
                    unitname = 'EWR_IRAN_EST-2-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-1',
                    pointdefensegroupname = 'SAM_IRAN_EST_POINTDEF-2'
                },
                {
                    unitname = 'EWR_IRAN_EST-3-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-8',
                    pointdefensegroupname = 'SAM_IRAN_EST_POINTDEF-5'
                },
                {
                    unitname = 'EWR_IRAN_EST-1-1',
                    communicationstatic = 'IADSComm-2',
                    powerstatic = 'IADSGPU-6',
                    pointdefensegroupname = 'SAM_IRAN_EST_POINTDEF-1'
                }
            },
            SAM = {
                {
                    groupname = 'SAM_IRAN_EST_SA2-3',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-2',
                    pointdefensegroupname = 'SAM_IRAN_EST_POINTDEF-3',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_EST_SA6-1',
                    communicationstatic = 'IADSComm-1',
                    powerstatic = 'IADSGPU-3',
                    pointdefensegroupname = 'SAM_IRAN_EST_POINTDEF-4',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_EST_SA11-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-4',
                    pointdefensegroupname = '',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_EST_SA10-1',
                    communicationstatic = 'IADSComm-2',
                    powerstatic = 'IADSGPU-5',
                    pointdefensegroupname = '',
                    isew = true
                },
                {
                    groupname = 'SAM_IRAN_EST_MOBILE-1',
                    communicationstatic = 'IADSComm-2',
                    powerstatic = '',
                    pointdefensegroupname = '',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_EST_MOBILE-2',
                    communicationstatic = 'IADSComm-2',
                    powerstatic = '',
                    pointdefensegroupname = '',
                    isew = false
                }
            },
            HQ = {
                {
                    groupname = 'HQ_IRAN_EST-1',
                    communicationstatic = {
                        'IADSComm-1',
                        'IADSComm-2',
                    },
                    powerstatic = 'IADSGPU-1',
                    pointdefensegroupname = ''
                }
            }
        },
        AwacsTemplateName = 'A50_template',
        SAMRange = 85,
        HARMDetectionChance = 50,
        DetectInterval = 0
    },
    {
        enable = true,
        debug = false,
        name = 'defense_NORD',
        EWRPrefix = 'EWR_IRAN_NORD',
        SAMPrefix = 'SAM_IRAN_NORD',
        CommandCenterGroup = 'HQ_IRAN_NORD-1',
        coalition = coalition.side.RED,
        interconnectionsconfig = {
            EWR = {
                {
                    unitname = 'EWR_IRAN_NORD-1-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-7',
                    pointdefensegroupname = 'SAM_IRAN_NORD_POINTDEF-1'
                },
                {
                    unitname = 'EWR_IRAN_NORD-2-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-9',
                    pointdefensegroupname = 'SAM_IRAN_NORD_POINTDEF-2'
                }
            },
            SAM = {
                {
                    groupname = 'SAM_IRAN_NORD_SA2-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-10',
                    pointdefensegroupname = 'SAM_IRAN_NORD_POINTDEF-3',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_NORD_SA10-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-11',
                    pointdefensegroupname = 'SAM_IRAN_NORD_POINTDEF-4',
                    isew = true
                },
                {
                    groupname = 'SAM_IRAN_NORD_MOBILE-1',
                    communicationstatic = '',
                    powerstatic = '',
                    pointdefensegroupname = '',
                    isew = false
                }
            },
            HQ = {
                {
                    groupname = 'HQ_IRAN_NORD-1',
                    communicationstatic = {
                        'IADSComm-3'
                    },
                    powerstatic = '',
                    pointdefensegroupname = ''
                }
            }
        },
        AwacsTemplateName = 'A50_template',
        SAMRange = 85,
        HARMDetectionChance = 60,
        DetectInterval = 0
    },
    {
        enable = true,
        debug = false,
        name = 'defense_OUEST',
        EWRPrefix = 'EWR_IRAN_OUEST',
        SAMPrefix = 'SAM_IRAN_OUEST',
        CommandCenterGroup = 'HQ_IRAN_OUEST-1',
        coalition = coalition.side.RED,
        interconnectionsconfig = {
            EWR = {
                {
                    unitname = 'EWR_IRAN_OUEST-1-1',
                    communicationstatic = 'IADSComm-4',
                    powerstatic = 'IADSGPU-13',
                    pointdefensegroupname = 'SAM_IRAN_OUEST_POINTDEF-1'
                },
                {
                    unitname = 'EWR_IRAN_OUEST-2-1',
                    communicationstatic = 'IADSComm-5',
                    powerstatic = 'IADSGPU-14',
                    pointdefensegroupname = 'SAM_IRAN_OUEST_POINTDEF-2'
                },
                {
                    unitname = 'EWR_IRAN_OUEST-3-1',
                    communicationstatic = 'IADSComm-6',
                    powerstatic = 'IADSGPU-12',
                    pointdefensegroupname = ''
                },
                {
                    unitname = 'EWR_IRAN_OUEST-4-1',
                    communicationstatic = 'IADSComm-7',
                    powerstatic = 'IADSGPU-15',
                    pointdefensegroupname = 'SAM_IRAN_OUEST_POINTDEF-3'
                }
            },
            SAM = {
                {
                    groupname = 'SAM_IRAN_OUEST_HAWK-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-18',
                    pointdefensegroupname = 'SAM_IRAN_OUEST_POINTDEF-4',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_OUEST_HAWK-2',
                    communicationstatic = 'IADSComm-9',
                    powerstatic = 'IADSGPU-19',
                    pointdefensegroupname = 'SAM_IRAN_OUEST_POINTDEF-5',
                    isew = true
                },
                {
                    groupname = 'SAM_IRAN_OUEST_MOBILE-1',
                    communicationstatic = '',
                    powerstatic = '',
                    pointdefensegroupname = '',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_OUEST_MOBILE-2',
                    communicationstatic = 'IADSComm-8',
                    powerstatic = '',
                    pointdefensegroupname = '',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_OUEST_SA10-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-20',
                    pointdefensegroupname = '',
                    isew = true
                },
                {
                    groupname = 'SAM_IRAN_OUEST_SA2-1',
                    communicationstatic = 'IADSComm-10',
                    powerstatic = 'IADSGPU-16',
                    pointdefensegroupname = 'SAM_IRAN_OUEST_POINTDEF-6',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_OUEST_SA2-2',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-17',
                    pointdefensegroupname = '',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_OUEST_SA6-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-21',
                    pointdefensegroupname = 'SAM_IRAN_OUEST_POINTDEF-7',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_OUEST_SA6-2',
                    communicationstatic = 'IADSComm-7',
                    powerstatic = 'IADSGPU-36',
                    pointdefensegroupname = 'SAM_IRAN_OUEST_POINTDEF-8',
                    isew = false
                }
            },
            HQ = {
                {
                    groupname = 'HQ_IRAN_OUEST-1',
                    communicationstatic = {
                        'IADSComm-8'
                    },
                    powerstatic = '',
                    pointdefensegroupname = ''
                }
            }
        },
        AwacsTemplateName = 'A50_template',
        SAMRange = 75,
        HARMDetectionChance = 40,
        DetectInterval = 0
    },
    {
        enable = true,
        debug = false,
        name = 'defense_SUD',
        EWRPrefix = 'EWR_IRAN_SUD',
        SAMPrefix = 'SAM_IRAN_SUD',
        CommandCenterGroup = 'HQ_IRAN_SUD-1',
        coalition = coalition.side.RED,
        interconnectionsconfig = {
            EWR = {
                {
                    unitname = 'EWR_IRAN_SUD-1-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-22',
                    pointdefensegroupname = 'SAM_IRAN_SUD_POINTDEF-2'
                },
                {
                    unitname = 'EWR_IRAN_SUD-2-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-23',
                    pointdefensegroupname = ''
                },
                {
                    unitname = 'EWR_IRAN_SUD-3-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-26',
                    pointdefensegroupname = 'SAM_IRAN_SUD_POINTDEF-5'
                }
            },
            SAM = {
                {
                    groupname = 'SAM_IRAN_SUD_MOBILE-2',
                    communicationstatic = 'IADSComm-12',
                    powerstatic = '',
                    pointdefensegroupname = '',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_SUD_SA2-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-25',
                    pointdefensegroupname = 'SAM_IRAN_SUD_POINTDEF-3',
                    isew = false
                },
                {
                    groupname = 'SAM_IRAN_SUD_SA6-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-24',
                    pointdefensegroupname = 'SAM_IRAN_SUD_POINTDEF-4',
                    isew = false
                }
            },
            HQ = {
                {
                    groupname = 'HQ_IRAN_SUD-1',
                    communicationstatic = {
                        'IADSComm-11'
                    },
                    powerstatic = '',
                    pointdefensegroupname = 'SAM_IRAN_SUD_POINTDEF-1'
                }
            }
        },
        AwacsTemplateName = 'A50_template',
        SAMRange = 75,
        HARMDetectionChance = 45,
        DetectInterval = 0
    },
    {
        enable = true,
        debug = false,
        name = 'defense_UAE',
        EWRPrefix = 'EWR_UAE',
        SAMPrefix = 'SAM_UAE',
        CommandCenterGroup = 'HQ_UAE-1',
        coalition = coalition.side.BLUE,
        interconnectionsconfig = {
            EWR = {
                {
                    unitname = 'EWR_UAE-1-1',
                    communicationstatic = 'IADSComm-14',
                    powerstatic = 'IADSGPU-27',
                    pointdefensegroupname = 'SAM_UAE_POINTDEF-1'
                },
                {
                    unitname = 'EWR_UAE-2-1',
                    communicationstatic = 'IADSComm-13',
                    powerstatic = 'IADSGPU-28',
                    pointdefensegroupname = 'SAM_UAE_POINTDEF-2'
                },
                {
                    unitname = 'EWR_UAE-3-1',
                    communicationstatic = '',
                    powerstatic = 'IADSGPU-29',
                    pointdefensegroupname = ''
                },
                {
                    unitname = 'EWR_UAE-4-1',
                    communicationstatic = 'IADSComm-15',
                    powerstatic = 'IADSGPU-30',
                    pointdefensegroupname = 'SAM_UAE_POINTDEF-3'
                },
            },
            SAM = {
                {
                    groupname = 'SAM_UAE-Patriot-1',
                    communicationstatic = 'IADSComm-16',
                    powerstatic = '',
                    pointdefensegroupname = 'SAM_UAE_POINTDEF-5',
                    isew = true
                },
                {
                    groupname = 'SAM_UAE-Patriot-2',
                    communicationstatic = 'IADSComm-17',
                    powerstatic = '',
                    pointdefensegroupname = 'SAM_UAE_POINTDEF-6',
                    isew = true
                },
                {
                    groupname = 'SAM_UAE_Hawk-1',
                    communicationstatic = 'IADSComm-14',
                    powerstatic = 'IADSGPU-33',
                    pointdefensegroupname = 'SAM_UAE_POINTDEF-7',
                    isew = false
                },
                {
                    groupname = 'SAM_UAE_Hawk-2',
                    communicationstatic = 'IADSComm-13',
                    powerstatic = 'IADSGPU-34',
                    pointdefensegroupname = 'SAM_UAE_POINTDEF-9',
                    isew = false
                },
                {
                    groupname = 'SAM_UAE_Hawk-3',
                    communicationstatic = 'IADSComm-18',
                    powerstatic = 'IADSGPU-32',
                    pointdefensegroupname = 'SAM_UAE_POINTDEF-8',
                    isew = true
                },
                {
                    groupname = 'SAM_UAE_MOBILE-1',
                    communicationstatic = 'IADSComm-15',
                    powerstatic = '',
                    pointdefensegroupname = '',
                    isew = false
                },
                {
                    groupname = 'SAM_UAE_MOBILE-2',
                    communicationstatic = 'IADSComm-15',
                    powerstatic = '',
                    pointdefensegroupname = '',
                    isew = false
                },
                {
                    groupname = 'SAM_UAE_MOBILE-3',
                    communicationstatic = 'IADSComm-17',
                    powerstatic = '',
                    pointdefensegroupname = '',
                    isew = false
                }
            },
            HQ = {
                {
                    groupname = 'HQ_UAE-1',
                    communicationstatic = {
                        'IADSComm-16'
                    },
                    powerstatic = 'IADSGPU-31',
                    pointdefensegroupname = 'SAM_UAE_POINTDEF-4'
                }
            }
        },
        AwacsTemplateName = 'overlord-1',
        SAMRange = 75,
        HARMDetectionChance = 45,
        DetectInterval = 0
    },
    {
        enable = true,
        debug = false,
        name = 'defense_OMAN',
        EWRPrefix = 'EWR_OMAN',
        SAMPrefix = 'SAM_OMAN',
        CommandCenterGroup = 'HQ_OMAN-1',
        coalition = coalition.side.BLUE,
        interconnectionsconfig = {
            EWR = {
                {
                    unitname = 'EWR_OMAN-1-1',
                    communicationstatic = 'IADSComm-19',
                    powerstatic = 'IADSGPU-35',
                    pointdefensegroupname = 'SAM_OMAN_MOBILE-3'
                }
            },
            SAM = {
                {
                    groupname = 'SAM_OMAN_MOBILE-1',
                    communicationstatic = 'IADSComm-21',
                    powerstatic = '',
                    pointdefensegroupname = '',
                    isew = false
                },
                {
                    groupname = 'SAM_OMAN_MOBILE-2',
                    communicationstatic = 'IADSComm-21',
                    powerstatic = '',
                    pointdefensegroupname = '',
                    isew = false
                }
            },
            HQ = {
                {
                    groupname = 'HQ_OMAN-1',
                    communicationstatic = {
                        'IADSComm-20'
                    },
                    powerstatic = '',
                    pointdefensegroupname = 'SAM_OMAN_POINTDEF-1'
                }
            }
        },
        AwacsTemplateName = '',
        SAMRange = 75,
        HARMDetectionChance = 45,
        DetectInterval = 0
    }
}
