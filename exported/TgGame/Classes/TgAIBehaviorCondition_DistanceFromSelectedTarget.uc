class TgAIBehaviorCondition_DistanceFromSelectedTarget extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object);

var() bool bMustBeEnemy;
var() bool bIgnoreTaskforce;
var() TgAIController_Behavior.ETargetSelector TargetSelector;
var() TgAIController_Behavior.ECombatTargetType TargetType;
var() int DeployableId;

defaultproperties
{
    TargetType=ECombatTargetType.AICombatTarget_God
    TitleName="DistanceFromSelectedTarget"
    NodeToken=288
}