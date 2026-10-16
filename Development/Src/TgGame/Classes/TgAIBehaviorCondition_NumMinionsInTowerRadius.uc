class TgAIBehaviorCondition_NumMinionsInTowerRadius extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () bool bMinionsMustBeEnemy;
var () bool bTowerMustBeEnemy;
var () int MinionThreshold;

defaultproperties
{
    ComparisonOperator=BEHAVIORCOMPARE_GreaterThanOrEqual
    TitleName="NumMinionsInTowerRadius"
    NodeToken=281
}
