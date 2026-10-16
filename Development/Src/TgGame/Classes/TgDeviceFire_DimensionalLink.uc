class TgDeviceFire_DimensionalLink extends TgDeviceFire
    native(ChampYing)
    config(Engine);

simulated function bool CanSimulateTeleportFire() { }

native simulated function TeleportFire();  // Export UTgDeviceFire_DimensionalLink::execTeleportFire(FFrame&, void* const)
