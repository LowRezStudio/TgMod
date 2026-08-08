class TgAIBehaviorCondition_ReturnAlways extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgAIBehaviorNode);

var () TgAIBehaviorNode.EBehaviorStatus AlwaysReturn;

defaultproperties
{
    AlwaysReturn=BEHAVIOR_Complete
    TitleName="ReturnAlways"
    NodeToken=319
}
