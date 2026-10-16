class TgPawn_Skye extends TgPawn_Character
    native(ChampSkye)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

native function UpdateStealthBoltMaterial();  // Export UTgPawn_Skye::execUpdateStealthBoltMaterial(FFrame&, void* const)

native function float GetDamageToLeaveStealth();  // Export UTgPawn_Skye::execGetDamageToLeaveStealth(FFrame&, void* const)

simulated event ApplyStealthClient(optional bool bForce=false) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
