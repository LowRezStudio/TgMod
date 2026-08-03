class InterpTrackHeadTracking extends InterpTrack
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

enum EHeadTrackingAction
{
    EHTA_DisableHeadTracking,       // 0
    EHTA_EnableHeadTracking,        // 1
    EHTA_MAX                        // 2
};

struct native HeadTrackingKey
{
    var float Time;
    var() InterpTrackHeadTracking.EHeadTrackingAction Action;

    structdefaultproperties
    {
        Time=0.0000000
        Action=EHeadTrackingAction.EHTA_DisableHeadTracking
    }
};

var array<HeadTrackingKey> HeadTrackingTrack;
var() array<name> TrackControllerName;
var() float LookAtActorRadius;
var() bool bDisableBeyondLimit;
var(Target) bool bLookAtPawns;
var() float MaxLookAtTime;
var() float MinLookAtTime;
var() float MaxInterestTime;
var(Target) array< Class<Actor> > ActorClassesToLookAt;
var(Target) array<name> TargetBoneNames;

defaultproperties
{
    TrackControllerName[0]="HeadLook"
    TrackControllerName[1]="LeftEyeLook"
    TrackControllerName[2]="RightEyeLook"
    LookAtActorRadius=500.0000000
    bLookAtPawns=true
    MaxLookAtTime=5.0000000
    MinLookAtTime=3.0000000
    MaxInterestTime=7.0000000
    TargetBoneNames[0]="b_MF_Head"
    TargetBoneNames[1]="b_MF_Neck"
    TrackInstClass=Class'Engine.InterpTrackInstHeadTracking'
    TrackTitle="HeadTracking"
}