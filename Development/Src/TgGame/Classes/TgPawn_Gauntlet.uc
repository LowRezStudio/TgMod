class TgPawn_Gauntlet extends TgPawn_Character
    native(ChampGauntlet)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject, TgPawn);

var Actor r_InhandTarget;
var Vector r_InhandHitOffset;
var Vector c_InterpInhandHitOffset;
var float c_fInhandHitOffsetInterpSpeed;
var Actor r_RechargeTarget;
var Vector r_RechargeHitOffset;
var Vector c_InterpRechargeHitOffset;
var TgPawn_Character c_ProtectionTarget;

replication {
    if(bNetDirty) r_InhandHitOffset, r_InhandTarget, r_RechargeHitOffset, r_RechargeTarget;
}

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated function Tick(float DeltaSeconds) { }

native function bool Is1PBodyOverlay(TgPawn.OverlayMICType Type);  // Export UTgPawn_Gauntlet::execIs1PBodyOverlay(FFrame&, void* const)

defaultproperties
{}
