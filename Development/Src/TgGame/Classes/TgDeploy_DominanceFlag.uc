class TgDeploy_DominanceFlag extends TgDeploy_EffectField
    native(ChampFlak)
    placeable
    hidecategories(Navigation)
    config(Engine);

var repnotify float r_fRadiusForFX;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fRadiusForFX;
}

simulated event ReplicatedEvent(name VarName) { }

simulated event ScaleAbilityFX() { }

defaultproperties
{}
