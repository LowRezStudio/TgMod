class TgAIBehaviorCondition_TargetsDamageableByDevice extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior, TgObject);

var () TgObject.TG_EQUIP_POINT DeviceSlot;
var () TgAIController_Behavior.ECombatTargetType TargetType;
var () int TargetCount;

defaultproperties
{
    TitleName="NumTargetsDamageableByDevice"
    NodeToken=308
}
