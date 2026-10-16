class TgRepInfo_CapturePoint extends ReplicationInfo
    native(Game)
    nativereplication
    hidecategories(Navigation,Movement,Collision)
    config(Engine);

var TgCapturePoint r_OwningCapturePoint;
var int r_nUniqueCapturePointId;
var repnotify int r_nControlledByTaskForce;
var repnotify float r_fOwnershipPct;
var repnotify byte r_nTransitionDirection;
var repnotify bool r_bIsLocked;
var transient TgSeqEvent_ControlPointOwnershipPercent c_OwnershipPercentKismetNode;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_OwningCapturePoint, r_bIsLocked, r_fOwnershipPct, r_nControlledByTaskForce, r_nTransitionDirection, r_nUniqueCapturePointId;
}

native function Vector GetCurrentLocation();  // Export UTgRepInfo_CapturePoint::execGetCurrentLocation(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated event PostBeginPlay() { }

simulated function OnTaskForceControlChanged() { }

simulated event OnOwnershipPctChanged() { }

simulated event int GetCapturePointIndex() { }

defaultproperties
{
    r_fOwnershipPct=0.5000000
    s_bThrottleNetRelevancy=false
}
