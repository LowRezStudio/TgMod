class TgAIBehaviorAction_SelectLaneCombatTarget_LastAttacker extends TgAIBehaviorAction
    hidecategories(Object);

var() bool bSkipPawnNotify;
var() bool bMustBeHittable;
var() TgAIController_Behavior.ECombatTargetType IgnoreTargetType;

defaultproperties
{
    bMustBeHittable=true
    TitleName="SelectLastAttacker"
    NodeToken=1048586
}