class TgGame_Paladins extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);


var config int m_nGoalScore;
var transient int m_nTF1Score;
var transient int m_nTF2Score;
var config transient int m_nWinningScore;
var bool m_bScoringEnabled;
var config bool m_bCanPurchaseItemsAnywhere;
var config bool m_bLimitBurnCardsToOnePerCategory;
var config bool m_bAutoMountOnRespawn;
var config bool m_bDropHealthNuggetOnDeath;
var bool m_bRespawnBots;
var config bool m_bDisableKillcam;
var config bool m_bCanApplyCardEquipStats;
var config bool m_bTalentsEnabled;
var config bool m_bAutoMountAtRoundBegin;
var config bool m_bResetPlayersNotInSpawnRoom;
var config bool m_bDeckSwappingAlwaysEnabled;
var bool m_bDiminishingReturnsOnCCEnabled;
var int m_nCanSpoolCredits;
var const float m_fPlayerWaitTime;
var int m_nHealthNuggetDeployableId;
var int m_nHealthNuggetTeamOnlyDeployableId;
var int m_fHealthNuggetPersistTime;
var config float m_fPlayerViewDistance;
var config float m_fVisibilityVolumeViewDistance;
var float m_fCardCooldownIncrease;
var config float m_fCardCooldownMultiplier;
var config float m_fGameTypeReminderTime;
var config float m_fRespawnBeaconLifeSpan;
var config float m_fBaseRespawnTime;
var const float m_fMapLaneChangeDelay;
var config int m_nStartingCredits;
var config int m_nMaxCredits;
var config string m_GameplayEventsWriterClassName;
var GameplayEventsWriter GameplayEventsWriter;
var config float m_fFlankerSoloKillRewardDistance;
var config float m_fDamageRoleMultiplier;
var config float m_fFlankRoleMultiplier;
var config float m_fFrontLineRoleMultiplier;
var config float m_fSupportRoleMultiplier;
var int m_nNextUniquePlayerID;

// Export UTgGame_Paladins::execBeginEndMission(FFrame&, void* const)
native function bool BeginEndMission(optional bool bClearNextMapGame = false, optional Actor EndMissionFocus, optional float fDelayOverride = 0.0000000);