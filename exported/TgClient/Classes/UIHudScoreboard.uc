class UIHudScoreboard extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UISCOREBOARD_CARDS = 5;
const UISCOREBOARD_ITEMS = 4;
const UISCOREBOARD_STATS = 5;
const UISCOREBOARD_PLAYERS = 5;
const UISCOREBOARD_TABS = 3;

enum ScoreboardTabs
{
    UIST_Items,                     // 0
    UIST_Loadouts,                  // 1
    UIST_Overview,                  // 2
    UIST_MAX                        // 3
};

struct native ScoreInfo
{
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

    structdefaultproperties
    {
        nCard[0]=0
        nCard[1]=0
        nCard[2]=0
        nCard[3]=0
        nCard[4]=0
        nItem[0]=0
        nItem[1]=0
        nItem[2]=0
        nItem[3]=0
        nItemLevel[0]=0
        nItemLevel[1]=0
        nItemLevel[2]=0
        nItemLevel[3]=0
        nTalent=0
        nTalentXPos=0
        nTalentYPos=0
        nPlayerId=0
        ConsoleUniqueId=(Uid=())
        pObj=none
        Name=none
        EquipableTitle=none
        Icon=none
        Mute=none
        Bounds=none
        Charge=none
        Killstreak=none
        Respawn=none
        Champion=none
        TalentButton=none
        TalentIcon=none
        ItemBacks=none
        Card[0]=none
        Card[1]=none
        Card[2]=none
        Card[3]=none
        Card[4]=none
        CardIcon[0]=none
        CardIcon[1]=none
        CardIcon[2]=none
        CardIcon[3]=none
        CardIcon[4]=none
        Item[0]=none
        Item[1]=none
        Item[2]=none
        Item[3]=none
        ItemBase[0]=none
        ItemBase[1]=none
        ItemBase[2]=none
        ItemBase[3]=none
        ItemIcon[0]=none
        ItemIcon[1]=none
        ItemIcon[2]=none
        ItemIcon[3]=none
        nItemXPos[0]=0
        nItemXPos[1]=0
        nItemXPos[2]=0
        nItemXPos[3]=0
        nItemYPos[0]=0
        nItemYPos[1]=0
        nItemYPos[2]=0
        nItemYPos[3]=0
        AbilityPoints=none
        KDA=none
        MuteVoice=none
    }
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