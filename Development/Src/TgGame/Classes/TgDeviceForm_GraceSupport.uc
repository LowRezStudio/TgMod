class TgDeviceForm_GraceSupport extends TgDeviceForm
    config(Engine)
    dependson(TgObject);

var TgWeaponMeshActor_LianInhand m_CachedWMA;

function bool HasCachedWMA() { }

simulated event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

simulated event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo) { }
