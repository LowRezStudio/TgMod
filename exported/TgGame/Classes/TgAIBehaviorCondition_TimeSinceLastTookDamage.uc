class TgAIBehaviorCondition_TimeSinceLastTookDamage extends TgAIBehaviorCondition
    hidecategories(Object);

var() float TimeThreshold;
var() bool bMustBeCombatTarget;

defaultproperties
{
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="TimeSinceLastTookDamage"
    NodeToken=284
}