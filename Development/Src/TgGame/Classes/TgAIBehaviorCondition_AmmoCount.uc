class TgAIBehaviorCondition_AmmoCount extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT DeviceSlot;
var () int AmmoThreshold;

defaultproperties
{
    TitleName="AmmoCount"
    NodeToken=417
}
