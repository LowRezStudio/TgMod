class PBRuleNodeSplit extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

struct native RBSplitInfo
{
    var() bool bFixSize;
    var() float FixedSize;
    var() float ExpandRatio;
    var() name SplitName;

    structdefaultproperties
    {
        bFixSize=false
        FixedSize=512.0000000
        ExpandRatio=1.0000000
        SplitName="None"
    }
};

var() ProcBuildingRuleset.EProcBuildingAxis SplitAxis;
var() array<RBSplitInfo> SplitSetup;

defaultproperties
{
    SplitAxis=EProcBuildingAxis.EPBAxis_Z
    NextRules[0]=(NextRule=none,LinkName="Next")
    NextRules[1]=(NextRule=none,LinkName="0")
}