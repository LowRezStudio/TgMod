class TgDevice_InPursuit extends TgDevice
    native(ChampLex)
    hidecategories(Navigation);

var bool m_bRecalculateTarget;
var TgPawn_Character m_CurrentMark;
var Actor m_PursuitTarget;
var TgDevice_LexInhand m_CachedInhand;

// Export UTgDevice_InPursuit::execShouldBlockReload(FFrame&, void* const)
native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);

simulated event bool CanBeCanceled()
{
    local float fFirePostHitTime, fPostHitCancelSafetyPeriod;
    local TgDeviceFire FireMode;

    // End:0x12
    if(IsInState('DeviceBuildup'))
    {
        return false;
    }
    // End:0x2B
    if(IsTimerActive('FirePreHitDelay'))
    {
        return false;
    }
    // End:0xFF
    if(IsTimerActive('FirePostHitDelay'))
    {
        fFirePostHitTime = GetTimerCount('FirePostHitDelay');
        fPostHitCancelSafetyPeriod = 0.5000000;
        FireMode = GetCurrentFire();
        // End:0xE6
        if(FireMode != none)
        {
            fPostHitCancelSafetyPeriod -= FireMode.GetBuildupTime();
            fPostHitCancelSafetyPeriod -= FireMode.GetPreHitDelay();
        }
        // End:0xFF
        if(fFirePostHitTime < fPostHitCancelSafetyPeriod)
        {
            return false;
        }
    }
    return true;
    //return ReturnValue;    
}

simulated function TruePostFire()
{
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceEquipped(Dev);
    switch(Dev.m_nDeviceType)
    {
        // End:0x73
        case 10828:
            m_CachedInhand = TgDevice_LexInhand(Dev);
            // End:0x76
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x95
    if((IsFiring()) && Current != none)
    {
        // End:0x70
        if(Current.r_nDeviceId == 16530)
        {
            return IsInState('DeviceBuildup') || IsTimerActive('TruePostFire');            
        }
        else
        {
            // End:0x95
            if(Current.IsA('TgDevice_CombatSlide'))
            {
                return false;
            }
        }
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        // End:0x70
        if(m_CachedInhand != none)
        {
            m_CachedInhand.AsynchronusInterrupt();
            m_CachedInhand.SetFireMode(1, true);
            m_CachedInhand.m_bShouldAutoFire = true;
        }
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        // End:0x70
        if(m_CachedInhand != none)
        {
            m_CachedInhand.AsynchronusInterrupt();
            m_CachedInhand.SetFireMode(0, true);
            m_CachedInhand.m_bShouldAutoFire = false;
        }
        SetTimer(GetCurrentFire().GetCustomValue1() - ((HasRemoteOwner()) ? 0.1000000 : 0.0000000), false, 'TruePostFire');
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bRecalculateTarget=true
    m_nLinkedDeviceTypes[0]=10828
}