class TgAIBehaviorCondition_DeviceIsFiring extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT DeviceSlot;

defaultproperties
{
    TitleName="DeviceIsFiring"
    NodeToken=321
}
