class TgDevice_SecondWind extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var TgDevice_Hustle m_CachedHustleDevice;
var float m_fSprintEndTimestamp;

// Export UTgDevice_SecondWind::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated function CheckStartSprintBoost()
{
    // End:0x65
    if(IsActive())
    {
        m_fSprintEndTimestamp = WorldInfo.TimeSeconds + GetCurrentFire().GetCustomValue1();
        StartCooldown();
    }
    //return;    
}

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
        // End:0xA5
        case 14148:
            Dev.RegisterDelegate(2, CheckStartSprintBoost);
            m_CachedHustleDevice = TgDevice_Hustle(Dev);
            // End:0xA8
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
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
        // End:0x89
        case 14148:
            Dev.UnregisterDelegate(2, CheckStartSprintBoost);
            // End:0x8C
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=14148
}