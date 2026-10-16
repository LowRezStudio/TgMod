class TgAIBehaviorCondition_NumMinionsInTowerRadius extends TgAIBehaviorCondition
    hidecategories(Object);

var() bool bMinionsMustBeEnemy;
var() bool bTowerMustBeEnemy;
var() int MinionThreshold;

defaultproperties
{
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_GreaterThanOrEqual
    TitleName="NumMinionsInTowerRadius"
    NodeToken=281
}