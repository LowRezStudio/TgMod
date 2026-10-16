class TgGame_Arena_Escort extends TgGame_Arena
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var int m_nSpawnEscortTime;
var int m_nEscortSuccessValue;
var TgSeqEvent_SpawnWise s_pEvt[2];
var TgSeqEvent_Escort_Despawn_Success s_pDespawnEvt[2];

native function SendEscortSpawnAlert(TgRepInfo_TaskForce tfri);  // Export UTgGame_Arena_Escort::execSendEscortSpawnAlert(FFrame&, void* const)

function OnEscortDespawn(int Taskforce) { }

defaultproperties
{
    m_nEscortSuccessValue=14
    m_GameType=TGT_ARENA_ESCORT
}
