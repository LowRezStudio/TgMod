class TgAIBehaviorAction_SelectAllyAttackerAsTarget extends TgAIBehaviorAction_SelectLaneCombatTarget
    hidecategories(Object)
    config(Engine);

var () float TimeThreshold;
var () float AllyDistanceThreshold;
var () float AttackerDistanceThreshold;

defaultproperties
{
    TargetSelector=TargetSelect_Weakest
    TitleName="SelectAllyAttackerAsTarget"
    NodeToken=1048722
}
