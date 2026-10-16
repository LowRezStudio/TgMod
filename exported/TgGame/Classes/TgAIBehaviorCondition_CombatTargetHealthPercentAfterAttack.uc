class TgAIBehaviorCondition_CombatTargetHealthPercentAfterAttack extends TgAIBehaviorCondition
    hidecategories(Object);

var() TgObject.TG_EQUIP_POINT DeviceSlot;
var() float HealthPct;

defaultproperties
{
    DeviceSlot=TG_EQUIP_POINT.EQP_AUTO
    HealthPct=50.0000000
    ComparisonOperator=EBehaviorComparison.BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="CombatTargetHealthPercentAfterAttackTest"
    NodeToken=318
}