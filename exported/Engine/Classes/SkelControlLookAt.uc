class SkelControlLookAt extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object);

var(LookAt) Vector TargetLocation;
var(LookAt) SkelControlBase.EBoneControlSpace TargetLocationSpace;
var(LookAt) Object.EAxis LookAtAxis;
var(LookAt) Object.EAxis UpAxis;
var(Limit) SkelControlBase.EBoneControlSpace AllowRotationSpace;
var(LookAt) name TargetSpaceBoneName;
var(LookAt) bool bInvertLookAtAxis;
var(LookAt) bool bDefineUpAxis;
var(LookAt) bool bInvertUpAxis;
var(Limit) bool bEnableLimit;
var(Limit) bool bLimitBasedOnRefPose;
var(Limit) bool bDisableBeyondLimit;
var(Limit) bool bNotifyBeyondLimit;
var(Limit) bool bShowLimit;
var(Limit) bool bAllowRotationX;
var(Limit) bool bAllowRotationY;
var(Limit) bool bAllowRotationZ;
var(LookAt) float TargetLocationInterpSpeed;
var Vector DesiredTargetLocation;
var protected const transient Vector ActorSpaceLookAtTarget;
var(Limit) float MaxAngle;
var(Limit) float OuterMaxAngle;
var(Limit) float DeadZoneAngle;
var(Limit) Vector2D RotationAngleRangeX;
var(Limit) Vector2D RotationAngleRangeY;
var(Limit) Vector2D RotationAngleRangeZ;
var(Limit) name AllowRotationOtherBoneName;
var const transient float LookAtAlpha;
var const transient float LookAtAlphaTarget;
var const transient float LookAtAlphaBlendTimeToGo;
var const transient Vector LimitLookDir;
var const transient Vector BaseLookDir;
var const transient Vector BaseBonePos;
var const transient float LastCalcTime;
var const transient int ControlBoneIndex;

// Export USkelControlLookAt::execSetTargetLocation(FFrame&, void* const)
native final function SetTargetLocation(Vector NewTargetLocation);

// Export USkelControlLookAt::execInterpolateTargetLocation(FFrame&, void* const)
native final function InterpolateTargetLocation(float DeltaTime);

// Export USkelControlLookAt::execSetLookAtAlpha(FFrame&, void* const)
native final function SetLookAtAlpha(float DesiredAlpha, float DesiredBlendTime);

// Export USkelControlLookAt::execCanLookAtPoint(FFrame&, void* const)
native final function bool CanLookAtPoint(Vector PointLoc, optional bool bDrawDebugInfo, optional bool bDebugUsePersistentLines, optional bool bDebugFlushLinesFirst);

defaultproperties
{
    LookAtAxis=EAxis.AXIS_X
    UpAxis=EAxis.AXIS_Z
    AllowRotationSpace=EBoneControlSpace.BCS_BoneSpace
    bLimitBasedOnRefPose=true
    bShowLimit=true
    bAllowRotationX=true
    bAllowRotationY=true
    bAllowRotationZ=true
    TargetLocationInterpSpeed=10.0000000
    ActorSpaceLookAtTarget=(X=256.0000000,Y=0.0000000,Z=0.0000000)
    OuterMaxAngle=90.0000000
    RotationAngleRangeX=(X=-90.0000000,Y=90.0000000)
    RotationAngleRangeY=(X=-90.0000000,Y=90.0000000)
    RotationAngleRangeZ=(X=-90.0000000,Y=90.0000000)
    LookAtAlpha=1.0000000
    LookAtAlphaTarget=1.0000000
    ControlBoneIndex=-1
    BlendInTime=0.3300000
    BlendOutTime=0.3300000
    bIgnoreWhenNotRendered=true
}