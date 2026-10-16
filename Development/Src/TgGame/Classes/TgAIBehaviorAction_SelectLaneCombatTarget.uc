class TgAIBehaviorAction_SelectLaneCombatTarget extends TgAIBehaviorAction
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () bool bMustBeEnemy;
var () bool bMustBeSameLane;
var () bool bMustHaveLineOfSight;
var () bool bMustHaveDamagedGod;
var () bool bMustNotBeImmune;
var () bool bMustBeInForwardCone;
var () bool bEffectGroupCategoryCheckInstigator;
var () bool bMustBeHittable;
var () bool bMustNotBeNearShield;
var () TgAIController_Behavior.ETargetSelector TargetSelector;
var () TgAIController_Behavior.ECombatTargetType TargetType;
var () TgAIController_Behavior.ECombatTargetType IgnoreTargetType;
var () int EffectCategoryId;
var () float DistanceThreshold;
var () float ForwardConeAngle;

defaultproperties
{
    bMustBeEnemy=true
    bMustBeHittable=true
    TitleName="SelectLaneCombatTarget"
    NodeToken=1048585
}
