class HeadTrackingComponent extends ActorComponent
    native(Anim);

struct native ActorToLookAt
{
    var Actor Actor;
    var float Rating;
    var float EnteredTime;
    var float LastKnownDistance;
    var float StartTimeBeingLookedAt;
    var bool CurrentlyBeingLookedAt;

    structdefaultproperties
    {
        Actor=none
        Rating=0.0000000
        EnteredTime=0.0000000
        LastKnownDistance=0.0000000
        StartTimeBeingLookedAt=0.0000000
        CurrentlyBeingLookedAt=false
    }
};

var() array<name> TrackControllerName;
var() float LookAtActorRadius;
var() bool bDisableBeyondLimit;
var() float MaxLookAtTime;
var() float MinLookAtTime;
var() float MaxInterestTime;
var(Target) array< Class<Actor> > ActorClassesToLookAt;
var(Target) array<name> TargetBoneNames;
var private native const transient map{VOID,VOID} CurrentActorMap;
var export editinline SkeletalMeshComponent SkeletalMeshComp;
var private transient array<SkelControlLookAt> TrackControls;
var private transient Vector RootMeshLocation;
var private transient Rotator RootMeshRotation;

defaultproperties
{
    TrackControllerName[0]="HeadLook"
    TrackControllerName[1]="LeftEyeLook"
    TrackControllerName[2]="RightEyeLook"
    LookAtActorRadius=500.0000000
    MaxLookAtTime=5.0000000
    MinLookAtTime=3.0000000
    MaxInterestTime=7.0000000
    TargetBoneNames[0]="b_MF_Head"
    TargetBoneNames[1]="b_MF_Neck"
}