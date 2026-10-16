class TgDevice_Roost extends TgDevice
    native(ChampOwl)
    hidecategories(Navigation);

var TgDevice m_ScopeDevice;

// Export UTgDevice_Roost::execGetStealthJuiceDiscount(FFrame&, void* const)
native function float GetStealthJuiceDiscount();

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceEquipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x69
        case 19111:
            m_ScopeDevice = Dev;
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
    super.LinkedDeviceUnequipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x61
        case 19111:
            m_ScopeDevice = none;
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=19111
}