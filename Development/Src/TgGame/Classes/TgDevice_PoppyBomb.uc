class TgDevice_PoppyBomb extends TgDevice
    native(ChampBombKing)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var bool r_bHasActiveProjectile;

replication {
    if(((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) && !bNetInitial) r_bHasActiveProjectile;
}

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_PoppyBomb::execCanDeviceFireNow(FFrame&, void* const)

simulated function UpdateActiveProjectiles(optional TgProjectile Proj) { }

simulated event bool ShouldCooldownAfterFire() { }

simulated event bool HasActivePoppyBomb() { }

simulated function DetonatePoppyBomb() { }

reliable server function ServerDetonatePoppyBomb() { }

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim) { }

simulated function PlayPoppyDetonateAnim() { }

simulated event bool Use() { }

state DeviceFiring {}
