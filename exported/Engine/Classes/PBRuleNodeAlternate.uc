class PBRuleNodeAlternate extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() ProcBuildingRuleset.EProcBuildingAxis RepeatAxis;
var() float ASize;
var() float BMaxSize;
var() bool bInvertPatternOrder;
var() bool bEqualSizeAB;

defaultproperties
{
    ASize=512.0000000
    NextRules[0]=(NextRule=none,LinkName="A")
    NextRules[1]=(NextRule=none,LinkName="B")
}