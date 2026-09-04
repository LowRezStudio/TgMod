class TgDevice_RepulsorField extends TgDevice_ActiveAura
    native(ChampRuckus)
    hidecategories(Navigation)
    config(Engine);

var float r_fAtTheReadyRadius;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fAtTheReadyRadius;
}

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function bool ShouldInterruptReloadOnFire() { }
