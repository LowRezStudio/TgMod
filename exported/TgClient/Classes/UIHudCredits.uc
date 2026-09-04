class UIHudCredits extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

struct native UIRewardInfo
{
    var float fAlpha;
    var float fTimer;
    var GFxObject pClip;

    structdefaultproperties
    {
        fAlpha=0.0000000
        fTimer=0.0000000
        pClip=none
    }
};

var int m_nDepth;
var string m_sComboName;
var string m_sRewardName;
var AkBaseSoundObject m_scXP;
var AkBaseSoundObject m_scKill;
var array<UIRewardInfo> m_mcRewards;

defaultproperties
{
    m_sComboName="ComboInfo"
    m_sRewardName="RewardInfo"
    m_scXP=AkEvent'WW_UI_Default.UI_InGame_Alert_Score_1P_Play'
    m_scKill=AkEvent'WW_UI_Default.UI_InGame_Alert_EnemyKill_1P_Play'
    m_bVisibleOnLoad=true
    m_bAlwaysTick=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudCredits"
}