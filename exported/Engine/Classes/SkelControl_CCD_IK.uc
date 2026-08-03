class SkelControl_CCD_IK extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object);

var(Effector) Vector EffectorLocation;
var(Effector) SkelControlBase.EBoneControlSpace EffectorLocationSpace;
var(Effector) name EffectorSpaceBoneName;
var(Effector) Vector EffectorTranslationFromBone;
var(CCD) int NumBones;
var(CCD) int MaxPerBoneIterations;
var const int IterationsCount;
var(CCD) float Precision;
var(CCD) bool bStartFromTail;
var(CCD) bool bNoTurnOptimization;
var(CCD) const array<float> AngleConstraint;
var(CCD) float MaxAngleSteps;

defaultproperties
{
    NumBones=2
    MaxPerBoneIterations=3
    Precision=0.1000000
    MaxAngleSteps=0.4000000
}