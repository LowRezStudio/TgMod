class TgGame_Domination extends TgGame_PointCapture
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var float m_fRespawnTime;

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Domination::execGetRespawnTime(FFrame&, void* const)

function UpdateLockedPointStatus() { }

function CheckPointLocked(TgCapturePoint Point) { }

defaultproperties
{
    m_fRespawnTime=20.0000000
    m_GameType=TGT_DOMINATION
    GoalScore=500
}
