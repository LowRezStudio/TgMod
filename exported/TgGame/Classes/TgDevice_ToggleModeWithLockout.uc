class TgDevice_ToggleModeWithLockout extends TgDevice_ToggleWithLockout
    native(Devices)
    hidecategories(Navigation);

var TgDevice m_CachedInhand;

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
        // End:0x6A
        case 10828:
            m_CachedInhand = Dev;
            // End:0x6D
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        // End:0x30
        if(m_CachedInhand != none)
        {
            m_CachedInhand.SetFireMode(1, true);
        }
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        // End:0x30
        if(m_CachedInhand != none)
        {
            m_CachedInhand.SetFireMode(0, true);
        }
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nLinkedDeviceTypes[0]=11077
    m_nLinkedDeviceTypes[1]=10828
}