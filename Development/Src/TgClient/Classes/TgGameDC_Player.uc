class TgGameDC_Player extends TgGameDC_MapEntity within GFxMoviePlayer
    native(GameUI)
    config(Engine);

var int m_nStatCount;
var TgSynchronizedTimer m_ReviveTimer;
var TgSynchronizedTimer m_UltimateTimer;
var float m_PrevUltTimer;
var GFxObject m_StatsArray;
var GFxObject m_ItemStoreArray;
var GFxObject m_ActiveItemArray;
var GFxObject m_ConsumableArray;

native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);  // Export UTgGameDC_Player::execInitializeData(FFrame&, void* const)

native function SetDirty();  // Export UTgGameDC_Player::execSetDirty(FFrame&, void* const)

native function UpdatePlayer(TgRepInfo_Player PRI);  // Export UTgGameDC_Player::execUpdatePlayer(FFrame&, void* const)

native function UpdateStats(TgPawn changedPawn);  // Export UTgGameDC_Player::execUpdateStats(FFrame&, void* const)

native function UpdateItemStoreItems(TgRepInfo_Player PRI);  // Export UTgGameDC_Player::execUpdateItemStoreItems(FFrame&, void* const)

native function NotifyMapChange();  // Export UTgGameDC_Player::execNotifyMapChange(FFrame&, void* const)

delegate USC_ForceStatsUpdate_Delegate();

native function USC_ForceStatsUpdate();  // Export UTgGameDC_Player::execUSC_ForceStatsUpdate(FFrame&, void* const)
