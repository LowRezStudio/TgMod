class TgPawn_Flak extends TgPawn_Character
    native(ChampFlak)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var TgDevice_KineticBurst m_CachedKineticBurstDevice;
var TgDevice_SiegeUnit m_CachedSiegeUnitDevice;
var TgDevice_AssertDominance m_CachedUltimateDevice;
var TgDevice_ShoulderBash m_CachedShoulderBashDevice;
var TgSpecialFx m_WepIdleSound;
var float m_PreviousZHeight;
var float m_GravityMultiplier;
var bool m_bUseShoulderBashRetrieve;
var bool m_bUseShoulderBashZoom;

native function StartZTracking();  // Export UTgPawn_Flak::execStartZTracking(FFrame&, void* const)

native function MaxOutGravity();  // Export UTgPawn_Flak::execMaxOutGravity(FFrame&, void* const)

native function float GetGravityZ();  // Export UTgPawn_Flak::execGetGravityZ(FFrame&, void* const)

native function SpawnFlagDeployable();  // Export UTgPawn_Flak::execSpawnFlagDeployable(FFrame&, void* const)

native function ResetGravTimers();  // Export UTgPawn_Flak::execResetGravTimers(FFrame&, void* const)

native function DeployableOnDestroyed(TgDeployable dep);  // Export UTgPawn_Flak::execDeployableOnDestroyed(FFrame&, void* const)

native function bool HasCachedKineticBurstDevice();  // Export UTgPawn_Flak::execHasCachedKineticBurstDevice(FFrame&, void* const)

function RampUpTimer() { }

function RampDownTimer() { }

simulated function OnRespawn() { }

simulated function OnLiveRespawn() { }

simulated function ResetInhandFiremode() { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration) { }

defaultproperties
{}
