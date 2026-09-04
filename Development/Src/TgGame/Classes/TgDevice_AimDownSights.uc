class TgDevice_AimDownSights extends TgDevice
    hidecategories(Navigation)
    config(Engine);

var repnotify bool r_bIsADS;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bIsADS;
}

simulated event ReplicatedEvent(name VarName) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function bool ShouldCancelStealth() { }

simulated function EndADS() { }

reliable server event InterruptFiring() { }

simulated function StopFire(byte FireModeNum) { }

reliable server function ServerStartFire(byte FireModeNum) { }
