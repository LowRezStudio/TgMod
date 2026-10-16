class TgAIBehaviorCondition_HealthPercent extends TgAIBehaviorCondition
    hidecategories(Object);

var() float HealthPct;

defaultproperties
{
    HealthPct=50.0000000
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="HealthPercentTest"
    NodeToken=268
}