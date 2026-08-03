class TgGameDC_Effect extends TgDataChunk within GFxMoviePlayer
    native(GameUI);

var int m_nGroup;
var int m_nIcon;
var int m_bBuff;
var int m_bActive;
var int m_nStacks;
var float m_fTimer;
var string m_sIcon;
var string m_sName;
var string m_sDescription;
var TgSynchronizedTimer m_lifeTimer;

// Export UTgGameDC_Effect::execInitializeData(FFrame&, void* const)
native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);

// Export UTgGameDC_Effect::execNotifyMapChange(FFrame&, void* const)
native function NotifyMapChange();
