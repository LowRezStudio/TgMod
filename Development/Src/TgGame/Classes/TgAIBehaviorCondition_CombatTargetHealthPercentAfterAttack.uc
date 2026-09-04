class TgAIBehaviorCondition_CombatTargetHealthPercentAfterAttack extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT DeviceSlot;
var () float HealthPct;

defaultproperties
{
    DeviceSlot=EQP_AUTO
    HealthPct=50.0000000
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="CombatTargetHealthPercentAfterAttackTest"
    NodeToken=318
}
