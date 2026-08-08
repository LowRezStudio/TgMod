class TgDeviceForm_AccursedArm extends TgDeviceForm
    native(ChampAndroxus)
    config(Engine);

var bool m_bShouldBeActive;
var float m_fActivationTime;
var float m_fCurrentActivationPercent;
var MaterialInterface m_cachedWeaponMaterial;
var MaterialInstanceConstant m_accursedArmMaterial;
var name m_nmUltimateActive;

native simulated function CacheAccursedArmMaterial();  // Export UTgDeviceForm_AccursedArm::execCacheAccursedArmMaterial(FFrame&, void* const)

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

defaultproperties
{
    m_fActivationTime=0.4000000
    m_nmUltimateActive="UltimateActive"
}
