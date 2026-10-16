class TgAIController_BehaviorLaneNpc extends TgAIController_Behavior
    native(AI)
    config(Game)
    hidecategories(Navigation);

var transient Actor GoalTarget;
var transient bool bDespawnOnLoseCombatTarget;
var transient bool bIsBehindSquad;
var transient bool bTooFarFromLane;

native function bool CanSpreadOut();  // Export UTgAIController_BehaviorLaneNpc::execCanSpreadOut(FFrame&, void* const)

defaultproperties
{
    BlackboardType=16
}
