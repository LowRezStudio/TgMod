class TgAIBehaviorCondition_DifficultyLevel extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.EBotDifficultyLevel Difficulty;

defaultproperties
{
    TitleName="DifficultyLevel"
    NodeToken=311
}
