class TgGame_Mission extends TgGame
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var bool m_bSpawnInTaskForceArea;
var bool s_bPreGuardianPhasePulsed;
var bool s_bGuardianPhasePulsed;
var bool s_bWasSurrendered;
var bool m_bSurrenderAvailable;
var bool m_bFirstBloodAwarded;
var bool m_bAllowAutoUpgrades;
var bool m_bUsePlayerCharacterIntros;
var bool m_bUseKillEmotes;
var bool m_bNotifyKillCombos;
var float m_fMissionTime;
var float m_fSecondaryMissionTime;
var private const float m_fWaitingForPlayersTime;
var config float m_fSetupTime;
var float m_fPausedAtTime;
var float m_fGameMissionTime;
var float s_MissionTimeAccumulator;
var array<Player> s_ReadyPlayers;
var int s_nReadyMercs;
var config float m_fTickCreditsFreq;
var config float m_fCreditsToGivePerTick;
var int m_nStartingCurrency;
var int m_nStartingLevel;
var int m_nWinBonusXp;
var int m_nWinPlayerXp;
var int m_nLosePlayerXp;
var float m_fGodXpCoefficient;
var float m_fGodXpCoefficientLoss;
var float m_fGodXpWinBonus;
var float m_fFreeVIPWinPoints;
var float m_fFreeVIPLossPoints;
var float m_fPaidVIPWinPoints;
var float m_fPaidVIPLossPoints;
var float m_fBaseTokens;
var float m_fSurrenderTime;
var int m_XPRadius;
var float m_MinionKillerBonus;
var float m_BasePlayerGoldReward;
var float m_fFirstBloodGoldReward;
var float m_fBasePlayerAssistGoldRewardMultipler;
var float m_fBasePlayerAssistXpRewardMultipler;
var float m_fBaseNPCAssistGoldRewardMultipler;
var float m_fBaseNPCAssistXpRewardMultipler;

event PostLogin(PlayerController NewPlayer){}
