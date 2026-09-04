class TgDevice_Somersault extends TgDevice
    native(ChampCassie)
    hidecategories(Navigation);

var TgDevice m_DodgeRollDevice;

simulated event bool StartFire()
{
    local TgTimerManager TimerManager;

    m_DodgeRollDevice = TgPawn(Owner).GetDeviceByEqPoint(4);
    TimerManager = m_DodgeRollDevice.GetCooldownTimerManager();
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
    m_DodgeRollDevice = TgPawn(Owner).GetDeviceByEqPoint(4);
    // End:0x7C
    if(m_DodgeRollDevice.m_bCooldownWasModified)
    {
        m_DodgeRollDevice.m_bCooldownWasModified = false;
        return true;        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}
