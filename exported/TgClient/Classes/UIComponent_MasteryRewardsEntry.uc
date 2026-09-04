class UIComponent_MasteryRewardsEntry extends UIComponent
    native(UIComponent);

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

event UpdateEntryColor()
{
    // End:0x169
    if(m_bSelected)
    {
        m_mcLevelText.SetColor(219.0000000 / 255.0000000, 242.0000000 / 255.0000000, 255.0000000 / 255.0000000);
        m_mcRewardType.SetColor(219.0000000 / 255.0000000, 242.0000000 / 255.0000000, 255.0000000 / 255.0000000);
        m_mcRewardTitle.SetColor(219.0000000 / 255.0000000, 242.0000000 / 255.0000000, 255.0000000 / 255.0000000);
        m_mcRewardName.SetColor(126.0000000 / 255.0000000, 200.0000000 / 255.0000000, 206.0000000 / 255.0000000);
        m_mcRewardCurrencyTF.SetColor(219.0000000 / 255.0000000, 242.0000000 / 255.0000000, 255.0000000 / 255.0000000);        
    }
    else
    {
        // End:0x2D2
        if(m_bAchieved)
        {
            m_mcLevelText.SetColor(119.0000000 / 255.0000000, 170.0000000 / 255.0000000, 182.0000000 / 255.0000000);
            m_mcRewardType.SetColor(71.0000000 / 255.0000000, 124.0000000 / 255.0000000, 136.0000000 / 255.0000000);
            m_mcRewardTitle.SetColor(127.0000000 / 255.0000000, 192.0000000 / 255.0000000, 207.0000000 / 255.0000000);
            m_mcRewardName.SetColor(71.0000000 / 255.0000000, 124.0000000 / 255.0000000, 136.0000000 / 255.0000000);
            m_mcRewardCurrencyTF.SetColor(127.0000000 / 255.0000000, 192.0000000 / 255.0000000, 207.0000000 / 255.0000000);            
        }
        else
        {
            m_mcLevelText.SetColor(57.0000000 / 255.0000000, 74.0000000 / 255.0000000, 84.0000000 / 255.0000000);
            m_mcRewardType.SetColor(83.0000000 / 255.0000000, 116.0000000 / 255.0000000, 132.0000000 / 255.0000000);
            m_mcRewardTitle.SetColor(83.0000000 / 255.0000000, 116.0000000 / 255.0000000, 132.0000000 / 255.0000000);
            m_mcRewardName.SetColor(83.0000000 / 255.0000000, 116.0000000 / 255.0000000, 132.0000000 / 255.0000000);
            m_mcRewardCurrencyTF.SetColor(83.0000000 / 255.0000000, 116.0000000 / 255.0000000, 132.0000000 / 255.0000000);
        }
    }
    // End:0x48C
    if(m_bReadyToUnlock && m_bAchieved)
    {
        m_mcRewardType.SetColor(60.0000000 / 255.0000000, 255.0000000 / 255.0000000, 7.0000000 / 255.0000000);
    }
    //return;    
}

defaultproperties
{
    m_sLoadName="Entry"
}