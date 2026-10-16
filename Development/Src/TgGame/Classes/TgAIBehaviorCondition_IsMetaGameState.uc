class TgAIBehaviorCondition_IsMetaGameState extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgPawn);

var () TgPawn.EMetaGameState TestGameState;

defaultproperties
{
    TitleName="IsMetaGameState"
    NodeToken=400
}
