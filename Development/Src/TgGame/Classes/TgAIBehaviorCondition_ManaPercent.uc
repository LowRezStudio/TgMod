class TgAIBehaviorCondition_ManaPercent extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () float ManaPct;

defaultproperties
{
    ManaPct=50.0000000
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="ManaPercentTest"
    NodeToken=280
}
