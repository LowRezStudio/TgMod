class TgAIBehaviorCondition_SquadTargetHealthPercent extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () float HealthPct;

defaultproperties
{
    HealthPct=50.0000000
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="SquadTargetHealthPercentTest"
    NodeToken=429
}
