class TgAIBehaviorCondition_NumberDevicesFiring extends TgAIBehaviorCondition
    hidecategories(Object);

var() TgObject.TG_EQUIP_POINT DeviceSlot;
var() bool bMustBeEnemy;
var() bool bIsFiring;
var() int GodThreshold;
var() float DistanceThreshold;

defaultproperties
{
    bIsFiring=true
    TitleName="NumberDevicesFiring"
    NodeToken=447
}