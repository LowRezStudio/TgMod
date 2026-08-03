class TgAIBehaviorCondition_TimeInPayloadMode extends TgAIBehaviorCondition
    hidecategories(Object);

var() float TimeThreshold;

defaultproperties
{
    TimeThreshold=5.0000000
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="TimeInPayloadMode"
    NodeToken=441
}