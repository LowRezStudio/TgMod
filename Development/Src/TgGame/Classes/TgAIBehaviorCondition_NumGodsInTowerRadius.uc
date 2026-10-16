class TgAIBehaviorCondition_NumGodsInTowerRadius extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () bool bGodsMustBeEnemy;
var () bool bTowerMustBeEnemy;
var () int GodThreshold;

defaultproperties
{
    ComparisonOperator=BEHAVIORCOMPARE_GreaterThanOrEqual
    TitleName="NumGodsInTowerRadius"
    NodeToken=294
}
