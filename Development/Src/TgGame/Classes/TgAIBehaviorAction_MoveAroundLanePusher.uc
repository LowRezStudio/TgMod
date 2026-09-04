class TgAIBehaviorAction_MoveAroundLanePusher extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT DeviceSlot;
var () bool bMoveClockWise;

defaultproperties
{
    TitleName="MoveAroundLanePusher"
    NodeToken=1048713
}
