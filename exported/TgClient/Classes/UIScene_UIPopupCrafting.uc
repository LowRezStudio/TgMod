class UIScene_UIPopupCrafting extends UIScene_SceneAsPopup
    native(UIComponent);

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

event float TriggerCardCraftedAnimation()
{
    local float fDelayTime, fAnimTime, fAnimHoldTime;

    fDelayTime = 0.2500000;
    fAnimTime = 0.3300000;
    fAnimHoldTime = 0.5000000;
    m_CardContainerAnim.m_mcRoot.SetVisible(true);
    m_CardContainerAnim.m_mcRoot.SetAlpha(0.0000000);
    m_CardContainerAnim.m_mcRoot.SetXScale(m_CardContainer.m_mcRoot.GetXScale() * 2.5000000);
    m_CardContainerAnim.m_mcRoot.SetYScale(m_CardContainer.m_mcRoot.GetYScale() * 2.5000000);
    EndAnim(m_CardContainerAnim.m_mcRoot);
    FadeIn(m_CardContainerAnim.m_mcRoot, fAnimTime, fDelayTime);
    Animate(m_CardContainerAnim.m_mcRoot, fAnimTime, 5, m_CardContainer.m_mcRoot.GetXScale(), fDelayTime);
    Animate(m_CardContainerAnim.m_mcRoot, fAnimTime, 6, m_CardContainer.m_mcRoot.GetYScale(), fDelayTime);
    FadeOut(m_CardContainer.m_mcRoot, 0.1000000, fDelayTime + (fAnimTime * 0.8000000));
    m_fAnimStartSoundTimer = fDelayTime;
    m_fAnimEndSoundTimer = fDelayTime + fAnimTime;
    return (fDelayTime + fAnimTime) + fAnimHoldTime;
    //return ReturnValue;    
}

event float TriggerCardDisenchantedAnimation()
{
    return 0.0000000;
    //return ReturnValue;    
}

defaultproperties
{
    m_fTimeoutTime=20.0000000
    m_akCraftAnimStart=AkEvent'WW_UI_Default.UI_Menu_DailyLogin_RewardClaim'
    m_akDisenchantAnimStart=AkEvent'WW_UI_Default.UI_Menu_CardCraft_Buildup_Play'
    m_akDisenchantAnimEnd=AkEvent'WW_UI_Default.UI_Menu_CardCraft_Finish_Play'
    m_sLoadName="CraftingPopup"
}