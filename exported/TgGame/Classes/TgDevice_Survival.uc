class TgDevice_Survival extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation);

var TgDevice m_ThrustDevice;

simulated event bool StartFire()
{
    local TgTimerManager TimerManager;

    m_ThrustDevice = TgPawn(Owner).GetDeviceByEqPoint(4);
    TimerManager = m_ThrustDevice.GetCooldownTimerManager();
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
    m_ThrustDevice = TgPawn(Owner).GetDeviceByEqPoint(4);
    // End:0x7C
    if(m_ThrustDevice.m_bCooldownWasModified)
    {
        m_ThrustDevice.m_bCooldownWasModified = false;
        return true;        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}
