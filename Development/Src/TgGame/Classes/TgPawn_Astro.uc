class TgPawn_Astro extends TgPawn_Character
    native(ChampAstro)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

const DEVICE_LIGHT_SPEED = 19186;

const DEVICE_GRAVITY_LIFT = 19187;

const DEVICE_ASTRAL_MARK = 17178;

const CARD_ASTRAL_CYCLE = 0;

const CARD_STAR_SEEKER = 1;

var TgDevice_Lightspeed m_LightSpeedDevice;
var TgDevice_AstroQ m_GravityLiftDevice;
var TgDevice_AstralMark m_AstralMarkDevice;
var TgDevice_AstralCycle m_AstralCycleCard;
var TgDevice_StarSeeker m_StarSeekerCard;
var TgPawn_Character m_AstralTarget;
var TgPawn_Character m_GravityLiftTarget;
var TgPawn_Character m_HitGravityLiftTarget;
var repnotify TgRepInfo_Player r_HitAstralTarget;
var repnotify TgRepInfo_Player r_RemoveAstralTarget;
var array<TgRepInfo_Player> m_AstralMarkTargets;
var float m_fDeadSpaceTimer;
var bool m_bDeadSpaceTimerActive;
var Rotator r_mUltimateAimRotation;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_HitAstralTarget, r_RemoveAstralTarget, r_mUltimateAimRotation;
}

simulated event ReplicatedEvent(name VarName) { }

native function bool HasDeviceCached(int DeviceID);  // Export UTgPawn_Astro::execHasDeviceCached(FFrame&, void* const)

native function bool AllowBoostedJump();  // Export UTgPawn_Astro::execAllowBoostedJump(FFrame&, void* const)

native function bool CanKnockbackAffectAC();  // Export UTgPawn_Astro::execCanKnockbackAffectAC(FFrame&, void* const)

native function GlobalOnPlayerDied(TgPawn_Character Player);  // Export UTgPawn_Astro::execGlobalOnPlayerDied(FFrame&, void* const)

native function OnPawnDied();  // Export UTgPawn_Astro::execOnPawnDied(FFrame&, void* const)

native function EffectGroupOnSetActive(bool bActive, bool bRemoving, TgEffectGroup EffectGroup);  // Export UTgPawn_Astro::execEffectGroupOnSetActive(FFrame&, void* const)

native function float GetGravityZ();  // Export UTgPawn_Astro::execGetGravityZ(FFrame&, void* const)

native function bool ShouldBeFirstPersonThisTick();  // Export UTgPawn_Astro::execShouldBeFirstPersonThisTick(FFrame&, void* const)

native function float GetAirControl();  // Export UTgPawn_Astro::execGetAirControl(FFrame&, void* const)

native function AddAstralMarkTarget();  // Export UTgPawn_Astro::execAddAstralMarkTarget(FFrame&, void* const)

native function RemoveAstralMarkTarget();  // Export UTgPawn_Astro::execRemoveAstralMarkTarget(FFrame&, void* const)

simulated function float GetJumpSpeedMultiplier() { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration) { }

defaultproperties
{}
