class TgAIBehaviorCondition_DistanceBase extends TgAIBehaviorCondition
    abstract
    hidecategories(Object)
    config(Engine);

var () float DistanceThreshold;

defaultproperties
{
    ComparisonOperator=BEHAVIORCOMPARE_GreaterThanOrEqual
}
