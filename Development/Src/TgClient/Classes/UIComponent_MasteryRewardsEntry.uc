class UIComponent_MasteryRewardsEntry extends UIComponent
    native(UIComponent)
    config(Engine);

var protected GFxObject m_mcLockIcon;
var protected GFxObject m_mcLevelText;
var protected GFxObject m_mcRewardType;
var protected GFxObject m_mcRewardName;
var protected GFxObject m_mcRewardTitle;
var protected GFxObject m_mcRewardCurrency;
var protected GFxObject m_mcRewardCurrencyTF;
var protected GFxObject m_mcCardIcon;
var protected GFxObject m_mcItemIcon;
var protected GFxObject m_mcTextureIcon;
var protected GFxObject m_mcRarity;
var protected GFxObject m_mcRadiantChest;
var protected GFxObject m_mcPreviewing;
var protected UIInteractable_Button m_pFrameButton;
var protected UIInteractable_Button_ItemPrice m_pPriceButton;
var protected bool m_bPendingSelected;
var protected bool m_bSelected;
var protected bool m_bReadyToUnlock;
var protected bool m_bAchieved;
var protected UIDataItem m_pItemReward;

event UpdateEntryColor() { }

defaultproperties
{
    m_sLoadName="Entry"
}
