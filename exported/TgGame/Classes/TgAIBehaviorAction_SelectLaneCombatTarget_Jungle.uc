class TgAIBehaviorAction_SelectLaneCombatTarget_Jungle extends TgAIBehaviorAction
    hidecategories(Object);

var() bool bMustBeWeakest;
var() TgAIController_Behavior.EJungleTargetType TargetType;

defaultproperties
{
    TitleName="SelectJungleCombatTarget"
    NodeToken=1048614
}