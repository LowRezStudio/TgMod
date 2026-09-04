class UIHudScoreboard extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UISCOREBOARD_CARDS = 5;

const UISCOREBOARD_ITEMS = 4;

const UISCOREBOARD_STATS = 5;

const UISCOREBOARD_PLAYERS = 5;

const UISCOREBOARD_TABS = 3;

enum ScoreboardTabs {
    UIST_Items,  // 0
    UIST_Loadouts,  // 1
    UIST_Overview,  // 2
};

struct ScoreInfo {
    var int nCard[5];
    var int nItem[4];
    var int nItemLevel[4];
    var int nTalent;
    var int nTalentXPos;
    var int nTalentYPos;
    var int nPlayerId;
    var UniqueNetId ConsoleUniqueId;
    var GFxObject pObj;
    var GFxObject Name;
    var GFxObject EquipableTitle;
    var GFxObject Icon;
    var GFxObject Mute;
    var GFxObject Bounds;
    var GFxObject Charge;
    var GFxObject Killstreak;
    var GFxObject Respawn;
    var GFxObject Champion;
    var GFxObject TalentButton;
    var GFxObject TalentIcon;
    var GFxObject ItemBacks;
    var GFxObject Card[5];
    var GFxObject CardIcon[5];
    var GFxObject Item[4];
    var GFxObject ItemBase[4];
    var GFxObject ItemIcon[4];
    var int nItemXPos[4];
    var int nItemYPos[4];
    var UIComponent_AbilityPointsPool AbilityPoints;
    var GFxObject KDA;
    var GFxObject MuteVoice;
    structdefaultproperties {}
};

var const int m_nFirstRowIconHeight;
var const int m_nRowSpacing;
var const int m_nTalentXOffset;
var const int m_nFirstItemXOffset;
var const int m_nItemSpacing;
var int m_nBestStreak;
var ScoreInfo m_RedScore[5];
var ScoreInfo m_BlueScore[5];
var UIComponent_ItemTooltip m_ItemTooltip;
var GFxObject m_mcStats;
var GFxObject m_mcTitle;
var GFxObject m_mcTitles;
var GFxObject m_mcMuteVoiceGamepadPrompt;
var GFxObject m_mcViewProfilePrompt;
var GFxObject m_mcHighlight;
var GFxObject m_mcStat[5];
var TgGFxGroup m_grPlayers;
var GFxObject m_mcTabs[3];
var GFxObject m_mcTabKey[3];
var GFxObject m_mcTabTitles[3];
var UIHudScoreboard.ScoreboardTabs m_eCurrentTab;

defaultproperties
{
    m_nFirstRowIconHeight=410
    m_nRowSpacing=70
    m_nTalentXOffset=196
    m_nFirstItemXOffset=636
    m_nItemSpacing=50
    m_OptionList[0]=249
    m_bBlur=true
    m_bAlwaysTick=true
    m_bCaptureKeys=false
    m_Name="UIHudScoreboard"
}
