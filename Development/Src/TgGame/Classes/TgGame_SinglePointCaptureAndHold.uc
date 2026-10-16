class TgGame_SinglePointCaptureAndHold extends TgGame_PointCapture
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var int m_nCurrentActiveCapturePointIndex;
var int m_nNumTicketsForCapturingPoint;
var int m_nNumTicketsForHoldingPoint;
var float m_fNewPointTime;
var float m_fDefendingTeamRespawnTime;

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_SinglePointCaptureAndHold::execGetRespawnTime(FFrame&, void* const)

function SpawnNeutralBots() { }

function OnPointCaptureOwnershipChanged(TgCapturePoint Point, int NewTaskForceOwner, int PreviousTaskForceOwner) { }

function CheckTickets() { }

function UpdateLockedPointStatus() { }

defaultproperties
{
    m_nCurrentActiveCapturePointIndex=-1
    m_nNumTicketsForHoldingPoint=1
    m_fNewPointTime=5.0000000
    m_fDefendingTeamRespawnTime=40.0000000
    m_GameType=TGT_SINGLEPOINTCAPTUREANDHOLD
    GoalScore=100
}
