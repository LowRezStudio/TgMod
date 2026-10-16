class TgDeploy_WardersField extends TgDeploy_EffectField
    native(ChampBarrierTank)
    placeable
    hidecategories(Navigation)
    config(Engine);

var repnotify float r_fRadiusForFX;
var repnotify float r_fRadiusScaleForDecal;
var repnotify bool r_bEarthenGuardActive;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bEarthenGuardActive, r_fRadiusForFX, r_fRadiusScaleForDecal;
}

simulated event ReplicatedEvent(name VarName) { }

simulated event ScaleAbilityFX() { }

defaultproperties
{}
