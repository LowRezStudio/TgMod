class TgAIBehaviorCondition_CombatTargetHealthPercent extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () float HealthPct;

defaultproperties
{
    HealthPct=50.0000000
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="CombatTargetHealthPercentTest"
    NodeToken=263
}
