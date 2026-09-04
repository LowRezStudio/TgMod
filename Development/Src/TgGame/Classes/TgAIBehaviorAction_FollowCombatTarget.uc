class TgAIBehaviorAction_FollowCombatTarget extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT DeviceSlot;

defaultproperties
{
    TitleName="FollowCombatTarget"
    NodeToken=1048579
}
