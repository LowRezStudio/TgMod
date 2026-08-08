class TgDevice_QuadWield extends TgDevice_DualWield
    hidecategories(Navigation)
    config(Engine);

var () Vector m_vProjectileSpawnOffset3;
var () Vector m_vProjectileSpawnOffset4;
var int m_nWeaponFireNumber;

simulated event Vector GetProjectileSpawnOffset() { }

simulated function FireAmmunition() { }

defaultproperties
{
    m_vProjectileSpawnOffset3=(X=30.0000000,Y=20.0000000,Z=10.0000000)
    m_vProjectileSpawnOffset4=(X=30.0000000,Y=-20.0000000,Z=-10.0000000)
    m_vProjectileSpawnOffset2=(X=30.0000000,Y=-20.0000000,Z=10.0000000)
}
