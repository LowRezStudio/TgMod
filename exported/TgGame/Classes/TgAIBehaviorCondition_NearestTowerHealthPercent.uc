class TgAIBehaviorCondition_NearestTowerHealthPercent extends TgAIBehaviorCondition
    hidecategories(Object);

var() bool bMustBeEnemy;
var() float HealthPct;

defaultproperties
{
    HealthPct=50.0000000
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="NearestTowerHealthPercent"
    NodeToken=295
}