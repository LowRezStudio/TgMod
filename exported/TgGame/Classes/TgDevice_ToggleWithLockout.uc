class TgDevice_ToggleWithLockout extends TgDevice_Stim
    native(Devices)
    hidecategories(Navigation);

var TgPawn m_CachedTgP;
var float m_fCurrentTransitionPct;

// Export UTgDevice_ToggleWithLockout::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated function TgPawn GetCachedTgP()
{
    // End:0x1C
    if(m_CachedTgP != none)
    {
        return m_CachedTgP;        
    }
    else
    {
        m_CachedTgP = TgPawn(Instigator);
        return m_CachedTgP;
    }
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x67
    if(((Current != none) && Current.m_bHandDevice) && IsTimerActive('FirePreHitDelay') || IsTimerActive('FiringEndTransition'))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return IsFiring();
    //return ReturnValue;    
}

simulated event bool IsToggleDevice()
{
    return true;
    //return ReturnValue;    
}

simulated function FiringEndTransition()
{
    local TgPawn TgP;

    // End:0x2F
    if(c_DeviceForm != none)
    {
        c_DeviceForm.SetToggleState(false);
    }
    TgP = GetCachedTgP();
    // End:0x87
    if(TgP != none)
    {
        TgP.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode), true);
    }
    //return;    
}

simulated function SetTransitionPct()
{
    local float timerRate, timerCount;

    m_fCurrentTransitionPct = 1.0000000;
    timerRate = GetTimerRate('FirePreHitDelay');
    // End:0x94
    if(timerRate > float(0))
    {
        timerCount = GetTimerCount('FirePreHitDelay');
        m_fCurrentTransitionPct = ((GetFiringPreHitDelay()) - (timerRate - timerCount)) / (GetFiringPreHitDelay());
    }
    //return;    
}

reliable server event InterruptFiring()
{
    SetTransitionPct();
    super(TgDevice).InterruptFiring();
    //return;    
}

reliable client simulated event ClientInterrupt()
{
    SetTransitionPct();
    super(TgDevice).ClientInterrupt();
    //return;    
}

simulated function StopFire()
{
    SetTransitionPct();
    super(TgDevice).StopFire();
    //return;    
}

simulated function CompleteInterrupt()
{
    // End:0x33
    if((!CanBeCanceled() && !CanBeInterrupted()) || !IsFiring())
    {
        return;
    }
    // End:0x51
    if(int(Role) == int(ROLE_AutonomousProxy))
    {
        ClientInterrupt();
    }
    InterruptFiring();
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super(TgDevice).LinkedDeviceEquipped(Dev);
    switch(Dev.m_nDeviceType)
    {
        // End:0x88
        case 11077:
            Dev.RegisterDelegate(2, CompleteInterrupt);
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super(TgDevice).LinkedDeviceUnequipped(Dev);
    switch(Dev.m_nDeviceType)
    {
        // End:0x88
        case 11077:
            Dev.UnregisterDelegate(2, CompleteInterrupt);
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated function CustomFire()
{
    local AimData Aim;

    UpdateIndex();
    GetCachedAim(Aim);
    PlayClientFireFx(Aim.EndTrace, m_nSocketIndex, false, GetRefireTime());
    // End:0x8C
    if(int(Role) == int(ROLE_Authority))
    {
        GetCurrentFire().CustomFire();
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function RestartFireLoop(bool bRefire)
    {
        local TgPawn TgP;
        local float fModifiedPreHitDelay, fPreHitDelay;

        super.RestartFireLoop(bRefire);
        fPreHitDelay = GetFiringPreHitDelay();
        // End:0xE6
        if(IsTimerActive('FirePreHitDelay'))
        {
            fModifiedPreHitDelay = fPreHitDelay * (float(1) - m_fCurrentTransitionPct);
            // End:0xB2
            if(fModifiedPreHitDelay > float(0))
            {
                SetTimer(fPreHitDelay * (float(1) - m_fCurrentTransitionPct), false, 'FirePreHitDelay');
                ClearTimer('FiringEndTransition');                
            }
            else
            {
                ClearTimer('FirePreHitDelay');
                ClearTimer('FiringEndTransition');
                FirePreHitDelay();
                return;
            }
        }
        // End:0x127
        if(c_DeviceForm != none)
        {
            c_DeviceForm.PlayToggleTransitionAnimations(m_fCurrentTransitionPct, fPreHitDelay, true);
        }
        TgP = GetCachedTgP();
        // End:0x18F
        if(TgP != none)
        {
            TgP.FlashTransitionIn(r_nDeviceInstanceId, int(CurrentFireMode), m_fCurrentTransitionPct, fPreHitDelay);
        }
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        ClearTimer('FirePostHitDelay');
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPawn TgP;
        local float fPostHitDelay;

        SetTimer((GetFiringPostHitDelay()) * m_fCurrentTransitionPct, false, 'FiringEndTransition');
        ClearTimer('FirePreHitDelay');
        fPostHitDelay = GetFiringPostHitDelay();
        // End:0x8E
        if(c_DeviceForm != none)
        {
            c_DeviceForm.PlayToggleTransitionAnimations(m_fCurrentTransitionPct, fPostHitDelay, false);
        }
        TgP = GetCachedTgP();
        // End:0xF6
        if(TgP != none)
        {
            TgP.FlashTransitionOut(r_nDeviceInstanceId, int(CurrentFireMode), m_fCurrentTransitionPct, fPostHitDelay);
        }
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nLinkedDeviceTypes[0]=11077
}