class UIComponent_Quest extends UIComponent
    native(UIList)
    config(Engine);

var int m_nIndex;
var UIQuests m_pParentQuestsScene;
var UIInteractable_Button m_pQuestPanelButton;
var UIInteractable_Button m_pQuestDiscardButton;
var GFxObject m_mcQuestPanelButton;
var GFxObject m_mcQuestReward;
var GFxObject m_mcQuestProgress;
var GFxObject m_mcQuestProgressBar;
var GFxObject m_mcQuestProgressMask;
var GFxObject m_mcQuestGlow;
var GFxObject m_mcQuestTitle;
var GFxObject m_mcQuestType;
var GFxObject m_mcQuestIconRendered;
var GFxObject m_mcQuestIcon;
var GFxObject m_mcQuestChestIcon;
var GFxObject m_mcRewardItem;
var GFxObject m_mcRewardItemIcon;
var GFxObject m_mcRewardItemImageStack;
var GFxObject m_mcRewardItemTexture;
var GFxObject m_mcQuestProgressText;
var GFxObject m_mcQuestDescription;
var GFxObject m_mcQuestRewardLabel;
var GFxObject m_mcQuestRewardAmount;
var GFxObject m_mcQuestDiscard;

defaultproperties
{
    m_nIndex=-1
}
