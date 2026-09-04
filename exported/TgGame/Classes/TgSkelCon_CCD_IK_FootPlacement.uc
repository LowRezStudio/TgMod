class TgSkelCon_CCD_IK_FootPlacement extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object);

struct native JointConstraintInformation
{
    var() float AngleConstraint;
    var() float StretchConstraint;

    structdefaultproperties
    {
        AngleConstraint=0.0000000
        StretchConstraint=0.0000000
    }
};

var(CCD) int NumBones;
var(CCD) int MaxPerBoneIterations;
var const int IterationsCount;
var(CCD) float Precision;
var(CCD) bool bStartFromTail;
var(CCD) bool bNoTurnOptimization;
var() bool bAllowStretching;
var(FootPlacement) bool bInvertFootUpAxis;
var(FootPlacement) bool bOrientFootToGround;
var(FootPlacement) bool bOnlyEnableForUpAdjustment;
var bool m_bUseCachedFootOffset;
var(CCD) const array<JointConstraintInformation> JointConstraints;
var(CCD) float MaxAngleSteps;
var(CCD) float MaxStretchSteps;
var(FootPlacement) float FootOffset;
var(FootPlacement) Object.EAxis FootUpAxis;
var(FootPlacement) Rotator FootRotOffset;
var(FootPlacement) float MaxUpAdjustment;
var(FootPlacement) float MaxDownAdjustment;
var(FootPlacement) float MaxFootOrientAdjust;
var Vector EffectorLocation;
var Vector m_vCachedFootOffset;

defaultproperties
{
    NumBones=2
    MaxPerBoneIterations=3
    Precision=0.1000000
    bOrientFootToGround=true
    MaxAngleSteps=0.4000000
    FootUpAxis=EAxis.AXIS_X
    MaxUpAdjustment=50.0000000
    MaxFootOrientAdjust=45.0000000
}