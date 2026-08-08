class TgAIBehaviorCondition_TimeSinceLastTookDamage extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () float TimeThreshold;
var () bool bMustBeCombatTarget;

defaultproperties
{
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="TimeSinceLastTookDamage"
    NodeToken=284
}
