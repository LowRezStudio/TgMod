class TgAIBehaviorCondition_IsDesiredAimDevice extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT DeviceSlot;

defaultproperties
{
    TitleName="IsDesiredAimDevice"
    NodeToken=443
}
