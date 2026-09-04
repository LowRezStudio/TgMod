class TgAIBehaviorCondition_SelectedTargetHealthPercent extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () bool bMustBeEnemy;
var () bool bIgnoreTaskforce;
var () TgAIController_Behavior.ETargetSelector TargetSelector;
var () TgAIController_Behavior.ECombatTargetType TargetType;
var () int TargetId;
var () float HealthPct;

defaultproperties
{
    TargetType=AICombatTarget_God
    HealthPct=50.0000000
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="SelectedTargetHealthPercent"
    NodeToken=293
}
