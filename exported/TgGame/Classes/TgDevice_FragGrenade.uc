class TgDevice_FragGrenade extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation);

var TgPawn_Viktor m_CachedViktor;
var bool m_bEndCook;
var bool m_bThrownGrenade;
var bool s_bCanPickUpNuggetRefills;
var bool s_bFullCook;

// Export UTgDevice_FragGrenade::execRequiresAmmoToFire(FFrame&, void* const)
native function bool RequiresAmmoToFire();

simulated function SetThrowSpeedMultiplier(float Mult)
{
    local TgRepInfo_Player PRI;
    local TgDeviceFire FireMode;

    // End:0xDD
    if(Instigator != none)
    {
        PRI = TgRepInfo_Player(Instigator.PlayerReplicationInfo);
        FireMode = GetCurrentFire();
        // End:0xDD
        if((PRI != none) && FireMode != none)
        {
            PRI.SetSimProjSpeed(FireMode.m_nId, FireMode.GetPropertyValue(46) * Mult);
        }
    }
    //return;    
}

simulated function DropGrenade()
{
    // End:0x28
    if(!m_bThrownGrenade)
    {
        SetThrowSpeedMultiplier(0.0500000);
        FireAmmunition();
    }
    //return;    
}

simulated function FireAmmunition()
{
    // End:0x19
    if(!m_bThrownGrenade)
    {
        super.FireAmmunition();
    }
    m_bThrownGrenade = true;
    //return;    
}

function CooldownTimerExpired(int nTimerId, TgTimerManager.TGT_EVENT eEvent, optional bool bNoBecomeActive)
{
    super.CooldownTimerExpired(nTimerId, eEvent, bNoBecomeActive);
    // End:0xC2
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0xC2
        if(s_bCanPickUpNuggetRefills && !IsDeviceCoolingDown())
        {
            // End:0xC2
            if(HasCachedViktor())
            {
                m_CachedViktor.SetProperty(31, float(Max(0, int(m_CachedViktor.GetPropCurrentValue(31) - 1.0000000))));
                s_bCanPickUpNuggetRefills = false;
            }
        }
    }
    //return;    
}

simulated function StartThrowValidation()
{
    s_bFullCook = true;
    //return;    
}

simulated function StartThrow()
{
    local float fPreHitDelay;

    // End:0x1F
    if(!m_bEndCook)
    {
        SetGrenadeCookTime(1.0000000, true);
    }
    m_bEndCook = true;
    ClearTimer('StartThrow');
    NotifyDeviceEvent(5);
    fPreHitDelay = GetFiringPreHitDelay();
    m_fFiringTimer = WorldInfo.TimeSeconds + (fPreHitDelay / CustomTimeDilation);
    m_fTimeStampAccountedFor = WorldInfo.TimeSeconds;
    m_fTimeAccountedFor = 0.0000000;
    SetTimer(fPreHitDelay, false, 'FirePreHitDelay');
    // End:0x183
    if(HasCachedViktor())
    {
        m_CachedViktor.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode));
        // End:0x183
        if(int(Role) < int(ROLE_Authority))
        {
            m_CachedViktor.c_EquipForm[int(r_eEquippedAt)].Generic1();
        }
    }
    //return;    
}

simulated function SetGrenadeCookTime(float fCookAmt, optional bool bSendToServer = false)
{
    local float fExplodeTime;

    // End:0x39
    if(int(Role) < int(ROLE_Authority))
    {
        // End:0x39
        if(bSendToServer)
        {
            ServerEndCook(fCookAmt);
        }
    }
    // End:0x127
    if(HasCachedViktor())
    {
        fExplodeTime = Lerp(GetCurrentFire().GetCustomValue2(), GetCurrentFire().GetCustomValue3(), FClamp(fCookAmt + 0.0010000, 0.0000000, 1.0000000));
        m_CachedViktor.r_fFragGrenadeExplodeTime = fExplodeTime;
        m_CachedViktor.r_bFragGrenadeExplodeOnTouch = fCookAmt >= 1.0000000;
        m_CachedViktor.bNetDirty = true;
    }
    //return;    
}

simulated function bool InterceptSlotReleased(TgPlayerController TgController)
{
    // End:0x84
    if((IsInState('DeviceBuildup') || IsTimerActive('StartThrow')) && !m_bEndCook)
    {
        m_bEndCook = true;
        // End:0x74
        if(IsTimerActive('StartThrow'))
        {
            SetAndSendGrenadeTimingsViaStartThrowTimer();
            StartThrow();            
        }
        else
        {
            SetGrenadeCookTime(0.0000000, true);
        }
    }
    return true;
    //return ReturnValue;    
}

simulated function SetAndSendGrenadeTimingsViaStartThrowTimer()
{
    local float fCookTimerRate, fCookTimerCount, fCookTime;

    fCookTimerRate = GetTimerRate('StartThrow');
    fCookTimerCount = GetTimerCount('StartThrow');
    // End:0x85
    if((fCookTimerRate > 0.0000000) && fCookTimerCount >= 0.0000000)
    {
        fCookTime = fCookTimerCount / fCookTimerRate;        
    }
    else
    {
        fCookTime = 1.0000000;
    }
    SetGrenadeCookTime(fCookTime, true);
    //return;    
}

reliable server function ServerEndCook(float fCookPct)
{
    local float fCookTimerRate, fCookTimerCount, fServerCookPct;

    m_bEndCook = true;
    fCookPct = FClamp(fCookPct, 0.0000000, 1.0000000);
    fCookTimerRate = GetTimerRate('StartThrowValidation');
    fCookTimerCount = GetTimerCount('StartThrowValidation');
    // End:0xBC
    if((fCookTimerRate > 0.0000000) && fCookTimerCount >= 0.0000000)
    {
        fServerCookPct = FClamp(fCookTimerCount / fCookTimerRate, 0.0000000, 1.0000000);        
    }
    else
    {
        // End:0xDB
        if(s_bFullCook)
        {
            fServerCookPct = 1.0000000;            
        }
        else
        {
            fServerCookPct = 0.0000000;
        }
    }
    // End:0x13F
    if(((fCookPct + 0.2000000) > fServerCookPct) && (fCookPct - 0.2000000) < fServerCookPct)
    {
        SetGrenadeCookTime(fCookPct);        
    }
    else
    {
        SetGrenadeCookTime(fServerCookPct);
    }
    ClearTimer('InterruptFiring');
    // End:0x1AB
    if(IsTimerActive('StartThrowValidation') || s_bFullCook)
    {
        ClearTimer('StartThrowValidation');
        StartThrow();
    }
    //return;    
}

simulated function bool HasCachedViktor()
{
    // End:0x38
    if(m_CachedViktor == none)
    {
        m_CachedViktor = TgPawn_Viktor(Instigator);
        return m_CachedViktor != none;
    }
    return true;
    //return ReturnValue;    
}

reliable server event InterruptFiring()
{
    // End:0x1A
    if(IsInState('DeviceFiring'))
    {
        DropGrenade();
    }
    super.InterruptFiring();
    m_bEndCook = false;
    //return;    
}

reliable client simulated event ClientInterrupt()
{
    // End:0x1A
    if(IsInState('DeviceFiring'))
    {
        DropGrenade();
    }
    super.ClientInterrupt();
    m_bEndCook = false;
    //return;    
}

simulated event bool CanBeInterrupted()
{
    return super.CanBeInterrupted() || IsInState('DeviceFiring');
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return !IsInState('DeviceBuildup') && super.CanBeCanceled();
    //return ReturnValue;    
}

simulated event bool ShouldCooldownAfterFire()
{
    return true;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function RestartFireLoop(bool bRefire)
    {
        super.RestartFireLoop(bRefire);
        SetThrowSpeedMultiplier(1.0000000);
        m_bThrownGrenade = false;
        s_bFullCook = false;
        // End:0x14F
        if(!m_bEndCook && Instigator.IsHumanControlled())
        {
            ClearTimer('FirePreHitDelay');
            // End:0xD6
            if(Instigator.IsLocallyControlled())
            {
                SetTimer(GetCurrentFire().GetCustomValue1(), false, 'StartThrow');                
            }
            else
            {
                SetTimer(GetCurrentFire().GetCustomValue1(), false, 'StartThrowValidation');
                SetTimer(FMax(GetCurrentFire().GetCustomValue1() * 2.0000000, 2.0000000), false, 'InterruptFiring');
            }
            NotifyDeviceEvent(4);            
        }
        else
        {
            // End:0x1E6
            if(HasCachedViktor())
            {
                m_CachedViktor.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode));
                // End:0x1E6
                if(int(Role) < int(ROLE_Authority))
                {
                    m_CachedViktor.c_EquipForm[int(r_eEquippedAt)].Generic1();
                }
            }
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        m_bEndCook = false;
        super.EndState(NextStateName);
        // End:0xB1
        if(int(Role) == int(ROLE_Authority))
        {
            // End:0xB1
            if(!s_bCanPickUpNuggetRefills && IsDeviceCoolingDown())
            {
                // End:0xB1
                if(HasCachedViktor())
                {
                    m_CachedViktor.SetProperty(31, m_CachedViktor.GetPropCurrentValue(31) + float(1));
                    s_bCanPickUpNuggetRefills = true;
                }
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Viktor.DeviceFragGrenade'
    m_nAimAssistPriorityWhileFiring=2
}