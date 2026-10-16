class PBRuleNodeCycle extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() ProcBuildingRuleset.EProcBuildingAxis RepeatAxis;
var() float RepeatSize;
var() int CycleSize;
var() bool bFixRepeatSize;

defaultproperties
{
    RepeatAxis=EProcBuildingAxis.EPBAxis_Z
    RepeatSize=512.0000000
    CycleSize=2
    NextRules[0]=(NextRule=none,LinkName="Remainder")
    NextRules[1]=(NextRule=none,LinkName="Step 0")
    NextRules[2]=(NextRule=none,LinkName="Step 1")
}