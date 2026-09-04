class UIComponent_DailyRewards extends UIComponent
    native(UIComponent)
    config(Engine);

const DAILYREWARD_DAYS = 7;

var TgRewardCenterManager m_RewardCenter;
var TgGFxGroup m_grDailyReward;
var GFxObject m_mcBlocker;
var GFxObject m_mcTitle;
var GFxObject m_mcDescription;
var GFxObject m_mcMaxGold;
var GFxObject m_mcNextRewardTitle;
var GFxObject m_mcNextRewardText;
var UIInteractable_Button m_ClaimButton;
var UIInteractable_Button m_BoostButton;
var GFxObject m_mcDay[7];
var GFxObject m_mcDayTitle[7];
var GFxObject m_mcDayHighlight[7];
var GFxObject m_mcDayReward[7];
var GFxObject m_mcDayBackground[7];
var GFxObject m_mcDayClaimedTF[7];
var GFxObject m_mcBoost;
var GFxObject m_mcBoostCrystalsTF;
var GFxObject m_mcBoostGoldTF;
var GFxObject m_mcBoostBonusText;
var GFxObject m_mcBoostIcon;
var GFxObject m_mcBoostButtonConsole;
var GFxObject m_mcClaimButtonConsole;
var bool m_bBoosted;
var bool m_bWaitingForBoost;
var bool m_bHideConsolePrompts;
var int m_nBoostCrystals;
var int m_nBoostGold;
var AkBaseSoundObject m_scDailyReward;
var AkBaseSoundObject m_scDailyRewardAccept;

defaultproperties
{
    m_scDailyReward=AkEvent'UI_Lobby_Alert_LevelUp_CharacterMastery_Play'
    m_scDailyRewardAccept=AkEvent'UI_Menu_CardCraft_Finish_Play'
}
