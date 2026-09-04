class TgAIBehaviorCondition_HasConsumable extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.EConsumableType ConsumableType;

defaultproperties
{
    TitleName="HasConsumable"
    NodeToken=313
}
