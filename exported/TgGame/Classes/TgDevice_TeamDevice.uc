class TgDevice_TeamDevice extends TgDevice
    native(Devices)
    hidecategories(Navigation);

// Export UTgDevice_TeamDevice::execGetCooldownTimerManager(FFrame&, void* const)
native function TgTimerManager GetCooldownTimerManager();

// Export UTgDevice_TeamDevice::execGetTaskForce(FFrame&, void* const)
native function TgRepInfo_TaskForce GetTaskForce();

// Export UTgDevice_TeamDevice::execCheckAndUpdateCooldown(FFrame&, void* const)
native function CheckAndUpdateCooldown();

function FlashCooldown(byte nMode)
{
    local TgPawn TgPawn;

    TgPawn = TgPawn(Instigator);
    // End:0x5E
    if(TgPawn != none)
    {
        TgPawn.FlashCooldown(r_nDeviceInstanceId, int(nMode));
    }
    //return;    
}

event ToggleCooldownEffects(bool bOnCooldown)
{
    // End:0xAF
    if((int(Role) == int(ROLE_Authority)) && int(r_eEquippedAt) == int(5))
    {
        // End:0xAF
        if((Instigator != none) && TgRepInfo_Player(Instigator.PlayerReplicationInfo) != none)
        {
            TgRepInfo_Player(Instigator.PlayerReplicationInfo).UpdateUltimateIsReady(GetCooldownRemaining());
        }
    }
    //return;    
}

function AuthStartCooldown(optional int nMode = -1, optional float fCooldownTimeOverride = -1.0000000)
{
    local TgTimerManager TimerManager;
    local float fCooldownTime;
    local TgPawn TgPawn;
    local int AbilityCooldownTimerIndex;

    // End:0x36
    if(nMode < 0)
    {
        nMode = int(CurrentFireMode);
    }
    AbilityCooldownTimerIndex = 0;
    // End:0x77
    if(int(Role) == int(ROLE_Authority))
    {
        AbilityCooldownTimerIndex = (nMode << 24) | r_nDeviceId;
    }
    // End:0x84
    if(LogDebugInfo())
    {
    }
    TgPawn = TgPawn(Instigator);
    // End:0xE6
    if(TgPawn != none)
    {
        // End:0xD3
        if(TgPawn.m_bCheatNoRecharge)
        {
            return;
        }
        TeamFlashCooldown(CurrentFireMode);
    }
    TimerManager = GetCooldownTimerManager();
    fCooldownTime = 0.0000000;
    // End:0x21A
    if(!TimerManager.IsSet(AbilityCooldownTimerIndex))
    {
        fCooldownTime = ((fCooldownTimeOverride >= float(0)) ? fCooldownTimeOverride : m_FireMode[int(CurrentFireMode)].GetCooldownTime());
        // End:0x1FE
        if(fCooldownTime > float(0))
        {
            TimerManager.RegisterForEvents(AbilityCooldownTimerIndex, self, 'TeamCooldownTimerExpired');
            TimerManager.Start(AbilityCooldownTimerIndex, fCooldownTime);
        }
        TeamCooldownStart(nMode, fCooldownTime);
    }
    // End:0x25C
    if(!TimerManager.IsSet(AbilityCooldownTimerIndex))
    {
        TeamCooldownTimerExpired(nMode, 0);
    }
    //return;    
}

event ResetCooldown(int nMode, optional float fCooldownTimeOverride = -1.0000000)
{
    local TgTimerManager TimerManager;
    local float fCooldownTime;
    local int AbilityCooldownTimerIndex;

    AbilityCooldownTimerIndex = 0;
    // End:0x4A
    if(int(Role) == int(ROLE_Authority))
    {
        AbilityCooldownTimerIndex = (nMode << 24) | r_nDeviceId;
    }
    // End:0x57
    if(LogDebugInfo())
    {
    }
    TimerManager = GetCooldownTimerManager();
    fCooldownTime = ((fCooldownTimeOverride >= 0.0000000) ? fCooldownTimeOverride : m_FireMode[int(CurrentFireMode)].GetCooldownTime());
    // End:0x157
    if(fCooldownTime > 0.0000000)
    {
        // End:0x121
        if(!TimerManager.IsSet(AbilityCooldownTimerIndex))
        {
            StartCooldown(int(CurrentFireMode), fCooldownTime);
            return;            
        }
        else
        {
            TimerManager.Update(AbilityCooldownTimerIndex, fCooldownTime);
        }        
    }
    else
    {
        // End:0x1C0
        if(TimerManager.IsSet(AbilityCooldownTimerIndex))
        {
            TimerManager.Close(AbilityCooldownTimerIndex, false);
            TeamCooldownTimerExpired(nMode, 0);
        }
    }
    TeamCooldownReset(nMode, fCooldownTime);
    //return;    
}

simulated event EndCooldown()
{
    local TgTimerManager TimerManager;
    local int AbilityCooldownTimerIndex;

    AbilityCooldownTimerIndex = 0;
    // End:0x32
    if(int(Role) == int(ROLE_Authority))
    {
        AbilityCooldownTimerIndex = r_nDeviceId;
    }
    TimerManager = GetCooldownTimerManager();
    // End:0xC0
    if((TimerManager != none) && TimerManager.IsSet(AbilityCooldownTimerIndex))
    {
        TimerManager.Close(AbilityCooldownTimerIndex, false);
        TeamCooldownTimerExpired(AbilityCooldownTimerIndex, 0);
    }
    TeamCooldownEnd();
    //return;    
}

function TeamCooldownTimerExpired(int nTimerId, TgTimerManager.TGT_EVENT eEvent)
{
    local TgRepInfo_Player PRI;
    local TgDevice theDevice;
    local TgRepInfo_TaskForce Taskforce;
    local int I;

    Taskforce = GetTaskForce();
    // End:0x59
    if((int(Role) < int(ROLE_Authority)) || Taskforce == none)
    {
        CooldownTimerExpired(nTimerId, eEvent);        
    }
    else
    {
        I = 0;
        J0x64:

        // End:0x18E [Loop If]
        if(I < Taskforce.GetPlayerCount())
        {
            PRI = Taskforce.GetPlayer(I);
            // End:0x180
            if((PRI != none) && PRI.r_PawnOwner != none)
            {
                theDevice = PRI.r_PawnOwner.GetDeviceById(r_nDeviceId);
                // End:0x180
                if(theDevice != none)
                {
                    theDevice.CooldownTimerExpired(nTimerId, eEvent);
                }
            }
            I++;
            // [Loop Continue]
            goto J0x64;
        }
    }
    //return;    
}

function TeamCooldownStart(int nMode, float fCooldownTime)
{
    local TgRepInfo_Player PRI;
    local TgDevice_TeamDevice theDevice;
    local TgRepInfo_TaskForce Taskforce;
    local int I;

    Taskforce = GetTaskForce();
    // End:0x65
    if((int(Role) < int(ROLE_Authority)) || Taskforce == none)
    {
        ToggleCooldownEffects(true);
        ClientStartCooldown(int(CurrentFireMode), fCooldownTime);        
    }
    else
    {
        I = 0;
        J0x70:

        // End:0x1C4 [Loop If]
        if(I < Taskforce.GetPlayerCount())
        {
            PRI = Taskforce.GetPlayer(I);
            // End:0x1B6
            if((PRI != none) && PRI.r_PawnOwner != none)
            {
                theDevice = TgDevice_TeamDevice(PRI.r_PawnOwner.GetDeviceById(r_nDeviceId));
                // End:0x1B6
                if(theDevice != none)
                {
                    theDevice.ToggleCooldownEffects(true);
                    theDevice.ClientStartCooldown(int(CurrentFireMode), fCooldownTime);
                }
            }
            I++;
            // [Loop Continue]
            goto J0x70;
        }
    }
    //return;    
}

function TeamCooldownReset(int nMode, float fCooldownTime)
{
    local TgRepInfo_Player PRI;
    local TgDevice theDevice;
    local TgRepInfo_TaskForce Taskforce;
    local int I;

    Taskforce = GetTaskForce();
    // End:0x5A
    if((int(Role) < int(ROLE_Authority)) || Taskforce == none)
    {
        ClientResetCooldown(int(CurrentFireMode), fCooldownTime);        
    }
    else
    {
        I = 0;
        J0x65:

        // End:0x190 [Loop If]
        if(I < Taskforce.GetPlayerCount())
        {
            PRI = Taskforce.GetPlayer(I);
            // End:0x182
            if((PRI != none) && PRI.r_PawnOwner != none)
            {
                theDevice = PRI.r_PawnOwner.GetDeviceById(r_nDeviceId);
                // End:0x182
                if(theDevice != none)
                {
                    theDevice.ClientResetCooldown(int(CurrentFireMode), fCooldownTime);
                }
            }
            I++;
            // [Loop Continue]
            goto J0x65;
        }
    }
    //return;    
}

function TeamCooldownEnd()
{
    local TgRepInfo_Player PRI;
    local TgDevice theDevice;
    local TgRepInfo_TaskForce Taskforce;
    local int I;

    Taskforce = GetTaskForce();
    // End:0x46
    if((int(Role) < int(ROLE_Authority)) || Taskforce == none)
    {
        ClientEndCooldown();        
    }
    else
    {
        I = 0;
        J0x51:

        // End:0x168 [Loop If]
        if(I < Taskforce.GetPlayerCount())
        {
            PRI = Taskforce.GetPlayer(I);
            // End:0x15A
            if((PRI != none) && PRI.r_PawnOwner != none)
            {
                theDevice = PRI.r_PawnOwner.GetDeviceById(r_nDeviceId);
                // End:0x15A
                if(theDevice != none)
                {
                    theDevice.ClientEndCooldown();
                }
            }
            I++;
            // [Loop Continue]
            goto J0x51;
        }
    }
    //return;    
}

function TeamGotoState(name NewState)
{
    local TgRepInfo_Player PRI;
    local TgDevice theDevice;
    local TgRepInfo_TaskForce Taskforce;
    local int I;

    Taskforce = GetTaskForce();
    // End:0x4A
    if((int(Role) < int(ROLE_Authority)) || Taskforce == none)
    {
        GotoState(NewState);        
    }
    else
    {
        I = 0;
        J0x55:

        // End:0x170 [Loop If]
        if(I < Taskforce.GetPlayerCount())
        {
            PRI = Taskforce.GetPlayer(I);
            // End:0x162
            if((PRI != none) && PRI.r_PawnOwner != none)
            {
                theDevice = PRI.r_PawnOwner.GetDeviceById(r_nDeviceId);
                // End:0x162
                if(theDevice != none)
                {
                    theDevice.GotoState(NewState);
                }
            }
            I++;
            // [Loop Continue]
            goto J0x55;
        }
    }
    //return;    
}

function TeamFlashCooldown(byte nMode)
{
    local TgRepInfo_Player PRI;
    local TgDevice_TeamDevice theDevice;
    local TgRepInfo_TaskForce Taskforce;
    local int I;

    Taskforce = GetTaskForce();
    // End:0x4F
    if((int(Role) < int(ROLE_Authority)) || Taskforce == none)
    {
        FlashCooldown(nMode);        
    }
    else
    {
        I = 0;
        J0x5A:

        // End:0x183 [Loop If]
        if(I < Taskforce.GetPlayerCount())
        {
            PRI = Taskforce.GetPlayer(I);
            // End:0x175
            if((PRI != none) && PRI.r_PawnOwner != none)
            {
                theDevice = TgDevice_TeamDevice(PRI.r_PawnOwner.GetDeviceById(r_nDeviceId));
                // End:0x175
                if(theDevice != none)
                {
                    theDevice.FlashCooldown(nMode);
                }
            }
            I++;
            // [Loop Continue]
            goto J0x5A;
        }
    }
    //return;    
}
