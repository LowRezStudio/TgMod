class TgGameDC_Team extends TgDataChunk within GFxMoviePlayer
    native(GameUI)
    config(Engine);

const DCTEAM_MAX_MEMBERS = 5;

const DCTEAM_MAX_TOWERS = 9;

var int m_nTaskForce;
var TgGameDC_Player m_Members[5];
var int m_nMaxMemberCount;
var TgGameDC_Guardian m_Guardian;
var TgGameDC_Tower m_Towers[9];
var TgSynchronizedTimer m_SurrenderTimer;

native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);  // Export UTgGameDC_Team::execInitializeData(FFrame&, void* const)

native function NotifyMapChange();  // Export UTgGameDC_Team::execNotifyMapChange(FFrame&, void* const)

native function UpdateMembers(TgRepInfo_TaskForce tfri);  // Export UTgGameDC_Team::execUpdateMembers(FFrame&, void* const)

native function UpdatePlayerStat(TgPawn changedPawn);  // Export UTgGameDC_Team::execUpdatePlayerStat(FFrame&, void* const)

native function bool UpdatePlayerItemStoreItems(TgRepInfo_Player PRI);  // Export UTgGameDC_Team::execUpdatePlayerItemStoreItems(FFrame&, void* const)

native function bool UpdatePlayerSurrender(TgRepInfo_Player PRI);  // Export UTgGameDC_Team::execUpdatePlayerSurrender(FFrame&, void* const)
