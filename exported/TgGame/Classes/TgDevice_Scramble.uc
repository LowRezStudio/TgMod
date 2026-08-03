class TgDevice_Scramble extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var TgDevice_Hustle m_CachedHustleDevice;
var float m_fSprintEndTimestamp;

// Export UTgDevice_Scramble::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

reliable client simulated function ClientStartSpeedBoost()
{
    m_fSprintEndTimestamp = WorldInfo.TimeSeconds + GetCurrentFire().GetCustomValue1();
    //return;    
}

event CheckStartSprintBoost()
{
    // End:0xE0
    if(((((int(Role) == int(ROLE_Authority)) && IsActive()) && m_CachedHustleDevice != none) && m_CachedHustleDevice.NativeIsFiring()) && !m_CachedHustleDevice.IsTimerActive('FirePreHitDelay'))
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
        // End:0x73
        case 14148:
            m_CachedHustleDevice = TgDevice_Hustle(Dev);
            // End:0x76
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