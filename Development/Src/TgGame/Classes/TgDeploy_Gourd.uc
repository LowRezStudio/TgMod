class TgDeploy_Gourd extends TgDeploy_EffectField
    native(ChampMalDamba)
    placeable
    hidecategories(Navigation)
    config(Engine);

var repnotify bool r_bHasRipenedGourd;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bHasRipenedGourd;
}

native function ToggleRipenedGourdFX();  // Export UTgDeploy_Gourd::execToggleRipenedGourdFX(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

function OnProxyUnTouch(Actor Other) { }

defaultproperties
{}
