class TgAIBehaviorCondition_NearbyGodDelta extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object)
    config(Engine);

var () int GodThreshold;
var () bool bMustBeInForwardCone;
var () float ForwardConeAngle;

defaultproperties
{
    TitleName="NearbyGodDelta"
    NodeToken=276
}
