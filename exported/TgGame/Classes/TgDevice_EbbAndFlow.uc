class TgDevice_EbbAndFlow extends TgDevice
    native(ChampMakoa)
    hidecategories(Navigation);

var TgDevice m_ShellSpinDevice;

simulated event bool StartFire()
{
    local TgTimerManager TimerManager;

    m_ShellSpinDevice = TgPawn(Owner).GetDeviceByEqPoint(4);
    TimerManager = m_ShellSpinDevice.GetCooldownTimerManager();
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
    m_ShellSpinDevice = TgPawn(Owner).GetDeviceByEqPoint(4);
    // End:0x7F
    if(m_ShellSpinDevice.m_bCooldownWasModified == true)
    {
        m_ShellSpinDevice.m_bCooldownWasModified = false;
        return true;        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}
