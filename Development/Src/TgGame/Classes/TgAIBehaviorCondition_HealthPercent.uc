class TgAIBehaviorCondition_HealthPercent extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () float HealthPct;

defaultproperties
{
    HealthPct=50.0000000
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="HealthPercentTest"
    NodeToken=268
}
