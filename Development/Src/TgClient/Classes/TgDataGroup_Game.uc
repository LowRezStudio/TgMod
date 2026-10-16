class TgDataGroup_Game extends TgDataChunk within GFxMoviePlayer
    native(GameUI)
    config(Engine);

var TgGameDC_LocalPlayer m_PlayerData;
var TgGameDC_Target m_TargetData;
var TgGameDC_PlayerVitals m_PlayerVitals;
var TgGameDC_Game m_GameData;
var TgGameDC_DeviceList m_DevicesData;
var TgGameDC_EffectList m_EffectData;

native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);  // Export UTgDataGroup_Game::execInitializeData(FFrame&, void* const)

native function NotifyMapChange();  // Export UTgDataGroup_Game::execNotifyMapChange(FFrame&, void* const)
