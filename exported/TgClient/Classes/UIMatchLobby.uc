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

enum UIMatchLobbyDisplayState
{
    UIMLS_Champions,                // 0
    UIMLS_Choose_Champion_Me,       // 1
    UIMLS_Chosen_Not_Locked,        // 2
    UIMLS_LockIn,                   // 3
    UIMLS_Customize,                // 4
    UIMLS_Banning_Me,               // 5
    UIMLS_Banning_Team,             // 6
    UIMLS_Banning_Enemy,            // 7
    UIMLS_MAX                       // 8
};

enum UIPLAYERMATCHSTATE
{
    UICPS_NONE,                     // 0
    UICPS_WAITING,                  // 1
    UICPS_PICKING,                  // 2
    UICPS_PICKED,                   // 3
    UICPS_MAX                       // 4
};

enum UITRADINGSTATE
{
    UITRS_NONE,                     // 0
    UITRS_WAITING,                  // 1
    UITRS_PENDING,                  // 2
    UITRS_MAX                       // 3
};

enum UICHAMPIONMATCHSTATE
{
    UICMS_NONE,                     // 0
    UICMS_LOCKED,                   // 1
    UICMS_AVAILABLE,                // 2
    UICMS_CHOSEN,                   // 3
    UICMS_BANNED,                   // 4
    UICMS_MAX                       // 5
};

struct native UICHAMPIONMATCHDATA
{
    var int nBotId;
    var byte eState;

    structdefaultproperties
    {
        nBotId=0
        eState=0
    }
};

struct native UIMatchLobbyPlayerCustomize
{
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

    structdefaultproperties
    {
        nBotId=0
        nSkinId=0
        nHeadId=0
        nWeaponDeviceId=0
        nWeaponSkinId=0
        nVoiceId=0
        nEmoteId=0
        nMVPPoseId=0
        nSprayId=0
        nPedestalSkinId=0
    }
};

struct native UIPLAYERMATCHDATA
{
    var int nPlayerId;
    var int nIndex;
    var byte eState;
    var bool bLocal;
    var bool bRed;
    var float fArrowTimer;
    var float fShowTimerA;
    var float fShowTimerB;
    var float fPlayerTimer[4];

    structdefaultproperties
    {
        nPlayerId=0
        nIndex=0
        eState=0
        bLocal=false
        bRed=false
        fArrowTimer=0.0000000
        fShowTimerA=0.0000000
        fShowTimerB=0.0000000
        fPlayerTimer[0]=0.0000000
        fPlayerTimer[1]=0.0000000
        fPlayerTimer[2]=0.0000000
        fPlayerTimer[3]=0.0000000
    }
};

struct native UIMatchLobbyChampionDisplayData
{
    var native Pointer ChampionData;
    var GFxObject Champion;
    var GFxObject ChampionIcon;
    var GFxObject ChampionFrame;
    var GFxObject ChampionRented;
    var GFxObject ChampionRotation;
    var GFxObject ChampionRecommended;
    var GFxObject ChampionClassIcon;

    structdefaultproperties
    {
        Champion=none
        ChampionIcon=none
        ChampionFrame=none
        ChampionRented=none
        ChampionRotation=none
        ChampionRecommended=none
        ChampionClassIcon=none
    }
};

struct native UIMatchLobbyTeam
{
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

    structdefaultproperties
    {
        mcTeam=none
        mcPlayer[0]=none
        mcPlayer[1]=none
        mcPlayer[2]=none
        mcPlayer[3]=none
        mcPlayer[4]=none
        mcPlayerHighlight[0]=none
        mcPlayerHighlight[1]=none
        mcPlayerHighlight[2]=none
        mcPlayerHighlight[3]=none
        mcPlayerHighlight[4]=none
        mcPlayerGlow[0]=none
        mcPlayerGlow[1]=none
        mcPlayerGlow[2]=none
        mcPlayerGlow[3]=none
        mcPlayerGlow[4]=none
        mcPlayerName[0]=none
        mcPlayerName[1]=none
        mcPlayerName[2]=none
        mcPlayerName[3]=none
        mcPlayerName[4]=none
        mcPlayerIcon[0]=none
        mcPlayerIcon[1]=none
        mcPlayerIcon[2]=none
        mcPlayerIcon[3]=none
        mcPlayerIcon[4]=none
        mcPlayerFrame[0]=none
        mcPlayerFrame[1]=none
        mcPlayerFrame[2]=none
        mcPlayerFrame[3]=none
        mcPlayerFrame[4]=none
        mcPlayerClass[0]=none
        mcPlayerClass[1]=none
        mcPlayerClass[2]=none
        mcPlayerClass[3]=none
        mcPlayerClass[4]=none
        mcPlayerClassIcon[0]=none
        mcPlayerClassIcon[1]=none
        mcPlayerClassIcon[2]=none
        mcPlayerClassIcon[3]=none
        mcPlayerClassIcon[4]=none
        mcPlayerTitle[0]=none
        mcPlayerTitle[1]=none
        mcPlayerTitle[2]=none
        mcPlayerTitle[3]=none
        mcPlayerTitle[4]=none
        mcPlayerTrade[0]=none
        mcPlayerTrade[1]=none
        mcPlayerTrade[2]=none
        mcPlayerTrade[3]=none
        mcPlayerTrade[4]=none
        mcPlayerSelect[0]=none
        mcPlayerSelect[1]=none
        mcPlayerSelect[2]=none
        mcPlayerSelect[3]=none
        mcPlayerSelect[4]=none
        mcPlayerLocked[0]=none
        mcPlayerLocked[1]=none
        mcPlayerLocked[2]=none
        mcPlayerLocked[3]=none
        mcPlayerLocked[4]=none
        mcPlayerArrows[0]=none
        mcPlayerArrows[1]=none
        mcPlayerArrows[2]=none
        mcPlayerArrows[3]=none
        mcPlayerArrows[4]=none
        mcPlayerChampion[0]=none
        mcPlayerChampion[1]=none
        mcPlayerChampion[2]=none
        mcPlayerChampion[3]=none
        mcPlayerChampion[4]=none
        mcPlayerIconAnim[0]=none
        mcPlayerIconAnim[1]=none
        mcPlayerIconAnim[2]=none
        mcPlayerIconAnim[3]=none
        mcPlayerIconAnim[4]=none
        mcPlayerFrameAnim[0]=none
        mcPlayerFrameAnim[1]=none
        mcPlayerFrameAnim[2]=none
        mcPlayerFrameAnim[3]=none
        mcPlayerFrameAnim[4]=none
        mcPlayerChampionAnim[0]=none
        mcPlayerChampionAnim[1]=none
        mcPlayerChampionAnim[2]=none
        mcPlayerChampionAnim[3]=none
        mcPlayerChampionAnim[4]=none
        mcPlayerSpeakingIcon[0]=none
        mcPlayerSpeakingIcon[1]=none
        mcPlayerSpeakingIcon[2]=none
        mcPlayerSpeakingIcon[3]=none
        mcPlayerSpeakingIcon[4]=none
        mcPlayerMuteVoice[0]=none
        mcPlayerMuteVoice[1]=none
        mcPlayerMuteVoice[2]=none
        mcPlayerMuteVoice[3]=none
        mcPlayerMuteVoice[4]=none
        grPlayers=none
    }
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
    m_akSelect=AkEvent'WW_UI_Default.UI_Lobby_MatchSetUp_CharSelect_Play'
    m_akRollover=AkEvent'WW_UI_Default.UI_Lobby_MatchSetUp_CheckBox_Play'
    m_akTabChange=AkEvent'WW_UI_Default.UI_Lobby_MatchSetUp_Customize_SwitchTabs_Play'
    m_akCountdown=AkEvent'WW_UI_Default.UI_Lobby_MatchSetUp_Countdown_Play'
    m_akLockInSelf=AkEvent'WW_UI_Default.UI_Lobby_MatchSetUp_LockIn_Self_Play'
    m_akLockInEnemy=AkEvent'WW_UI_Default.UI_Lobby_MatchSetUp_LockIn_EnemyTeam_Play'
    m_akLockInFriend=AkEvent'WW_UI_Default.UI_Lobby_MatchSetUp_LockIn_Team_Play'
    m_nTencentRecommendedChampions[0]=2249
    m_nTencentRecommendedChampions[1]=2277
    m_nTencentRecommendedChampions[2]=2071
    m_UISceneClass=Class'TgClient.UIScene_UIMatchLobby'
    m_Name="UIMatchLobby"
}