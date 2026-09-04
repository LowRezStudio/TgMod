class UIMatchLobby extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Game);

const UIMATCHLOBBY_TEAMS = 2;

const UIMATCHLOBBY_PLAYERS = 5;

const UIMATCHLOBBY_MAXPICKS = 2;

const UIMATCHLOBBY_CHAMPIONS = 39;

const UIMATCHLOBBY_CHAMPION_ROWS = 3;

const UIMATCHLOBBY_ROLE_TABS = 5;

const UIMATCHLOBBY_ARCHETYPES = 4;

const UIMATCHLOBBY_ROLETYPES = 4;

const UIMATCHLOBBY_CUSTOMIZES = 8;

const UIMATCHLOBBY_SELECTIONS = 16;

const UIMATCHLOBBY_TIMERSTATE = 4;

const UIMATCHLOBBY_INDEXSTATE = 2;

const UIMATCHLOBBY_BAN_COUNT = 3;

const UIMATCHLOBBY_TEAM_TIPS = 2;

enum UIMatchLobbyDisplayState {
    UIMLS_Champions,  // 0
    UIMLS_Choose_Champion_Me,  // 1
    UIMLS_Chosen_Not_Locked,  // 2
    UIMLS_LockIn,  // 3
    UIMLS_Customize,  // 4
    UIMLS_Banning_Me,  // 5
    UIMLS_Banning_Team,  // 6
    UIMLS_Banning_Enemy,  // 7
};

enum UIPLAYERMATCHSTATE {
    UICPS_NONE,  // 0
    UICPS_WAITING,  // 1
    UICPS_PICKING,  // 2
    UICPS_PICKED,  // 3
};

enum UITRADINGSTATE {
    UITRS_NONE,  // 0
    UITRS_WAITING,  // 1
    UITRS_PENDING,  // 2
};

enum UICHAMPIONMATCHSTATE {
    UICMS_NONE,  // 0
    UICMS_LOCKED,  // 1
    UICMS_AVAILABLE,  // 2
    UICMS_CHOSEN,  // 3
    UICMS_BANNED,  // 4
};

struct UICHAMPIONMATCHDATA {
    var int nBotId;
    var byte eState;
    structdefaultproperties {}
};

struct UIMatchLobbyPlayerCustomize {
    var int nBotId;
    var int nSkinId;
    var int nHeadId;
    var int nWeaponDeviceId;
    var int nWeaponSkinId;
    var int nVoiceId;
    var int nEmoteId;
    var int nMVPPoseId;
    var int nSprayId;
    var int nPedestalSkinId;
    structdefaultproperties {}
};

struct UIPLAYERMATCHDATA {
    var int nPlayerId;
    var int nIndex;
    var byte eState;
    var bool bLocal;
    var bool bRed;
    var float fArrowTimer;
    var float fShowTimerA;
    var float fShowTimerB;
    var float fPlayerTimer[4];
    structdefaultproperties {}
};

struct UIMatchLobbyChampionDisplayData {
    var Pointer ChampionData;
    var GFxObject Champion;
    var GFxObject ChampionIcon;
    var GFxObject ChampionFrame;
    var GFxObject ChampionRented;
    var GFxObject ChampionRotation;
    var GFxObject ChampionRecommended;
    var GFxObject ChampionClassIcon;
    structdefaultproperties {}
};

struct UIMatchLobbyTeam {
    var GFxObject mcTeam;
    var GFxObject mcPlayer[5];
    var GFxObject mcPlayerHighlight[5];
    var GFxObject mcPlayerGlow[5];
    var GFxObject mcPlayerName[5];
    var GFxObject mcPlayerIcon[5];
    var GFxObject mcPlayerFrame[5];
    var GFxObject mcPlayerClass[5];
    var GFxObject mcPlayerClassIcon[5];
    var GFxObject mcPlayerTitle[5];
    var GFxObject mcPlayerTrade[5];
    var GFxObject mcPlayerSelect[5];
    var GFxObject mcPlayerLocked[5];
    var GFxObject mcPlayerArrows[5];
    var GFxObject mcPlayerChampion[5];
    var GFxObject mcPlayerIconAnim[5];
    var GFxObject mcPlayerFrameAnim[5];
    var GFxObject mcPlayerChampionAnim[5];
    var GFxObject mcPlayerSpeakingIcon[5];
    var GFxObject mcPlayerMuteVoice[5];
    var TgGFxGroup grPlayers;
    structdefaultproperties {}
};

var UIComponent_HoldPrompt m_HoldPrompt;
var UIMatchLobby.UIMatchLobbyDisplayState m_eMatchLobbyDisplayState;
var byte m_bFriendlyArchetypeSelected[4];
var byte m_bEnemyArchetypeSelected[4];
var byte m_eChampionFilterState;
var UIMatchLobby.UITRADINGSTATE m_eTradingState;
var int m_nPickRed[2];
var int m_nPickBlue[2];
var int m_nMatchTimer;
var int m_bCanTrade[5];
var int m_nBanSelection;
var array<int> m_nBannedChampionsAuto;
var array<int> m_nBannedChampionsBlue;
var array<int> m_nBannedChampionsRed;
var bool m_bFirstPick;
var bool m_bFirstShow;
var bool m_bCustomize;
var bool m_bCustomizeHide;
var bool m_bSelection;
var bool m_bShowTeams;
var bool m_bNextTeams;
var bool m_bShowChampions;
var bool m_bChoseClass;
var float m_fPickAnimTimer;
var float m_fChampOrigScaleX;
var float m_fChampOrigScaleY;
var float m_fRedTitleTimer[4];
var float m_fRedSubtitleTimer[4];
var float m_fBlueTitleTimer[4];
var float m_fBlueSubtitleTimer[4];
var float m_fChampionsTimer[4];
var string m_sRedPickTitle[2];
var string m_sBluePickTitle[2];
var string m_sRedPickSubtitle;
var string m_sBluePickSubtitle;
var array<UIPLAYERMATCHDATA> m_vPlayerData;
var array<UICHAMPIONMATCHDATA> m_vChampionData;
var UIMatchLobbyPlayerCustomize m_AllyCustomize[5];
var UIInteractable_Button m_ChampionCustomizeButton;
var UIPopup_MatchLobbyCustomizeNew m_Customize;
var GFxObject m_mcFooter;
var GFxObject m_mcHeader;
var GFxObject m_mcHeaderTime;
var GFxObject m_mcHeaderTitle;
var GFxObject m_mcHeaderTeamCompBlue[4];
var GFxObject m_mcHeaderTeamCompBlueWarning[4];
var GFxObject m_mcHeaderTeamCompBlueClassInactive[4];
var GFxObject m_mcHeaderTeamCompBlueClassActive[4];
var GFxObject m_mcHeaderTeamCompRed[4];
var GFxObject m_mcHeaderTeamCompRedClassInactive[4];
var GFxObject m_mcHeaderTeamCompRedClassActive[4];
var GFxObject m_mcHeaderTeamTip[2];
var GFxObject m_mcHeaderTeamTipTF[2];
var GFxObject m_mcHeaderTeamTipClassIcon[2];
var GFxObject m_mcHeaderTeamTipClassIconFlash[2];
var int m_nTeamTipArchetypePriorities[4];
var GFxObject m_mcPickRed;
var GFxObject m_mcPickRedTitle[2];
var GFxObject m_mcPickRedSubtitle;
var GFxObject m_mcPickBlue;
var GFxObject m_mcPickBlueTitle[2];
var GFxObject m_mcPickBlueSubtitle;
var GFxObject m_mcTrade;
var GFxObject m_mcTradeTitle;
var GFxObject m_mcTradeCancel;
var GFxObject m_mcTradeAccept;
var GFxObject m_mcTradeBlocker;
var GFxObject m_mcTradeWaiting;
var GFxObject m_mcTradeIconA;
var GFxObject m_mcTradeIconB;
var GFxObject m_mcTradeFrameA;
var GFxObject m_mcTradeFrameB;
var GFxObject m_mcTradePlayerA;
var GFxObject m_mcTradePlayerB;
var TgGFxGroup m_grTradePopup;
var UIMatchLobbyTeam m_Team[2];
var UIMatchLobbyTeam m_TeamNew[2];
var GFxObject m_mcChampionName;
var GFxObject m_mcChampionTitle;
var GFxObject m_mcChampionClassIcon;
var GFxObject m_mcLockIn;
var GFxObject m_mcBack;
var GFxObject m_mcChampions;
var GFxObject m_mcChampionsNew;
var GFxObject m_mcChampionsPickNew;
var GFxObject m_mcChampionsGroupNew;
var GFxObject m_mcChampionsPickAnimANew;
var GFxObject m_mcChampionsPickAnimBNew;
var GFxObject m_mcChampionsDimmer;
var TgGFxGroup m_grChampion;
var GFxObject m_mcTeamBlueNew;
var GFxObject m_mcTeamRedNew;
var GFxObject m_mcBanRedTF;
var GFxObject m_mcBanBlueTF;
var GFxObject m_mcRedBans[3];
var GFxObject m_mcRedBansPortrait[3];
var GFxObject m_mcRedBansFrame[3];
var GFxObject m_mcRedBansIcon[3];
var GFxObject m_mcBlueBans[3];
var GFxObject m_mcBlueBansPortrait[3];
var GFxObject m_mcBlueBansFrame[3];
var GFxObject m_mcBlueBansIcon[3];
var GFxObject m_mcMap;
var GFxObject m_mcMapName;
var GFxObject m_mcMapMode;
var GFxObject m_mcMapIcon;
var GFxObject m_mcRoleTabs[5];
var GFxObject m_mcRoleTabsClassIcon[5];
var GFxObject m_mcRoleTabsSelected[5];
var GFxObject m_mcRoleTabsTF[5];
var GFxObject m_mcRoleTabsWarning[5];
var GFxObject m_mcRoleTabsBumper[2];
var UIMatchLobbyChampionDisplayData m_ChampionDisplays[39];
var int m_nArchetypePedestalSkinIds[4];
var AkBaseSoundObject m_akSelect;
var AkBaseSoundObject m_akRollover;
var AkBaseSoundObject m_akTabChange;
var AkBaseSoundObject m_akCountdown;
var AkBaseSoundObject m_akLockInSelf;
var AkBaseSoundObject m_akLockInEnemy;
var AkBaseSoundObject m_akLockInFriend;
var int m_PreviousLobbyState;
var int m_CurrentLobbyState;
var config array<config int> m_nTencentRecommendedChampions;

defaultproperties
{
    m_nBanSelection=-1
    m_nTeamTipArchetypePriorities[1]=2
    m_nTeamTipArchetypePriorities[2]=1
    m_nTeamTipArchetypePriorities[3]=3
    m_akSelect=AkEvent'UI_Lobby_MatchSetUp_CharSelect_Play'
    m_akRollover=AkEvent'UI_Lobby_MatchSetUp_CheckBox_Play'
    m_akTabChange=AkEvent'UI_Lobby_MatchSetUp_Customize_SwitchTabs_Play'
    m_akCountdown=AkEvent'UI_Lobby_MatchSetUp_Countdown_Play'
    m_akLockInSelf=AkEvent'UI_Lobby_MatchSetUp_LockIn_Self_Play'
    m_akLockInEnemy=AkEvent'UI_Lobby_MatchSetUp_LockIn_EnemyTeam_Play'
    m_akLockInFriend=AkEvent'UI_Lobby_MatchSetUp_LockIn_Team_Play'
    m_nTencentRecommendedChampions[0]=2249
    m_nTencentRecommendedChampions[1]=2277
    m_nTencentRecommendedChampions[2]=2071
    m_UISceneClass=Class'UIScene_UIMatchLobby'
    m_Name="UIMatchLobby"
}
