class TgPawn_Buck extends TgPawn_Character
    native(ChampBuck)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

native function ModifyAccuracyForReticleBloom(out float fAccuracy);  // Export UTgPawn_Buck::execModifyAccuracyForReticleBloom(FFrame&, void* const)

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
