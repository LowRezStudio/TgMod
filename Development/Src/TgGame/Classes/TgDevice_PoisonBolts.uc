class TgDevice_PoisonBolts extends TgDevice
    native(ChampSkye)
    hidecategories(Navigation)
    config(Engine);

var TgDevice_SkyeInhand m_CachedInhand;

native function bool CanReload(optional bool bIsAutoReload=false);  // Export UTgDevice_PoisonBolts::execCanReload(FFrame&, void* const)

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

defaultproperties
{
    m_ReticuleType=RETICULE_Precise
    m_bAimThroughReticule=true
    m_bUsesBurstFire=true
    m_vMeshViewOffset=(X=15.0000000,Y=0.0000000,Z=-4.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=10.0000000,Y=8.0000000,Z=-7.0000000)
    m_nBurstTotalShots=3
}
