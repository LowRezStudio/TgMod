class TgDevice_Enlightenment extends TgDevice
    native(ChampPrincess)
    hidecategories(Navigation);

var TgPawn_Princess m_CachedPrincess;

simulated function bool HasCachedPrincess()
{
    // End:0x2B
    if(m_CachedPrincess == none)
    {
        m_CachedPrincess = TgPawn_Princess(Instigator);
    }
    return m_CachedPrincess != none;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    // End:0x12
    if(IsInState('DeviceBuildup'))
    {
        return false;
    }
    // End:0x21
    if(IsFiring())
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x36
    if(IsFiring())
    {
        return Current.m_nDeviceType != 15052;        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}

simulated function StartTimeOut()
{
    local TgDeviceFire FireMode;
    local float fDuration;

    FireMode = GetCurrentFire();
    // End:0x7D
    if(FireMode != none)
    {
        fDuration = FireMode.GetCustomValue1();
        SetTimer(((fDuration > 0.0000000) ? fDuration : 2.0000000), false, 'TimeOut');
    }
    //return;    
}

simulated function TimeOut()
{
    local bool bEndFiring;

    bEndFiring = true;
    // End:0xD6
    if((HasCachedPrincess()) && m_CachedPrincess.HasCachedEnlightenmentGun())
    {
        // End:0xD6
        if(m_CachedPrincess.m_CachedEnlightenmentGun.m_bAutoFireAfterPostHitDelay)
        {
            // End:0xD6
            if(m_CachedPrincess.HasCachedEnlightenmentGun())
            {
                bEndFiring = false;
                m_CachedPrincess.m_CachedEnlightenmentGun.Use();
            }
        }
    }
    // End:0xF6
    if(bEndFiring)
    {
        SetTimer(0.1000000, false, 'FirePostHitDelay');
    }
    //return;    
}

simulated function StartWaitForResultOfFireTimer()
{
    local float fPostFireDelay;
    local TgDeviceFire enlightenmentFireMode;

    // End:0xEA
    if((HasCachedPrincess()) && m_CachedPrincess.HasCachedEnlightenmentGun())
    {
        // End:0xEA
        if(m_CachedPrincess.HasCachedEnlightenmentGun())
        {
            enlightenmentFireMode = m_CachedPrincess.m_CachedEnlightenmentGun.GetCurrentFire();
            // End:0xEA
            if(enlightenmentFireMode != none)
            {
                fPostFireDelay = enlightenmentFireMode.GetPreHitDelay() + enlightenmentFireMode.GetPostHitDelay();
            }
        }
    }
    SetTimer(((fPostFireDelay > 0.0000000) ? fPostFireDelay : 0.1000000), false, 'WaitForResultOfFire');
    //return;    
}

simulated function WaitForResultOfFire()
{
    local float fTimeout;
    local TgDeviceFire enlightenmentFireMode;
    local bool bEndFiring;
    local int nAmmoCount;

    bEndFiring = true;
    // End:0x1AB
    if(HasCachedPrincess())
    {
        // End:0x1AB
        if(m_CachedPrincess.HasCachedEnlightenmentGun())
        {
            nAmmoCount = m_CachedPrincess.m_CachedEnlightenmentGun.GetCurrentAmmoAmount();
            // End:0xD7
            if(nAmmoCount > 0)
            {
                m_CachedPrincess.m_CachedEnlightenmentGun.m_bAutoFireAfterPostHitDelay = true;
                StartTimeOut();
                bEndFiring = false;                
            }
            else
            {
                enlightenmentFireMode = m_CachedPrincess.m_CachedEnlightenmentGun.GetCurrentFire();
                // End:0x16E
                if(enlightenmentFireMode != none)
                {
                    fTimeout = enlightenmentFireMode.GetPreHitDelay() + enlightenmentFireMode.GetPostHitDelay();
                }
                SetTimer(((fTimeout > 0.0000000) ? fTimeout : 0.1000000), false, 'FirePostHitDelay');
                bEndFiring = false;
            }
        }
    }
    // End:0x1CB
    if(bEndFiring)
    {
        SetTimer(0.1000000, false, 'FirePostHitDelay');
    }
    //return;    
}

simulated state DeviceBuildup
{
    simulated function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        ClearTimer('TimeOut');
        //return;        
    }
    stop;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        // End:0x2D
        if(HasCachedPrincess())
        {
            m_CachedPrincess.ToggleEnlightenmentGun(true);
        }
        StartTimeOut();
        super.StartFiringLogic();
        //return;        
    }

    simulated function FirePostHitDelay()
    {
        super.FirePostHitDelay();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        // End:0x2D
        if(HasCachedPrincess())
        {
            m_CachedPrincess.ToggleEnlightenmentGun(false);
        }
        super.StopFiringLogic();
        //return;        
    }
    stop;    
}
