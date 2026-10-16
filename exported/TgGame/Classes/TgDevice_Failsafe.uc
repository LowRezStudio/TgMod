class TgDevice_Failsafe extends TgDevice
    native(ChampBarik)
    hidecategories(Navigation);

var TgDevice m_RocketBootsDevice;

simulated event bool StartFire()
{
    local TgTimerManager TimerManager;

    m_RocketBootsDevice = TgPawn(Owner).GetDeviceByEqPoint(4);
    TimerManager = m_RocketBootsDevice.GetCooldownTimerManager();
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
    m_RocketBootsDevice = TgPawn(Owner).GetDeviceByEqPoint(4);
    // End:0x7C
    if(m_RocketBootsDevice.m_bCooldownWasModified)
    {
        m_RocketBootsDevice.m_bCooldownWasModified = false;
        return true;        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}
