class PBRuleNodeRandom extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() int NumOutputs;
var() int MinNumExecuted;
var() int MaxNumExecuted;

defaultproperties
{
    NumOutputs=2
    MinNumExecuted=1
    MaxNumExecuted=1
    NextRules[0]=(NextRule=none,LinkName="0")
    NextRules[1]=(NextRule=none,LinkName="1")
}