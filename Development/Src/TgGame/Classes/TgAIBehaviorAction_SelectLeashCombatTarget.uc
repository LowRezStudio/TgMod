class TgAIBehaviorAction_SelectLeashCombatTarget extends TgAIBehaviorAction
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () bool bMustBeEnemy;
var () bool bMustBeWeakest;
var () bool bMustHaveLineOfSight;
var () bool bMustHaveDamagedGod;
var () bool bMustNotBeImmune;
var () bool bEffectGroupCategoryCheckInstigator;
var () bool bMustBeHittable;
var () TgAIController_Behavior.ECombatTargetType TargetType;
var () int EffectCategoryId;

defaultproperties
{
    bMustBeEnemy=true
    bMustHaveLineOfSight=true
    bMustBeHittable=true
    TitleName="SelectLeashCombatTarget"
    NodeToken=1048596
}
