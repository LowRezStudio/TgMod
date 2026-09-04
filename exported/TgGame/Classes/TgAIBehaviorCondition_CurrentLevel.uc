class TgAIBehaviorCondition_CurrentLevel extends TgAIBehaviorCondition
    hidecategories(Object);

var() int LevelThreshold;

defaultproperties
{
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_GreaterThanOrEqual
    TitleName="CurrentLevel"
    NodeToken=264
}