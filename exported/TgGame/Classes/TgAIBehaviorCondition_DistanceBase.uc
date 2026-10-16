class TgAIBehaviorCondition_DistanceBase extends TgAIBehaviorCondition
    abstract
    hidecategories(Object);

var() float DistanceThreshold;

defaultproperties
{
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_GreaterThanOrEqual
}