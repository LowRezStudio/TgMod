class TgDeploy_AbsorptionField extends TgDeploy_Shield
    native(ChampLazarus)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);  // Export UTgDeploy_AbsorptionField::execMitigateHealthDamage(FFrame&, void* const)

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

defaultproperties
{}
