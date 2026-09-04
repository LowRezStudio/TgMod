class PComPositionHistoryServerComponent extends ActorComponent
    native
    config(Engine);

const MAX_POSITION_HISTORY_FRAMES = 30;

struct PComPositionHistoryData {
    var Vector Location;
    var Rotator Rotation;
    var Vector Velocity;
    var Actor.EPhysics Physics;
    var bool bWasFalling;
    var bool bCollideActors;
    var bool bBlockActors;
    structdefaultproperties {}
};

var int CurrentIndex;
var float ServerTimeStamps[30];
var float ClientTimeStamps[30];
var Vector Positions[30];
var Vector Velocities[30];
var Rotator Rotations[30];
var byte bJustTeleported[30];
var byte bCollideActors[30];
var byte bBlockActors[30];
var Actor.EPhysics Physics[30];

native function RecordData();  // Export UPComPositionHistoryServerComponent::execRecordData(FFrame&, void* const)

native function PComPositionHistoryData GetPastData(float RewindTime, optional bool bUseClientTimeStamps=false);  // Export UPComPositionHistoryServerComponent::execGetPastData(FFrame&, void* const)

native function bool IsOverlapping(float RewindTime, Vector LocationToCheck, float RadiusToCheck, out PComPositionHistoryData PastDataUsed);  // Export UPComPositionHistoryServerComponent::execIsOverlapping(FFrame&, void* const)

native function bool IsInSphere(float RewindTime, Vector LocationToCheck, float RadiusToCheck, out PComPositionHistoryData PastDataUsed);  // Export UPComPositionHistoryServerComponent::execIsInSphere(FFrame&, void* const)

defaultproperties
{
    CurrentIndex=-1
    TickGroup=TG_PostUpdateWork
}
