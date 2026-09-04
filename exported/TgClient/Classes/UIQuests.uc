class UIQuests extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const QUEST_PANEL_WIDTH = 357;
const QUEST_PANEL_GAP = 20;
const CURRENCY_GOLD = 13256;
const CURRENCY_CRYSTALS = 12687;
const QUEST_PANEL_PROGRESS_BAR_EMPTY_FRAME = 43;
const QUEST_PANEL_PROGRESS_BAR_FULL_FRAME = 315;
const VISIBLE_QUEST_PANELS = 5;

var TgGFxGroup m_grQuestPanels;
var TgGFxGroup m_grQuestRerollPopup;
var GFxObject m_mcGoldMax;
var GFxObject m_mcHeader;
var GFxObject m_mcBack;
var GFxObject m_mcTitle;
var GFxObject m_mcBonusQuest;
var GFxObject m_mcBonusQuestProgress;
var GFxObject m_mcBonusQuestProgressMask;
var GFxObject m_mcBonusQuestProgressText;
var GFxObject m_mcBonusQuestTitle;
var GFxObject m_mcBonusQuestDescription;
var UIComponent_List m_QuestList;
var UIComponent_Quest m_QuestPanels[10];
var GFxObject m_mcPanels;
var UIInteractable_Button m_pPrevButton;
var UIInteractable_Button m_pNextButton;
var GFxObject m_mcActiveQuests;
var GFxObject m_mcNextQuestCountdown;
var int m_nQuestToDiscard;
var GFxObject m_mcDiscardQuestPopup;
var GFxObject m_mcDiscardQuestPopupCloseButton;
var GFxObject m_mcDiscardQuestPopupTitle;
var GFxObject m_mcDiscardQuestPopupQuestIcon;
var GFxObject m_mcDiscardQuestPopupQuestTitle;
var GFxObject m_mcDiscardQuestPopupRerollText;
var GFxObject m_mcDiscardQuestPopupRerollButton;
var GFxObject m_mcDiscardQuestPopupDiscardButton;
var int m_nCurrentlyFocusedQuestPanel;
var int m_nDesiredFocusedQuestPanelButton;
var int m_nCurrentlyFocusedQuestPanelButton;
var int m_nDesiredFocusedDiscardButton;
var int m_nCurrentlyFocusedDiscardButton;
var int m_nQuestIndices[10];

defaultproperties
{
    m_nCurrentlyFocusedQuestPanel=-1
    m_nDesiredFocusedQuestPanelButton=-1
    m_nCurrentlyFocusedQuestPanelButton=-1
    m_nDesiredFocusedDiscardButton=-1
    m_nCurrentlyFocusedDiscardButton=-1
    m_UISceneClass=Class'TgClient.UIScene_UIQuests'
    m_OptionList[0]=140
    m_OptionList[1]=23
    m_nBackground=1
    m_Name="UIQuests"
}