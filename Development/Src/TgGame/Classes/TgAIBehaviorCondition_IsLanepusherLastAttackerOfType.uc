class TgAIBehaviorCondition_IsLanepusherLastAttackerOfType extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.ECombatTargetType TargetType;

defaultproperties
{
    TitleName="IsLanepusherLastAttackerOfType"
    NodeToken=407
}
