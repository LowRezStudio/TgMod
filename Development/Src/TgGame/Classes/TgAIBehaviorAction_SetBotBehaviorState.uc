class TgAIBehaviorAction_SetBotBehaviorState extends TgAIBehaviorAction
    hidecategories(Object)
    config(Engine)
    dependson(TgPawn);

var () TgPawn.EBotBehaviorState DesiredBehaviorState;

defaultproperties
{
    TitleName="SetBotBehaviorState"
    NodeToken=1048718
}
