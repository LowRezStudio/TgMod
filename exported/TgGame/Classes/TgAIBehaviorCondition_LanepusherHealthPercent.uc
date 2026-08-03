class TgAIBehaviorCondition_LanepusherHealthPercent extends TgAIBehaviorCondition
    hidecategories(Object);

var() float HealthPct;

defaultproperties
{
    HealthPct=50.0000000
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="LanepusherHealthPercentTest"
    NodeToken=415
}