class TgAIBehaviorCondition_AmmoCostPerShot extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT DeviceSlot;
var () int AmmoThreshold;

defaultproperties
{
    TitleName="AmmoCostPerShot"
    NodeToken=418
}
