class PBRuleNodeBase extends Object
    abstract
    native(ProcBuilding)
    editinlinenew
    hidecategories(Object);

struct native PBRuleLink
{
    var() export editinline PBRuleNodeBase NextRule;
    var() name LinkName;

    structdefaultproperties
    {
        NextRule=none
        LinkName="None"
    }
};

var editfixedsize array<PBRuleLink> NextRules;

defaultproperties
{
    NextRules[0]=(NextRule=none,LinkName="Next")
}