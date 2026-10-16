class TgGame_Arena_Capture extends TgGame_Arena
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

var int s_nCaptureHostilePointXP;
var int s_nCaptureHostilePointGold;
var int s_nReclaimPointXP;
var int s_nReclaimPointGold;
var int m_nCurrentActiveCapturePointIndex;
var float m_fNewPointTime;

event PostBeginPlay() { }

event ChangeTimerState(TgObject.GameTimerState eTimerState) { }

native function CapturedPoint(TgPawn_Character PC);  // Export UTgGame_Arena_Capture::execCapturedPoint(FFrame&, void* const)

native function CapturePointReclaimed(TgPawn_Character PC);  // Export UTgGame_Arena_Capture::execCapturePointReclaimed(FFrame&, void* const)

function SpawnNeutralBots() { }

function OnPointCaptureOwnershipChanged(TgCapturePoint Point, int NewTaskForceOwner, int PreviousTaskForceOwner) { }

function UpdateLockedPointStatus() { }

defaultproperties
{
    m_nCurrentActiveCapturePointIndex=-1
    m_fNewPointTime=5.0000000
    m_GameType=TGT_ARENA_CAPTURE
}
