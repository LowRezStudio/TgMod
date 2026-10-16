class PBRuleNodeCorner extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

struct native RBCornerAngleInfo
{
    var() float Angle;
    var() float CornerSize;

    structdefaultproperties
    {
        Angle=0.0000000
        CornerSize=0.0000000
    }
};

var() float CornerSize;
var() array<RBCornerAngleInfo> Angles;
var() float FlatThreshold;
var() bool bNoMeshForConcaveCorners;
var() bool bUseAdjacentRulesetForRightGap;
var() ProcBuilding.EPBCornerType CornerType;
var() float CornerShapeOffset;
var() int RoundTesselation;
var() float RoundCurvature;

defaultproperties
{
    CornerSize=256.0000000
    Angles[0]=(Angle=90.0000000,CornerSize=0.0000000)
    Angles[1]=(Angle=-90.0000000,CornerSize=0.0000000)
    FlatThreshold=5.0000000
    RoundTesselation=4
    RoundCurvature=1.0000000
}