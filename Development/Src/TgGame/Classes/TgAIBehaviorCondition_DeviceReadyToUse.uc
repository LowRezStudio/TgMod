class TgAIBehaviorCondition_DeviceReadyToUse extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT DeviceSlot;

defaultproperties
{
    TitleName="DeviceReadyToUse"
    NodeToken=265
}
