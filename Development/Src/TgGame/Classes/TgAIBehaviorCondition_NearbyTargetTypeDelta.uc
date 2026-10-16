class TgAIBehaviorCondition_NearbyTargetTypeDelta extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () int TargetTypeThreshold;
var () TgAIController_Behavior.ECombatTargetType TargetType;
var () bool bMustBeInForwardCone;
var () float ForwardConeAngle;

defaultproperties
{
    TitleName="NearbyTargetTypeDelta"
    NodeToken=278
}
