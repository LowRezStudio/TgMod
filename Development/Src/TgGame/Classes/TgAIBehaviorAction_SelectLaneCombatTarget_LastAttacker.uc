class TgAIBehaviorAction_SelectLaneCombatTarget_LastAttacker extends TgAIBehaviorAction
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () bool bSkipPawnNotify;
var () bool bMustBeHittable;
var () TgAIController_Behavior.ECombatTargetType IgnoreTargetType;

defaultproperties
{
    bMustBeHittable=true
    TitleName="SelectLastAttacker"
    NodeToken=1048586
}
