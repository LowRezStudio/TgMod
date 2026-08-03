class MorphNodeWeightByBoneAngle extends MorphNodeWeightBase
    native(Anim)
    hidecategories(Object,Object,Object);

struct native BoneAngleMorph
{
    var() float Angle;
    var() float TargetWeight;

    structdefaultproperties
    {
        Angle=0.0000000
        TargetWeight=1.0000000
    }
};

var const transient float Angle;
var const transient float NodeWeight;
var(BaseBone) name BaseBoneName;
var(BaseBone) Object.EAxis BaseBoneAxis;
var(AngleBone) Object.EAxis AngleBoneAxis;
var(BaseBone) bool bInvertBaseBoneAxis;
var(AngleBone) bool bInvertAngleBoneAxis;
var(Material) bool bControlMaterialParameter;
var(AngleBone) name AngleBoneName;
var(Material) int MaterialSlotId;
var(Material) name ScalarParameterName;
var transient MaterialInstanceConstant MaterialInstanceConstant;
var() array<BoneAngleMorph> WeightArray;

defaultproperties
{
    BaseBoneAxis=EAxis.AXIS_X
    AngleBoneAxis=EAxis.AXIS_X
    WeightArray[0]=(Angle=0.0000000,TargetWeight=0.0000000)
    WeightArray[1]=(Angle=180.0000000,TargetWeight=1.0000000)
    NodeConns[0]=(ChildNodes=none,ConnName="In",DrawY=0)
}