class SkelControlHandlebars extends SkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object,Translation,Rotation);

var(Handlebars) Object.EAxis WheelRollAxis;
var(Handlebars) Object.EAxis HandlebarRotateAxis;
var(Handlebars) name WheelBoneName;
var(Handlebars) bool bInvertRotation;
var int SteerWheelBoneIndex;

defaultproperties
{
    WheelRollAxis=EAxis.AXIS_Y
    HandlebarRotateAxis=EAxis.AXIS_Z
    SteerWheelBoneIndex=-1
    bApplyRotation=true
    BoneTranslationSpace=EBoneControlSpace.BCS_BoneSpace
    BoneRotationSpace=EBoneControlSpace.BCS_BoneSpace
    bIgnoreWhenNotRendered=true
}