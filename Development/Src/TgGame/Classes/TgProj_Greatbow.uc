class TgProj_Greatbow extends TgProj_Simulated
    native(ChampLongbow)
    hidecategories(Navigation)
    config(Engine);

native function ApplySpawnParams(float fProjectileSpeed, float fGravityScale);  // Export UTgProj_Greatbow::execApplySpawnParams(FFrame&, void* const)

defaultproperties
{}
