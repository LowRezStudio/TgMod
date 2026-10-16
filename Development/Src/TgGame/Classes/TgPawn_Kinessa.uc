class TgPawn_Kinessa extends TgPawn_Character
    native(ChampKinessa)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject, TgPawn);

const TGPAWN_KINESSA_OVERLAY_FRIEND_FX_ID = 6861;

const TGPAWN_KINESSA_OVERLAY_ENEMY_FX_ID = 6862;

var float m_fPreviousPitchMin;
var float m_fPreviousPitchMax;
var repnotify Vector r_vHyperTargetEndLocation;
var repnotify Vector r_vHyperShotEndLocation;
var bool m_bPendingMovementPenaltyOnLanded;
var bool r_bIsZoomed;
var bool m_bIsInInhandPostFire;
var bool c_bHeadHunterFiring;
var bool r_bTeleportOverlayActive;
var float m_fScopedSpeedModifier;
var float m_fZoomChargeTimestamp;
var float r_fFullChargeDelay;
var float r_fTeleportOverlayMaxStrength;
var float c_fTeleportOverlayStrength;
var float r_fTeleportOverlayUpRate;
var float r_fTeleportOverlayDownRate;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bIsZoomed, r_bTeleportOverlayActive, r_fFullChargeDelay, r_fTeleportOverlayDownRate, r_fTeleportOverlayMaxStrength, r_fTeleportOverlayUpRate, r_vHyperShotEndLocation, r_vHyperTargetEndLocation;
}

native function MaterialInstanceConstant GetOverlayMaterial(TgPawn.OverlayMICType Type);  // Export UTgPawn_Kinessa::execGetOverlayMaterial(FFrame&, void* const)

native function PlayTeleportFx(int nTeleportState, Vector vLoc);  // Export UTgPawn_Kinessa::execPlayTeleportFx(FFrame&, void* const)

simulated function SetHyperTargetLocation(Vector beamEnd) { }

simulated function SetHyperShotLocation(Vector beamEnd) { }

simulated function ClearHyperShotLocations() { }

simulated event ReplicatedEvent(name VarName) { }

simulated function PlayHyperTargetEffects() { }

simulated function PlayHyperShotEffects() { }

simulated function SetZoomState(bool bIsZoomed, float fSpeedModifier, float fChargeDelay) { }

simulated event float GetZoomChargePercentage() { }

simulated function UpdateWeaponZoomEffects(optional float fZoomAmt=0.0000000) { }

simulated function OnDeviceFormStopFire(int nEquipSlot) { }

simulated function OnDeviceFormFire(int nEquipSlot, float fRefireTime, int nFireMode) { }

simulated function SetScopeChargeSound(bool IsActive) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated function bool ShouldUseScopeSensitivity() { }

defaultproperties
{}
