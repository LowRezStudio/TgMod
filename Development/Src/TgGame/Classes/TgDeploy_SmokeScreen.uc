class TgDeploy_SmokeScreen extends TgDeploy_EffectAura
    native(ChampSkye)
    placeable
    hidecategories(Navigation)
    config(Engine);

var TgPawn m_CachedPawnOwner;
var bool m_bHasAppliedOwnerStealth;
var repnotify float r_fRadiusForFX;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_fRadiusForFX;
}

native function ApplyEffects(Actor Target);  // Export UTgDeploy_SmokeScreen::execApplyEffects(FFrame&, void* const)

native function RemoveEffects(Actor Target);  // Export UTgDeploy_SmokeScreen::execRemoveEffects(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated event ScaleFX() { }

defaultproperties
{}
