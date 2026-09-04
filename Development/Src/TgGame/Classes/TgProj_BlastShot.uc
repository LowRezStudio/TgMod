class TgProj_BlastShot extends TgProj_Simulated
    native(ChampCassie)
    hidecategories(Navigation)
    config(Engine);

native function GetExplosionFXParams(out array<ParticleSysParam> Params);  // Export UTgProj_BlastShot::execGetExplosionFXParams(FFrame&, void* const)

defaultproperties
{}
