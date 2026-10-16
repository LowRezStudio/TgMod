class TgPawn_Barik extends TgPawn_Character
    native(ChampBarik)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

native function ModifyAccuracyForReticleBloom(out float fAccuracy);  // Export UTgPawn_Barik::execModifyAccuracyForReticleBloom(FFrame&, void* const)

simulated function float GetChargeTurnRate() { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
