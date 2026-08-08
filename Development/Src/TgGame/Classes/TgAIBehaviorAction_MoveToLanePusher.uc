class TgAIBehaviorAction_MoveToLanePusher extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT DeviceSlot;

defaultproperties
{
    TitleName="MoveToLanePusher"
    NodeToken=1048700
}
