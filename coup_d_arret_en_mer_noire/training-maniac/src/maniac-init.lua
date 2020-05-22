--
-- A/G functions
--
function fctActivateSAM(param)
    local SAMName = param[1]
    local blnSilent = param[2] or false
    local intMessageTempo = param[3] or 45
    local grpSAM = GROUP:FindByName(SAMName)
    if grpSAM then
        grpSAM:SetAIOn()
        if not(blnSilent) then
            snd1020HzTone:ToCoalition( coalition.side.BLUE )
            MESSAGE:New(string.format("%s IA Activé !!!",SAMName),intMessageTempo,"WARNING",false):ToBlue()
        end
    end
end
function fctSuspendSAM(param)
    local SAMName = param[1]
    local blnSilent = param[2] or false
    local intMessageTempo = param[3] or 45
    local grpSAM = GROUP:FindByName(SAMName)
    if grpSAM then
        grpSAM:SetAIOff()
        if not(blnSilent) then
            snd1020HzTone:ToCoalition( coalition.side.BLUE )
            MESSAGE:New(string.format("%s IA Désactivée...",SAMName),intMessageTempo,"WARNING",false):ToBlue()
        end
    end
end

--
-- Sound Objects
--
do
    snd1020HzTone = USERSOUND:New( "1020Hz_DF_tone.wav" )
end

--
-- Menus
--
do
    menuVFA314 = MENU_COALITION:New(coalition.side.BLUE, "Simulation VFA-314")
    menuHQ7 = MENU_COALITION:New(coalition.side.BLUE, "HQ7s", menuVFA314 )
    menuVFA314_SA2_OFF = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "SA2-Off", menuVFA314,fctSuspendSAM,{"SA2-Karma"})
    menuVFA314_SA2_ON = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "SA2-On", menuVFA314,fctActivateSAM,{"SA2-Karma"})
    menuVFA314_SA8_OFF = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "SA8-Off", menuVFA314,fctSuspendSAM,{"SA8-Karma"})
    menuVFA314_SA8_ON = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "SA8-On", menuVFA314,fctActivateSAM,{"SA8-Karma"})
    menuVFA314_SA11_OFF = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "SA11-Off", menuVFA314,fctSuspendSAM,{"SA11-Karma"})
    menuVFA314_SA11_ON = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "SA11-On", menuVFA314,fctActivateSAM,{"SA11-Karma"})
    menuVFA314_HQ7_E_OFF = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "HQ7 East Off", menuHQ7,fctSuspendSAM,{"HQ7-Karma-East"})
    menuVFA314_HQ7_E_ON = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "HQ7 East On", menuHQ7,fctActivateSAM,{"HQ7-Karma-East"})
    menuVFA314_HQ7_W_OFF = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "HQ7 West Off", menuHQ7,fctSuspendSAM,{"HQ7-Karma-West"})
    menuVFA314_HQ7_W_ON = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "HQ7 West On", menuHQ7,fctActivateSAM,{"HQ7-Karma-West"})
    menuVFA314_HQ7_S_OFF = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "HQ7 South Off", menuHQ7,fctSuspendSAM,{"HQ7-Karma-South"})
    menuVFA314_HQ7_S_ON = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "HQ7 South On", menuHQ7,fctActivateSAM,{"HQ7-Karma-South"})
end