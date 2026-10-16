class TgAIBehaviorCondition_NearestTowerHealthPercent extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () bool bMustBeEnemy;
var () float HealthPct;

defaultproperties
{
    HealthPct=50.0000000
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="NearestTowerHealthPercent"
    NodeToken=295
}
