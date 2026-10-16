class TgDevice_SnakeToss extends TgDevice
    native(ChampMalDamba)
    hidecategories(Navigation)
    config(Engine);

var int r_nAmmoCharge;
var TgDevice_MalDambaInhand m_CachedInhand;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_nAmmoCharge;
}

simulated event bool ShouldInterruptReloadOnFire() { }

simulated function UpdateAmmoCharge() { }

simulated function UseNow() { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

defaultproperties
{
    m_vProjectileSpawnOffset=(X=50.0000000,Y=12.0000000,Z=0.0000000)
    m_nLinkedDeviceTypes[0]=10828
}
