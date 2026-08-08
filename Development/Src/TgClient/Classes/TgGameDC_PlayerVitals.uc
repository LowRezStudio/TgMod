class TgGameDC_PlayerVitals extends TgGameDC_MapEntity within GFxMoviePlayer
    native(GameUI)
    config(Engine);

var float m_fHealth;
var float m_fHealthMax;
var float m_fEnergy;
var float m_fEnergyMax;
var float m_fBoost;
var float m_fBoostMax;
var float m_fMana;
var float m_fManaMax;
var float m_fHealthPct;
var float m_fEnergyPct;
var float m_fBoostPct;
var float m_fManaPct;
var float m_fXPPct;
var int m_nLevel;
var TgSynchronizedTimer m_ReviveTimer;
var TgSynchronizedTimer m_RefireTimer;
var TgSynchronizedTimer m_RecallTimer;

native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);  // Export UTgGameDC_PlayerVitals::execInitializeData(FFrame&, void* const)

native function NotifyMapChange();  // Export UTgGameDC_PlayerVitals::execNotifyMapChange(FFrame&, void* const)

native function UpdateDamageDone();  // Export UTgGameDC_PlayerVitals::execUpdateDamageDone(FFrame&, void* const)

native function UpdateCoreStats();  // Export UTgGameDC_PlayerVitals::execUpdateCoreStats(FFrame&, void* const)
