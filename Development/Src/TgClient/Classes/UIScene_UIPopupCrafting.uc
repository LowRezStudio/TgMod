class UIScene_UIPopupCrafting extends UIScene_SceneAsPopup
    native(UIComponent)
    config(Engine);

var UIInteractable_Item m_CardContainer;
var UIInteractable_Item m_CardContainerAnim;
var GFxObject m_mcTitle;
var GFxObject m_mcRarity;
var GFxObject m_mcRemaining;
var GFxObject m_mcCardCraftText;
var GFxObject m_mcControllerPrompt;
var GFxObject m_mcControllerPromptLabel;
var GFxObject m_mcControllerPromptCurrencyTF;
var UIInteractable_Button m_AcceptButton;
var UIInteractable_Button m_CancelButton;
var UIInteractable_Button m_CloseButton;
var bool m_bWaiting;
var bool m_bPurchasing;
var GFxObject m_mcWait;
var GFxObject m_mcWaitSpinner;
var float m_fSpinnerRotation;
var float m_fAnimTimer;
var UIComponent_HoldPrompt m_HoldPrompt;
var float m_fTimeoutTime;
var float m_fTimeoutTimer;
var UIDataItem m_ItemInfo;
var int m_nPurchaseItem;
var int m_nPurchaseType;
var int m_nPurchaseVendor;
var float m_fAnimStartSoundTimer;
var float m_fAnimEndSoundTimer;
var AkBaseSoundObject m_akCraftAnimStart;
var AkBaseSoundObject m_akCraftAnimEnd;
var AkBaseSoundObject m_akDisenchantAnimStart;
var AkBaseSoundObject m_akDisenchantAnimEnd;

event float TriggerCardCraftedAnimation() { }

event float TriggerCardDisenchantedAnimation() { }

defaultproperties
{
    m_fTimeoutTime=20.0000000
    m_akCraftAnimStart=AkEvent'UI_Menu_DailyLogin_RewardClaim'
    m_akDisenchantAnimStart=AkEvent'UI_Menu_CardCraft_Buildup_Play'
    m_akDisenchantAnimEnd=AkEvent'UI_Menu_CardCraft_Finish_Play'
    m_sLoadName="CraftingPopup"
}
