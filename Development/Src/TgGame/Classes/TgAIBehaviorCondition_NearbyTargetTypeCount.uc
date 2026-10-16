class TgAIBehaviorCondition_NearbyTargetTypeCount extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () bool bMustBeEnemy;
var () bool bMustBeInForwardCone;
var () int TargetTypeThreshold;
var () TgAIController_Behavior.ECombatTargetType TargetType;
var () float ForwardConeAngle;

defaultproperties
{
    TitleName="NearbyTargetTypeCount"
    NodeToken=277
}
