class SkelControlLimb extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object);

var(Effector) Vector EffectorLocation;
var(Effector) SkelControlBase.EBoneControlSpace EffectorLocationSpace;
var(Joint) SkelControlBase.EBoneControlSpace JointTargetLocationSpace;
var(Joint) SkelControlBase.EBoneControlSpace JointOffsetSpace;
var(Limb) Object.EAxis BoneAxis;
var(Limb) Object.EAxis JointAxis;
var(Effector) name EffectorSpaceBoneName;
var(Joint) Vector JointTargetLocation;
var(Joint) name JointTargetSpaceBoneName;
var(Joint) Vector JointOffset;
var(Joint) name JointOffsetBoneName;
var(Limb) bool bInvertBoneAxis;
var(Limb) bool bInvertJointAxis;
var(Limb) bool bRotateJoint;
var(Limb) bool bMaintainEffectorRelRot;
var(Limb) bool bTakeRotationFromEffectorSpace;
var() bool bAllowStretching;
var() editoronly transient bool m_bSnapEffectorToBoneLocation;
var() Vector2D StretchLimits;
var() name StretchRollBoneName;

defaultproperties
{
    BoneAxis=EAxis.AXIS_X
    JointAxis=EAxis.AXIS_Y
    StretchLimits=(X=0.7100000,Y=1.2000000)
    bIgnoreWhenNotRendered=true
}