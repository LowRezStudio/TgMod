class TgPawn_Grohk extends TgPawn_Character
    native(ChampGrohk)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject, TgPawn);

const TGPAWN_GROHK_TEMPEST_OVERLY_FX_ID = 6870;

var Actor r_InhandTarget;
var Vector r_InhandHitOffset;
var bool c_bIsInTempest;
var float c_fTempestOverlayStrength;
var const float c_fTempestRampUpRate;
var const float c_fTempsetRampDownRate;

replication {
    if(bNetDirty) r_InhandHitOffset, r_InhandTarget;
}

native function MaterialInstanceConstant GetOverlayMaterial(TgPawn.OverlayMICType Type);  // Export UTgPawn_Grohk::execGetOverlayMaterial(FFrame&, void* const)

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated function OnDeviceFormStartFire(int nEquipSlot, float FireDuration, int nFireMode, optional int nAmmoRemaining) { }

simulated function OnDeviceFormStopFire(int nEquipSlot) { }

defaultproperties
{}
