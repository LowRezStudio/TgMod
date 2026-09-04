class TgAIBehaviorCondition_TeamDeathCount extends TgAIBehaviorCondition
    hidecategories(Object);

var() bool bMustBeEnemy;
var() int DeathThreshold;

defaultproperties
{
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="TeamDeathCount"
    NodeToken=434
}