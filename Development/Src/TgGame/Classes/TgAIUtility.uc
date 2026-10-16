class TgAIUtility extends TgAIBehaviorNode
    abstract
    native(AI)
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior, TgPawn);

enum EGraphType {
    Graph_LINEAER,  // 0
};

var TgAIController_Behavior.EUtilityType UtilityType;
var () init array<init TgPawn.EBotBehaviorState> IgnoreBehaviorState;
var () init array<init TgPawn.EBotBehaviorState> RejctBehaviorState;
var transient int ParentIndex;
