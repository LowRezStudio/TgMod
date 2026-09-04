class TgAIBehaviorCondition_WhatIsLastAttackerTargeting extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.ECombatTargetType TargetType;

defaultproperties
{
    TitleName="WhatIsLastAttackerTargeting"
    NodeToken=320
}
