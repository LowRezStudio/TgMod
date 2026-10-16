class TgDevice_OverGrowth extends TgDevice
    native(ChampGrover)
    hidecategories(Navigation);

var TgDevice m_VineDevice;

simulated event bool StartFire()
{
    local TgTimerManager TimerManager;

    m_VineDevice = TgPawn(Owner).GetDeviceByEqPoint(4);
    TimerManager = m_VineDevice.GetCooldownTimerManager();
    // End:0x8D
    if(TimerManager.IsActiveTimers())
    {
        return super.StartFire();        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}

simulated event bool ShouldCooldownAfterFire()
{
    m_VineDevice = TgPawn(Owner).GetDeviceByEqPoint(4);
    // End:0x7C
    if(m_VineDevice.m_bCooldownWasModified)
    {
        m_VineDevice.m_bCooldownWasModified = false;
        return true;        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}
