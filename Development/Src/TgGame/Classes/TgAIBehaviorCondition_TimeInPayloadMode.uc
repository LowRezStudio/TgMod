class TgAIBehaviorCondition_TimeInPayloadMode extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () float TimeThreshold;

defaultproperties
{
    TimeThreshold=5.0000000
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="TimeInPayloadMode"
    NodeToken=441
}
