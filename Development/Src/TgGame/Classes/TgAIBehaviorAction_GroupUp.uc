class TgAIBehaviorAction_GroupUp extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT DeviceSlot;
var () float MinDistance;
var () float MaxDistance;

defaultproperties
{
    TitleName="GroupUp"
    NodeToken=1048714
}
