class TgDevice_ShockPulse extends TgDevice
    native(ChampGrohk)
    hidecategories(Navigation);

// Export UTgDevice_ShockPulse::execIsReloading(FFrame&, void* const)
native function bool IsReloading();

defaultproperties
{
    m_vProjectileSpawnOffset=(X=0.0000000,Y=4.0000000,Z=-9.0000000)
}