class TgAIBehaviorCondition_NumRallyPoints extends TgAIBehaviorCondition
    hidecategories(Object);

var() int nRallyPointsThreshold;
var() bool bMustBeEnemy;
var() bool bMustBeSameTaskForce;

defaultproperties
{
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_GreaterThanOrEqual
    TitleName="NumRallyPoints"
    NodeToken=324
}