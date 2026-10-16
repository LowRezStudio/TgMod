class TgDevice_DualWield extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

var () Vector m_vProjectileSpawnOffset2;
var bool m_bFireLeftWeapon;

simulated event Vector GetProjectileSpawnOffset() { }

simulated function FireAmmunition() { }

simulated function SetLeftFire(bool bLeftFire) { }

defaultproperties
{
    m_vProjectileSpawnOffset2=(X=30.0000000,Y=-20.0000000,Z=-10.0000000)
    m_bAimThroughReticule=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fMeshFOV=45.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=20.0000000,Z=-10.0000000)
}
