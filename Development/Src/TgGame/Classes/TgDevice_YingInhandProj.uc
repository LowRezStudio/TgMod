class TgDevice_YingInhandProj extends TgDevice
    native(ChampYing)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function bool CanReload(optional bool bIsAutoReload=false);  // Export UTgDevice_YingInhandProj::execCanReload(FFrame&, void* const)

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

simulated event bool ShouldCooldownAfterFire() { }

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim) { }

simulated function float GetEstimatedTotalBurstTime(int nShotsRemaining) { }

defaultproperties
{
    m_AltFireType=ALTFIRE_AlternateDevice
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_bUsesBurstFire=true
    m_bOnlyFirstBurstCostsAmmo=true
    m_bDoNotAllowHeadShots=true
    m_vMeshViewOffset=(X=10.0000000,Y=2.0000000,Z=-2.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=55.0000000,Y=10.0000000,Z=-15.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_nBurstTotalShots=3
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_YingInhandProj'
}
