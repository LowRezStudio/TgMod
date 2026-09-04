class TgAIBehaviorCondition_NumRallyPoints extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () int nRallyPointsThreshold;
var () bool bMustBeEnemy;
var () bool bMustBeSameTaskForce;

defaultproperties
{
    ComparisonOperator=BEHAVIORCOMPARE_GreaterThanOrEqual
    TitleName="NumRallyPoints"
    NodeToken=324
}
