class TgAIBehaviorCondition_IsWithinCombatDistance extends TgAIBehaviorCondition
    hidecategories(Object);

var() bool bSubtractTargetPawnRadius;
var() float DistanceThresholdPercent;
var() TgObject.TG_EQUIP_POINT DeviceSlot;

defaultproperties
{
    DistanceThresholdPercent=1.0000000
    TitleName="IsWithinCombatDistance"
    NodeToken=274
}