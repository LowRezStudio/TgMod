class TgProj_HealingPotion extends TgProj_FreeGrenade
    native(ChampPip)
    hidecategories(Navigation)
    config(Engine);

native function GetExplosionFXParams(out array<ParticleSysParam> Params);  // Export UTgProj_HealingPotion::execGetExplosionFXParams(FFrame&, void* const)

simulated function PlayAdditionalHitFX(bool bSuccessfulHit, Vector FXLocation, Vector HitNormal, Vector ProjDir, out array<ParticleSysParam> ExplosionParams) { }

defaultproperties
{}
