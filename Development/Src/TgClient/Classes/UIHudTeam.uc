class UIHudTeam extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine)
    dependson(UIHudCards);

const UIHUDTEAM_COUNT = 5;

const UIHUDTEAM_STATS = 10;

const UIHUDTEAM_LOADOUTSIZE = 5;

const UIHUDTEAM_ITEMSLOTS = 4;

const UIHUDTEAM_STREAK_MIN_STREAK = 5;

const UIHUDTEAM_STREAK_FADE_CEILING = 20;

enum UIHudTeamDisplayMode {
    TeamDisplayMode_Top,  // 0
    TeamDisplayMode_SidesWithItems,  // 1
    TeamDisplayMode_SidesWithCards,  // 2
    TeamDisplayMode_KDA,  // 3
};

enum UIHudTeamStatsMode {
    TeamStatsMode_Credits,  // 0
    TeamStatsMode_Damage,  // 1
    TeamStatsMode_Shielding,  // 2
    TeamStatsMode_Healing,  // 3
    TeamStatsMode_ObjectiveTime,  // 4
};

enum UIHudTeamAnimGroup {
    TeamAnimGroup_Team,  // 0
    TeamAnimGroup_Stats,  // 1
};

struct TEAMPLAYER_INFO {
    var int nRespawn;
    var bool bHealth;
    var bool bRespawn;
    var bool bVisible;
    var float fHealth;
    var float fRespawn;
    var int nUlt;
    var bool bSelected;
    var init string sIcon;
    var float fUltIconScale;
    var GFxObject pObj;
    var GFxObject pIcon;
    var GFxObject pIconDead;
    var GFxObject pHealth;
    var GFxObject pHealthTip;
    var GFxObject pHealthBG;
    var float fHealthBarWidth;
    var GFxObject pRespawn;
    var GFxObject pDeadX;
    var GFxObject pUlt;
    var GFxObject pUltReady;
    var GFxObject pSelected;
    var int nStreak;
    var float fStreakAnimOffset;
    var GFxObject pStreak;
    var GFxObject pStreakAdd1;
    var GFxObject pStreakAdd2;
    var GFxObject pStreakCount;
    structdefaultproperties {}
};

struct TEAMPLAYER_INFO_EXTENDED extends TEAMPLAYER_INFO {
    var bool bItemsVisible;
    var bool bCardsVisible;
    var UICardDisplayGroup CardDisplayGroup;
    var init string sPlayerName;
    var GFxObject pPlayerName;
    var int nCredits;
    var GFxObject pCredits;
    var int nKills;
    var int nDeaths;
    var int nAssists;
    var GFxObject pKDA;
};

struct TEAMSTAT_INFO {
    var GFxObject pObj;
    var GFxObject pIcon;
    var GFxObject pText;
    var GFxObject pTip;
    var GFxObject pBar;
    var GFxObject pBackground;
    var GFxObject pMask;
    var init string sIcon;
    var float fMaskBaseWidth;
    structdefaultproperties {}
};

var bool m_bShowPlayers;
var string m_sSpectatingText;
var GFxObject m_mcSpectating;
var GFxObject m_mcSpectatingTF;
var GFxObject m_mcPlayers;
var TEAMPLAYER_INFO m_mcPlayerRed[5];
var TEAMPLAYER_INFO m_mcPlayerBlue[5];
var GFxObject m_mcTeamBlueName;
var GFxObject m_mcTeamBlueScore;
var GFxObject m_mcTeamRedName;
var GFxObject m_mcTeamRedScore;
var GFxObject m_mcTeamBlueTopBG;
var GFxObject m_mcTeamRedTopBG;
var GFxObject m_mcPlayersSide;
var GFxObject m_mcPlayersSideBlueBG;
var GFxObject m_mcPlayersSideRedBG;
var TEAMPLAYER_INFO_EXTENDED m_mcPlayerSideRed[5];
var TEAMPLAYER_INFO_EXTENDED m_mcPlayerSideBlue[5];
var GFxObject m_mcStats;
var GFxObject m_mcStatsTitle;
var TEAMSTAT_INFO m_mcStatsEntry[10];
var GFxObject m_mcRespawn;
var TEAMPLAYER_INFO m_mcRespawnRed[5];
var TEAMPLAYER_INFO m_mcRespawnBlue[5];
var int m_nSpectatorMode;
var int m_nStatsMode;
var float m_fStatsUpdateTimer;

event HandleAnimState(int nAnimState, optional int nAnimGroup=0) { }

event TransitionTeamTop(bool bShow, float fAnimTime) { }

event TransitionTeamSides(bool bShow, float fAnimTime) { }

event TransitionStats(bool bShow, float fAnimTime) { }

native function TransitionTeamSidesSizing(bool bSmall, optional float fAnimTime=0.2500000);  // Export UUIHudTeam::execTransitionTeamSidesSizing(FFrame&, void* const)

defaultproperties
{
    m_eSnappingType=UISNAPPING_TOP
    m_bVisibleOnLoad=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudTeam"
}
