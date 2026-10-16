class PBRuleNodeExtractTopBottom extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() float ExtractTopZ;
var() float ExtractNotTopZ;
var() float ExtractBottomZ;
var() float ExtractNotBottomZ;

defaultproperties
{
    ExtractTopZ=512.0000000
    ExtractBottomZ=512.0000000
    NextRules[0]=(NextRule=none,LinkName="Top")
    NextRules[1]=(NextRule=none,LinkName="Not Top")
    NextRules[2]=(NextRule=none,LinkName="Mid")
    NextRules[3]=(NextRule=none,LinkName="Bottom")
    NextRules[4]=(NextRule=none,LinkName="Not Bottom")
}