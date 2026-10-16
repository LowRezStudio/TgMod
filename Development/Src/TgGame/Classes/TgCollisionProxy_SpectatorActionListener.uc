class TgCollisionProxy_SpectatorActionListener extends TgCollisionProxy_Cylinder
    transient
    native
    notplaceable
    hidecategories(Navigation)
    config(Engine);

delegate ProxyDeviceOnStartFire(TgPawn FiringPawn, int nEquipSlot);

native function ForwardDeviceOnStartFire(TgPawn FiringPawn, int nEquipSlot);  // Export UTgCollisionProxy_SpectatorActionListener::execForwardDeviceOnStartFire(FFrame&, void* const)

native function bool HasMixedTaskforcePlayersNearby();  // Export UTgCollisionProxy_SpectatorActionListener::execHasMixedTaskforcePlayersNearby(FFrame&, void* const)

simulated event PostDemoRewind() { }

defaultproperties
{}
