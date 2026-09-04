class TgDevice_Protection extends TgDevice
    native(ChampGauntlet)
    hidecategories(Navigation);

var TgPawn_Gauntlet m_Gauntlet;

// Export UTgDevice_Protection::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated event DeliverQueuedPendingHits()
{
    // End:0x1C
    if(PendingImpactList.Length != 0)
    {
        StartCooldown();
    }
    super.DeliverQueuedPendingHits();
    //return;    
}

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x5F
    if((Current != none) && Current.m_bHandDevice || Current.r_nDeviceId == 15794)
    {
        return false;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}
