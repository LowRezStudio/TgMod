class TgAIBehaviorAction_SelectLaneMoveTarget_Jungle extends TgAIBehaviorAction
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.EJungleTargetType TargetType;

defaultproperties
{
    TitleName="SelectJungleMoveTarget"
    NodeToken=1048588
}
