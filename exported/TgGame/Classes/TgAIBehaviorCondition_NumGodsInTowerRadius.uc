class TgAIBehaviorCondition_NumGodsInTowerRadius extends TgAIBehaviorCondition
    hidecategories(Object);

var() bool bGodsMustBeEnemy;
var() bool bTowerMustBeEnemy;
var() int GodThreshold;

defaultproperties
{
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_GreaterThanOrEqual
    TitleName="NumGodsInTowerRadius"
    NodeToken=294
}