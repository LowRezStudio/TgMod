class TgAIBehaviorCondition_SquadTargetHealthPercent extends TgAIBehaviorCondition
    hidecategories(Object);

var() float HealthPct;

defaultproperties
{
    HealthPct=50.0000000
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="SquadTargetHealthPercentTest"
    NodeToken=429
}