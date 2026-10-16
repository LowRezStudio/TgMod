class TgDevice_BladesInhandAltFire extends TgDevice
    native(ChampBlades)
    hidecategories(Navigation)
    config(Engine);

simulated event bool ShouldLockFiring(TgDevice Current) { }

defaultproperties
{
    m_ReticuleType=RETICULE_Precise
    m_bAimThroughReticule=true
    m_vMeshViewOffset=(X=15.0000000,Y=0.0000000,Z=-4.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=10.0000000,Y=8.0000000,Z=-7.0000000)
}
