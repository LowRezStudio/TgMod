class TgAIBehaviorCondition_HasActive extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.EActiveType ActiveType;

defaultproperties
{
    TitleName="HasActive"
    NodeToken=314
}
