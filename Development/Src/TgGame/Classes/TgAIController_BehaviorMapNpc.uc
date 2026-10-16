class TgAIController_BehaviorMapNpc extends TgAIController_Behavior
    native(AI)
    config(Game)
    hidecategories(Navigation);

struct ThreatEntry {
    var TgPawn attacker;
    var float ThreatLevel;
    structdefaultproperties {}
};

var init transient array<init ThreatEntry> ThreatList;
var transient bool bThreatListDecays;
var transient bool bOutsideLeash;
var transient bool bHadCombatTarget;
var transient float LeashDistance;
var transient Volume LeashVolume;
var init transient array<init TgPawn> LeashActors;

native function AddThreat(TgPawn attacker, float ThreatLevel);  // Export UTgAIController_BehaviorMapNpc::execAddThreat(FFrame&, void* const)

native function ClearThreatList();  // Export UTgAIController_BehaviorMapNpc::execClearThreatList(FFrame&, void* const)

native function bool CanSpreadOut();  // Export UTgAIController_BehaviorMapNpc::execCanSpreadOut(FFrame&, void* const)

native function Evade();  // Export UTgAIController_BehaviorMapNpc::execEvade(FFrame&, void* const)

native function SquadEvade();  // Export UTgAIController_BehaviorMapNpc::execSquadEvade(FFrame&, void* const)

native function SquadTargetChanged();  // Export UTgAIController_BehaviorMapNpc::execSquadTargetChanged(FFrame&, void* const)

function NotifyKilledBy(Controller Killer) { }

defaultproperties
{
    bThreatListDecays=true
    LeashDistance=2048.0000000
    BlackboardType=2
    ObstacleAvoidanceGridPointSize=16.0000000
    ObstacleAvoidanceGridExtents=768.0000000
}
