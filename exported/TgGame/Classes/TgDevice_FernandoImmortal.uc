class TgDevice_FernandoImmortal extends TgDevice_ActiveAura
    hidecategories(Navigation);

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return IsInState('DeviceBuildup') || IsInState('DeviceFiring') && IsTimerActive('EndLockOutEarly') || (Current != none) && !Current.m_bHandDevice;
    //return ReturnValue;    
}

simulated event bool CanJumpWhileFiring()
{
    return false;
    //return ReturnValue;    
}

simulated function EndLockOutEarly()
{
    ClearTimer('EndLockOutEarly');
    LockInput(false);
    //return;    
}

simulated state DeviceFiring
{
    simulated function RestartFireLoop(bool bRefire)
    {
        local TgDeviceFire FireMode;
        local float fLockOutTime;

        super.RestartFireLoop(bRefire);
        // End:0xAB
        if(IsFiring())
        {
            FireMode = GetCurrentFire();
            fLockOutTime = ((FireMode != none) ? FireMode.GetCustomValue1() : 0.0000000);
            // End:0xA1
            if(fLockOutTime > 0.0000000)
            {
                SetTimer(fLockOutTime, false, 'EndLockOutEarly');                
            }
            else
            {
                EndLockOutEarly();
            }
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        ClearTimer('EndLockOutEarly');
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
}