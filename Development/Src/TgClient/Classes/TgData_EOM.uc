class TgData_EOM extends TgDataObject
    native(UIData)
    config(Engine);

const TGDATA_EOM_TEAMCOUNT = 2;

struct AccoladeData {
    var int nMsgId;
    var int nPlace;
    var int nValue;
    structdefaultproperties {}
};

struct UIMVPDATA {
    var int nBot;
    var int nBody;
    var int nHead;
    var int nType;
    var int nFrame;
    var int nLevel;
    var int nValue;
    var int nWeapon;
    var UIData_PlayerMatchRecord pPlayer;
    structdefaultproperties {}
};

var int m_nFWOTD;
var int m_nGameId;
var int m_nQueueId;
var int m_nClassId;
var int m_nGameTime;
var int m_nXPEarned;
var float m_fXPMultiplier;
var int m_nXPBonus;
var int m_nXPAccountBoost;
var int m_nXPPartyBoost;
var int m_nXPVipBoost;
var int m_nGoldEarned;
var float m_fGoldMultiplier;
var int m_nGoldBonus;
var int m_nGoldAccolades;
var int m_nGoldAccountBoost;
var int m_nGoldPartyBoost;
var int m_nMasteryEarned;
var int m_nMasteryAccountBoost;
var int m_nMasteryPartyBoost;
var int m_nLocalTF;
var int m_nWinningTF;
var bool m_bVictory;
var string m_sMapName;
var array<UIData_PlayerMatchRecord> m_Players;
var array<UIMVPDATA> m_MVPs;
var array<AccoladeData> m_Accolades;
