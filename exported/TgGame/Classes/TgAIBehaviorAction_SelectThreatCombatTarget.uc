class TgAIBehaviorAction_SelectThreatCombatTarget extends TgAIBehaviorAction
    hidecategories(Object);

var() bool bMustBeHighestThreat;
var() bool bMustBeInLeash;
var() bool bMustBeInSightRadius;
var() bool bEffectGroupCategoryCheckInstigator;
var() bool bMustBeHittable;
var() TgAIController_Behavior.ECombatTargetType TargetType;
var() int EffectCategoryId;

defaultproperties
{
    bMustBeHighestThreat=true
    bMustBeInLeash=true
    bMustBeInSightRadius=true
    bMustBeHittable=true
    TitleName="SelectThreatCombatTarget"
    NodeToken=1048594
}