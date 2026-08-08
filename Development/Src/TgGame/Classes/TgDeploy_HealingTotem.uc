class TgDeploy_HealingTotem extends TgDeployable
    native(ChampGrohk)
    placeable
    hidecategories(Navigation)
    config(Engine);

var repnotify float r_fRadiusScale;
var repnotify bool r_bHasHealingRain;
var repnotify bool r_bHasWindTotem;
var repnotify float r_fMonolithReduction;
var TgPawn m_CachedPawnOwner;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bHasHealingRain, r_bHasWindTotem, r_fMonolithReduction, r_fRadiusScale;
}

native function AdjustHeal(const out ImpactInfo Impact, out float fHeal, int nPropertyId);  // Export UTgDeploy_HealingTotem::execAdjustHeal(FFrame&, void* const)

native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);  // Export UTgDeploy_HealingTotem::execMitigateHealthDamage(FFrame&, void* const)

native function ToggleHealingRainFX();  // Export UTgDeploy_HealingTotem::execToggleHealingRainFX(FFrame&, void* const)

native function ToggleWindTotemFX();  // Export UTgDeploy_HealingTotem::execToggleWindTotemFX(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

event ScaleAbilityRadius() { }

simulated event ScaleAbilityFX() { }

defaultproperties
{}
