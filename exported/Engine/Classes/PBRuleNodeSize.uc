class PBRuleNodeSize extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() ProcBuildingRuleset.EProcBuildingAxis SizeAxis;
var() float DecisionSize;
var() bool bUseTopLevelScopeSize;

defaultproperties
{
    DecisionSize=512.0000000
    NextRules[0]=(NextRule=none,LinkName="Less")
    NextRules[1]=(NextRule=none,LinkName="Greater/Equal")
}