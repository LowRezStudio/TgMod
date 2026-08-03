class TgDevice_WYRMJets extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var TgDevice m_CachedBoosterDevice;

// Export UTgDevice_WYRMJets::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

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
        case 13333:
            m_CachedBoosterDevice = Dev;
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    super.LinkedDeviceUnequipped(Dev);
    // End:0x35
    if(Dev == m_CachedBoosterDevice)
    {
        m_CachedBoosterDevice = none;
    }
    //return;    
}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=13333
}