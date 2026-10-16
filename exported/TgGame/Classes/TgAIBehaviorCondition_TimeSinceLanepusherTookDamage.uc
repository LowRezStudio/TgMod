class TgAIBehaviorCondition_TimeSinceLanepusherTookDamage extends TgAIBehaviorCondition
    hidecategories(Object);

var() float TimeThreshold;

defaultproperties
{
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="TimeSinceLanepusherTookDamage"
    NodeToken=406
}