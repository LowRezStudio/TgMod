class TgAIBehaviorCondition_NearbyGodCount extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object);

var() bool bMustBeEnemy;
var() bool bMustBeInForwardCone;
var() int GodThreshold;
var() float ForwardConeAngle;

defaultproperties
{
    TitleName="NearbyGodCount"
    NodeToken=275
}