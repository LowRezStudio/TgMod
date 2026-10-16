class UIHudCredits extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

struct UIRewardInfo {
    var float fAlpha;
    var float fTimer;
    var GFxObject pClip;
    structdefaultproperties {}
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
    m_scXP=AkEvent'UI_InGame_Alert_Score_1P_Play'
    m_scKill=AkEvent'UI_InGame_Alert_EnemyKill_1P_Play'
    m_bVisibleOnLoad=true
    m_bAlwaysTick=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudCredits"
}
