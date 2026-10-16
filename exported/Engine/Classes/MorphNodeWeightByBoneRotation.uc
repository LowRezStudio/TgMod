class MorphNodeWeightByBoneRotation extends MorphNodeWeightBase
    native(Anim)
    hidecategories(Object,Object,Object);

var const transient float Angle;
var const transient float NodeWeight;
var() name BoneName;
var() Object.EAxis BoneAxis;
var() bool bInvertBoneAxis;
var(Material) bool bControlMaterialParameter;
var() array<BoneAngleMorph> WeightArray;
var(Material) int MaterialSlotId;
var(Material) name ScalarParameterName;
var transient MaterialInstanceConstant MaterialInstanceConstant;

defaultproperties
{
    BoneAxis=EAxis.AXIS_Y
    WeightArray[0]=(Angle=0.0000000,TargetWeight=0.0000000)
    WeightArray[1]=(Angle=90.0000000,TargetWeight=1.0000000)
    NodeConns[0]=(ChildNodes=none,ConnName="In",DrawY=0)
}