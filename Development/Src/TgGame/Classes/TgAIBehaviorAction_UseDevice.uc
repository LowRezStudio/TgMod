class TgAIBehaviorAction_UseDevice extends TgAIBehaviorAction
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior, TgObject);

var () TgObject.TG_EQUIP_POINT DeviceToUse;
var () TgAIController_Behavior.EUseDeviceAimType aimType;
var () bool bContinuousFire;
var () bool bPayNoEnergy;

defaultproperties
{
    TitleName="UseDevice"
    NodeToken=1048577
}
