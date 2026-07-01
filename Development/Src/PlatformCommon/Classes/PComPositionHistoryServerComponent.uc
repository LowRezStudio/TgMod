class PComPositionHistoryServerComponent extends ActorComponent
    native;

const MAX_POSITION_HISTORY_FRAMES = 30;

struct native PComPositionHistoryData
{
    var Vector Location;
    var Rotator Rotation;
    var Vector Velocity;
    var Actor.EPhysics Physics;
    var bool bWasFalling;
    var bool bCollideActors;
    var bool bBlockActors;

    structdefaultproperties
    {
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Rotation=(Pitch=0,Yaw=0,Roll=0)
        Velocity=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Physics=PHYS_None
        bWasFalling=false
        bCollideActors=false
        bBlockActors=false
    }
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

// Export UPComPositionHistoryServerComponent::execRecordData(FFrame&, void* const)
native final function RecordData();

// Export UPComPositionHistoryServerComponent::execGetPastData(FFrame&, void* const)
native final function PComPositionHistoryData GetPastData(float RewindTime, optional bool bUseClientTimeStamps = false);

// Export UPComPositionHistoryServerComponent::execIsOverlapping(FFrame&, void* const)
native final function bool IsOverlapping(float RewindTime, Vector LocationToCheck, float RadiusToCheck, out PComPositionHistoryData PastDataUsed);

// Export UPComPositionHistoryServerComponent::execIsInSphere(FFrame&, void* const)
native final function bool IsInSphere(float RewindTime, Vector LocationToCheck, float RadiusToCheck, out PComPositionHistoryData PastDataUsed);

defaultproperties
{
    CurrentIndex=-1
    TickGroup=TG_PostUpdateWork
}