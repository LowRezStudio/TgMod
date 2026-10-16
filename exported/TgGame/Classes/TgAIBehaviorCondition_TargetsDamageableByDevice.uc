class TgAIBehaviorCondition_TargetsDamageableByDevice extends TgAIBehaviorCondition
    hidecategories(Object);

var() TgObject.TG_EQUIP_POINT DeviceSlot;
var() TgAIController_Behavior.ECombatTargetType TargetType;
var() int TargetCount;

defaultproperties
{
    TitleName="NumTargetsDamageableByDevice"
    NodeToken=308
}