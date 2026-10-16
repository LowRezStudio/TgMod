class TgDeviceFire_DimensionalLink extends TgDeviceFire
    native(ChampYing);

simulated function bool CanSimulateTeleportFire()
{
    return false;
    //return ReturnValue;    
}

// Export UTgDeviceFire_DimensionalLink::execTeleportFire(FFrame&, void* const)
native simulated function TeleportFire();
