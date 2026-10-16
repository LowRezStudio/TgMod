class TgDevice_SiegeUnit extends TgDevice
    native(ChampFlak)
    hidecategories(Navigation);

// Export UTgDevice_SiegeUnit::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

// Export UTgDevice_SiegeUnit::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldInterruptInhand()
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
    m_fBottomlessPitCheck=5000.0000000
    m_fDeployZOffset=25.0000000
}