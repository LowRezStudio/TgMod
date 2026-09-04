class TgAIBehaviorCondition_TimeSinceLanepusherTookDamage extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () float TimeThreshold;

defaultproperties
{
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="TimeSinceLanepusherTookDamage"
    NodeToken=406
}
