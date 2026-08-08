class TgPawn_BarrierTank extends TgPawn_Character
    native(ChampBarrierTank)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

const IMPASSE_TOTAL_WALL_SEGMENTS = 5;

struct WallPlacementInfo {
    var bool bIsValidLocation;
    var Vector vSpawnLocation;
    structdefaultproperties {}
};

var WallPlacementInfo m_WallPlacementInfos[5];
var const Vector m_vSegmentExtent;
var const Vector m_vOpenSpotExtent;
var const float m_fWallTraceDownDistance;
var const float m_fWallOpenSpotTolerance;
var const float m_fInitialWallScaleZ;
var bool r_bInGaeBolg;
var bool m_bUseGaeBolgRetrieve;
var float m_fGaeBolgJumpZModifier;
var int r_nInhandAmmoRemaining;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && !bNetOwner || bDemoRecording) r_bInGaeBolg;
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_nInhandAmmoRemaining;
}

native function UpdateWallPlacementInfos(Vector OriginLocation, Rotator originRotation);  // Export UTgPawn_BarrierTank::execUpdateWallPlacementInfos(FFrame&, void* const)

function StartGaeBolg(float fJumpZMultiplier) { }

singular function EndGaeBolg() { }

simulated function float GetJumpSpeedMultiplier() { }

function bool DoJump(bool bUpdating) { }

simulated function OnStartTimelapseNewDeviceState() { }

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
