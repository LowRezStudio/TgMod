class TgAIController_BehaviorLaneNpc extends TgAIController_Behavior
    native(AI)
    config(Game)
    hidecategories(Navigation);

var transient Actor GoalTarget;
var transient bool bDespawnOnLoseCombatTarget;
var transient bool bIsBehindSquad;
var transient bool bTooFarFromLane;

// Export UTgAIController_BehaviorLaneNpc::execCanSpreadOut(FFrame&, void* const)
native function bool CanSpreadOut();

defaultproperties
{
    BlackboardType=16
}