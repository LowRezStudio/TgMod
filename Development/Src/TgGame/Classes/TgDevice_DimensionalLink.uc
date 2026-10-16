class TgDevice_DimensionalLink extends TgDevice
    native(ChampYing)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

struct DLTeleportTargets {
    var Vector TargetPosition;
    var Rotator TargetRotation;
    var Actor TargetIllusion;
    structdefaultproperties {}
};

struct DLDeadTeleportTargets {
    var Vector TargetPosition;
    var Rotator TargetRotation;
    var float ValidTimeRemaining;
    structdefaultproperties {}
};

struct DLRewindTargets {
    var Vector RewindPosition;
    var Rotator RewindRotation;
    structdefaultproperties {}
};

var TgPawn_Ying m_CachedYingPawn;
var Actor s_CycleTargets[10];
var int s_nNumCycleTargets;
var int s_nCurrentCycleTargetIndex;
var array<DLTeleportTargets> m_TeleportTargets;
var array<DLDeadTeleportTargets> m_DeadTeleportTargets;
var DLRewindTargets m_RewindTargets[30];
var int m_CurrentRewindIndex;
var int m_ValidRewindIndex1;
var int m_ValidRewindIndex2;
var int m_nNumPrevRewindsToCheck;
var float m_fRewindMinTargetDist;
var float m_fRewindMinNextPointDist;
var float m_fLastRewindTimestamp;
var bool m_bRequiresReset;
var bool m_bSwappingPeriodEnded;
var Actor r_nCurrentCycleTarget;
var TgDevice_Rewind m_CachedCardRewind;

replication {
    if(bNetDirty && int(Role) == int(ENetRole.ROLE_Authority)) r_nCurrentCycleTarget;
}

native function AimData ValidateReceivedAim(float ClientMovementTimeStamp, AimData Aim);  // Export UTgDevice_DimensionalLink::execValidateReceivedAim(FFrame&, void* const)

native function TickTargetingMode(float DeltaSeconds);  // Export UTgDevice_DimensionalLink::execTickTargetingMode(FFrame&, void* const)

native function bool IsTargetingModeReady(optional out TgObject.EDeviceFailType failType);  // Export UTgDevice_DimensionalLink::execIsTargetingModeReady(FFrame&, void* const)

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_DimensionalLink::execGetTargetingAim(FFrame&, void* const)

native function bool UsesCachedAim();  // Export UTgDevice_DimensionalLink::execUsesCachedAim(FFrame&, void* const)

native function bool HasCachedYingPawn();  // Export UTgDevice_DimensionalLink::execHasCachedYingPawn(FFrame&, void* const)

native function Actor CreateTeleportTargetDeployable(Vector TargetLocation, Rotator TargetRotation);  // Export UTgDevice_DimensionalLink::execCreateTeleportTargetDeployable(FFrame&, void* const)

native function GenerateCycleTargets();  // Export UTgDevice_DimensionalLink::execGenerateCycleTargets(FFrame&, void* const)

simulated function FireAmmunition() { }

simulated event bool ShouldCooldownAfterFire() { }

delegate PawnEvent(TgPawn DeadPawn);

function IllusionDied(Actor illusion) { }

simulated function EndSwappingPeriod() { }

simulated function IsFullyReset() { }

function SetRequiresReset() { }

reliable client simulated function ClientSetRequiresReset() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

state DeviceFiring {}

defaultproperties
{
    m_nNumPrevRewindsToCheck=10
    m_fRewindMinTargetDist=313600.0000000
    m_fRewindMinNextPointDist=6400.0000000
    m_fLastRewindTimestamp=-100.0000000
    m_bRequiresReset=true
    m_bSwappingPeriodEnded=true
    m_bDisableLagCompensation=true
    m_nLinkedDeviceIDs[0]=13414
    m_nLinkedDeviceIDs[1]=14041
    m_nLinkedDeviceIDs[2]=14042
    m_nLinkedDeviceIDs[3]=14043
}
