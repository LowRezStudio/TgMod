class UIPlay extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIPLAY_MAX_MODE_QUEUES = 10;
const UIPLAY_EXTRAS = 32;
const UIPLAY_BUTTONS = 6;
const UIPLAY_WIP_REQUIRED_LEVEL = 15;
const UIPLAY_PVE_REQUIRED_LEVEL = 15;
const QUEST_PANEL_PROGRESS_BAR_EMPTY_FRAME = 43;
const QUEST_PANEL_PROGRESS_BAR_FULL_FRAME = 315;
const UIPLAY_DEFAULT_NUM_PANELS = 6;
const UIPLAY_MAIN_PLAY_PANELS = 5;
const UIPLAY_MULTIQUEUE_PLAY_PANELS = 5;
const UIPLAY_TRAINING_PLAY_PANELS = 5;
const UIPLAY_NUM_FWOTD_ICONS = 3;
const UIPLAY_VISIBLE_REGION_ENTRIES = 6;
const UIPLAY_MAX_REGION_ENTRIES = 12;

enum UIPLAYSTATE
{
    UIPS_NONE,                      // 0
    UIPS_CASUAL,                    // 1
    UIPS_COMPETITIVE,               // 2
    UIPS_TRAINING,                  // 3
    UIPS_MAX                        // 4
};

enum GameModeType
{
    GMT_SIEGE,                      // 0
    GMT_PAYLOAD,                    // 1
    GMT_WIP,                        // 2
    GMT_PVE,                        // 3
    GMT_MAX                         // 4
};

var bool m_bPopup;
var array<int> m_nExtras;
var int m_nWOTDCompleted;
var int m_bWOTDComplete[10];
var GFxObject m_mcHiRezPanel;
var GFxObject m_mcBack;
var GFxObject m_mcIcon;
var GFxObject m_mcTitle;
var GFxObject m_mcHeader;
var GFxObject m_mcSubtitle;
var GFxObject m_mcPopup;
var GFxObject m_mcPopupCancel;
var GFxObject m_mcPopupCancelTitle;
var GFxObject m_mcPopupExtra[32];
var GFxObject m_mcPopupExtraTitle[32];
var TgGFxGroup m_grPopup;
var GFxObject m_mcCompetitive;
var GFxObject m_mcCompetitiveCancel;
var GFxObject m_mcCompetitiveCancelTitle;
var GFxObject m_mcCompetitiveTitle;
var GFxObject m_mcCompetitiveSubtitle;
var GFxObject m_mcDetails;
var GFxObject m_mcQueueButton;
var GFxObject m_mcMultiqueueDesc;
var GFxObject m_mcModesSelected;
var GFxObject m_mcMultiqueueCursor;
var GFxObject m_mcMultiqueueUpDownIndicator;
var GFxObject m_mcControllerPrompt;
var GFxObject m_mcFWOTD;
var GFxObject m_mcFWOTDGoldMaxTF;
var GFxObject m_mcFWOTDIcons[3];
var UIComponent_Dropdown m_RegionDropdown;
var GFxObject m_DropButton;
var GFxObject m_mcInputListener;
var GFxObject m_mcWeeklyQuests;
var int m_nQuestIndices[10];
var const int m_nNumDisplayableQuests;

defaultproperties
{
    m_nNumDisplayableQuests=5
    m_UISceneClass=Class'TgClient.UIScene_UIPlay'
    m_OptionList[0]=245
    m_OptionList[1]=3
    m_OptionList[2]=0
    m_nBackground=1
    m_bBlur=true
    m_bAlwaysTick=true
    m_bIsOnline=true
    m_Name="UIPlay"
}