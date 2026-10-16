class TgAISquad extends Object
    native(AI)
    config(Engine);

var bool s_bOpen;
var bool s_bShouldSpread;
var array<TgAIController> s_MemberList;
var TgBotFactory s_Factory;
var Actor s_CurrentTarget;
var array<Actor> s_TargetList;
var Controller s_LastKiller;
var float s_fNextSpreadTime;

native function OpenSquad();  // Export UTgAISquad::execOpenSquad(FFrame&, void* const)

native function CloseSquad();  // Export UTgAISquad::execCloseSquad(FFrame&, void* const)

native function bool IsOpen();  // Export UTgAISquad::execIsOpen(FFrame&, void* const)

native function AddMember(TgAIController aic);  // Export UTgAISquad::execAddMember(FFrame&, void* const)

native function RemoveMember(TgAIController aic, bool bDied);  // Export UTgAISquad::execRemoveMember(FFrame&, void* const)

native function MemberKilledBy(Controller Killer);  // Export UTgAISquad::execMemberKilledBy(FFrame&, void* const)

native function bool MergeWith(TgAISquad squad);  // Export UTgAISquad::execMergeWith(FFrame&, void* const)

native function SquadDied();  // Export UTgAISquad::execSquadDied(FFrame&, void* const)

native function SpreadSquad();  // Export UTgAISquad::execSpreadSquad(FFrame&, void* const)

native function Box GetSquadBounds();  // Export UTgAISquad::execGetSquadBounds(FFrame&, void* const)

native function SuggestTarget(Actor NewTarget, TgAIController requester);  // Export UTgAISquad::execSuggestTarget(FFrame&, void* const)

native function SetTarget(Actor NewTarget);  // Export UTgAISquad::execSetTarget(FFrame&, void* const)

native function Actor GetTarget();  // Export UTgAISquad::execGetTarget(FFrame&, void* const)

native function TgPawn GetTargetPawn();  // Export UTgAISquad::execGetTargetPawn(FFrame&, void* const)

native function SuggestDropTarget(Actor TargetToDrop, TgAIController requester);  // Export UTgAISquad::execSuggestDropTarget(FFrame&, void* const)

native function DropTarget(Actor TargetToDrop);  // Export UTgAISquad::execDropTarget(FFrame&, void* const)

native function UpdateTargetList(float DeltaTime);  // Export UTgAISquad::execUpdateTargetList(FFrame&, void* const)

native function SuggestEvade();  // Export UTgAISquad::execSuggestEvade(FFrame&, void* const)

native function Evade();  // Export UTgAISquad::execEvade(FFrame&, void* const)

native function NotifyTargetChanged();  // Export UTgAISquad::execNotifyTargetChanged(FFrame&, void* const)

native function NotifyEvade();  // Export UTgAISquad::execNotifyEvade(FFrame&, void* const)

event OnSquadCreated() { }

defaultproperties
{
    s_bShouldSpread=true
}
