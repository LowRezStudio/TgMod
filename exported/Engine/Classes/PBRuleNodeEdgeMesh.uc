class PBRuleNodeEdgeMesh extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() float FlatThreshold;
var() float MainXPullIn;

defaultproperties
{
    FlatThreshold=5.0000000
    NextRules[0]=(NextRule=none,LinkName="Main")
    NextRules[1]=(NextRule=none,LinkName="Edge")
}