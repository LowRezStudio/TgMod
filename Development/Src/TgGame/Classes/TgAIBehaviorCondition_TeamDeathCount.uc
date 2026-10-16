class TgAIBehaviorCondition_TeamDeathCount extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () bool bMustBeEnemy;
var () int DeathThreshold;

defaultproperties
{
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="TeamDeathCount"
    NodeToken=434
}
