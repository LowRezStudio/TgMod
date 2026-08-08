class TgAISquad_MonsterBehaviorTree extends TgAISquad
    native(AI)
    config(Engine);

var name BehaviorTreeAsName;
var transient TgAIController_BehaviorMapNpc Controller;

native function TgAIController_BehaviorMapNpc SpawnController();  // Export UTgAISquad_MonsterBehaviorTree::execSpawnController(FFrame&, void* const)

native function SuggestTarget(Actor NewTarget, TgAIController requester);  // Export UTgAISquad_MonsterBehaviorTree::execSuggestTarget(FFrame&, void* const)

native function SetTarget(Actor NewTarget);  // Export UTgAISquad_MonsterBehaviorTree::execSetTarget(FFrame&, void* const)

native function SuggestDropTarget(Actor TargetToDrop, TgAIController requester);  // Export UTgAISquad_MonsterBehaviorTree::execSuggestDropTarget(FFrame&, void* const)

native function DropTarget(Actor TargetToDrop);  // Export UTgAISquad_MonsterBehaviorTree::execDropTarget(FFrame&, void* const)

native function UpdateTargetList(float DeltaTime);  // Export UTgAISquad_MonsterBehaviorTree::execUpdateTargetList(FFrame&, void* const)

native function SquadDied();  // Export UTgAISquad_MonsterBehaviorTree::execSquadDied(FFrame&, void* const)

native function Evade();  // Export UTgAISquad_MonsterBehaviorTree::execEvade(FFrame&, void* const)

native function Actor GetTarget();  // Export UTgAISquad_MonsterBehaviorTree::execGetTarget(FFrame&, void* const)

native function TgPawn GetTargetPawn();  // Export UTgAISquad_MonsterBehaviorTree::execGetTargetPawn(FFrame&, void* const)

event OnSquadCreated() { }

defaultproperties
{
    BehaviorTreeAsName="BehaviorTrees_MapNpc.AI.BT_BuffCamp_Squad"
}
