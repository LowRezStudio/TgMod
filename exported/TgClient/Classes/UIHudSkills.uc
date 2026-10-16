class UIHudSkills extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIHUDSKILLS_BARS = 3;
const UIHUDSKILLS_CARDS = 5;

enum UIHudSkillsSpectatorMode
{
    SkillsSpecatorMode_Skills,      // 0
    SkillsSpecatorMode_Items,       // 1
    SkillsSpecatorMode_Cards,       // 2
    SkillsSpecatorMode_MAX          // 3
};

var bool m_bPrompt;
var bool m_bShownBurn;
var bool m_bPromptK;
var bool m_bShownLoadout;
var CastingInfo m_MountBar;
var CastingInfo m_CastBar[3];
var GFxObject m_mcPrompt;
var GFxObject m_mcPromptK;
var int m_nCredits;
var GFxObject m_mcSpectatorCredits;
var GFxObject m_mcSpectatorItemsGroup;
var GFxObject m_mcSpectatorCardsGroup;
var UICardDisplayGroup m_CardDisplayGroup;
var int m_nSpectatorMode;

defaultproperties
{
    m_UISceneClass=Class'TgClient.UIScene_UIHudSkills'
    m_eSnappingType=UISNAPPINGTYPE.UISNAPPING_BOT
    m_bVisibleOnLoad=true
    m_bAlwaysTick=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_bCanShake=true
    m_Name="UIHudSkills"
}