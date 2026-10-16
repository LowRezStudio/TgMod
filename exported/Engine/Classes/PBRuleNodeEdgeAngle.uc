class PBRuleNodeEdgeAngle extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

enum EProcBuildingEdge
{
    EPBE_Top,                       // 0
    EPBE_Bottom,                    // 1
    EPBE_Left,                      // 2
    EPBE_Right,                     // 3
    EPBE_MAX                        // 4
};

struct native RBEdgeAngleInfo
{
    var() float Angle;

    structdefaultproperties
    {
        Angle=0.0000000
    }
};

var() PBRuleNodeEdgeAngle.EProcBuildingEdge Edge;
var() array<RBEdgeAngleInfo> Angles;

defaultproperties
{
    Edge=EProcBuildingEdge.EPBE_Left
    NextRules=none
}