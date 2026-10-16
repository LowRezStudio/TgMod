class SkelControlWheel extends SkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object,Translation,Rotation);

var(Wheel) transient float WheelDisplacement;
var(Wheel) float WheelMaxRenderDisplacement;
var(Wheel) transient float WheelRoll;
var(Wheel) Object.EAxis WheelRollAxis;
var(Wheel) Object.EAxis WheelSteeringAxis;
var(Wheel) transient float WheelSteering;
var(Wheel) bool bInvertWheelRoll;
var(Wheel) bool bInvertWheelSteering;

defaultproperties
{
    WheelMaxRenderDisplacement=50.0000000
    WheelRollAxis=EAxis.AXIS_X
    WheelSteeringAxis=EAxis.AXIS_Z
    bApplyTranslation=true
    bApplyRotation=true
    bAddTranslation=true
    bAddRotation=true
    BoneTranslationSpace=EBoneControlSpace.BCS_BoneSpace
    BoneRotationSpace=EBoneControlSpace.BCS_BoneSpace
    bIgnoreWhenNotRendered=true
}