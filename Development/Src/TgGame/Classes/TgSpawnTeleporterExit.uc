class TgSpawnTeleporterExit extends Actor
    native(Navigation)
    placeable
    hidecategories(Navigation)
    config(Engine);

const TGSPAWNTELEPORTEREXIT_TARGETHEIGHT = 128;

var () int nTaskForce;
var () int nLane;
var () int nGamePhase;
var () int nPriority;
var () bool bEnabled;

native function bool HasRoomForPawn(TgPawn TgP);  // Export UTgSpawnTeleporterExit::execHasRoomForPawn(FFrame&, void* const)

native simulated function vector GetTargetLocation(optional actor RequestedBy, optional bool bRequestAlternateLoc);  // Export UTgSpawnTeleporterExit::execGetTargetLocation(FFrame&, void* const)

simulated function OnToggle(SeqAct_Toggle Action) { }

function bool PawnCanUse(TgPawn TgP) { }

defaultproperties
{
    bEnabled=true
    Components[0]=none
    Components[1]=none
}
