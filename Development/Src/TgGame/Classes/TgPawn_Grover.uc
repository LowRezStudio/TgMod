class TgPawn_Grover extends TgPawn_Character
    native(ChampGrover)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var TgDevice_Vine m_CachedVine;

native function bool HasCachedVine();  // Export UTgPawn_Grover::execHasCachedVine(FFrame&, void* const)

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
