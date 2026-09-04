class TgAIBehaviorAction_SelectAllyAttackerAsTarget extends TgAIBehaviorAction_SelectLaneCombatTarget
    hidecategories(Object);

var() float TimeThreshold;
var() float AllyDistanceThreshold;
var() float AttackerDistanceThreshold;

defaultproperties
{
    TargetSelector=ETargetSelector.TargetSelect_Weakest
    TitleName="SelectAllyAttackerAsTarget"
    NodeToken=1048722
}