class TgAIBehaviorCondition_DistanceFromSelectedTarget extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () bool bMustBeEnemy;
var () bool bIgnoreTaskforce;
var () TgAIController_Behavior.ETargetSelector TargetSelector;
var () TgAIController_Behavior.ECombatTargetType TargetType;
var () int DeployableId;

defaultproperties
{
    TargetType=AICombatTarget_God
    TitleName="DistanceFromSelectedTarget"
    NodeToken=288
}
