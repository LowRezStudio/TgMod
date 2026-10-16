class TgAIBehaviorCondition_NearbyGodCount extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object)
    config(Engine);

var () bool bMustBeEnemy;
var () bool bMustBeInForwardCone;
var () int GodThreshold;
var () float ForwardConeAngle;

defaultproperties
{
    TitleName="NearbyGodCount"
    NodeToken=275
}
