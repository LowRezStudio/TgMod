class TgDevice_OracleInhand extends TgDevice_ToggleInhand
    native(ChampOracle)
    hidecategories(Navigation)
    config(Engine);

simulated event DeliverHit(ImpactInfo Impact) { }

defaultproperties
{
    m_AltFireType=ALTFIRE_AlternateDevice
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=10.0000000,Y=2.0000000,Z=-2.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=90.0000000
    m_vProjectileSpawnOffset=(X=25.0000000,Y=12.0000000,Z=-6.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_OracleInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'LightForceFeedback'
}
