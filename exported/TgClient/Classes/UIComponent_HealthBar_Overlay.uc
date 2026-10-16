class UIComponent_HealthBar_Overlay extends UIComponent_HealthBar
    native(UIComponent);

enum EHealthTickColor_Overlay
{
    EHTCO_Invalid,                  // 0
    EHTCO_Blue,                     // 1
    EHTCO_Red,                      // 2
    EHTCO_Purple,                   // 3
    EHTCO_Orange,                   // 4
    EHTCO_Yellow,                   // 5
    EHTCO_White,                    // 6
    EHTCO_Green,                    // 7
    EHTCO_DarkYellow,               // 8
    EHTCO_DarkGreen,                // 9
    EHTCO_DarkBlue,                 // 10
    EHTCO_DarkRed,                  // 11
    EHTCO_DarkOrange,               // 12
    EHTCO_MAX                       // 13
};

var bool m_bFriendly;
var bool m_bInRange;
var bool m_bColorDirty;
var float m_fDisplayedDamagePct;
var float m_fDamageInterpSpeed;
var float m_fMinDamageInterpSpeed;

defaultproperties
{
    m_fDamageInterpSpeed=4.5000000
    m_fMinDamageInterpSpeed=0.1000000
    m_BarTickTypes[0]=(sMaskName="HealthBorderTickMask",sContainerName="HealthBorderTickContainer",fWidth=0.0000000,eBorderTickType=EHealthTickType.EHTT_Health,mcBorderTickMask=none,mcLeftBorderTick=none,mcRightBorderTick=none)
    m_BarTickTypes[1]=(sMaskName="ShieldBorderTickMask",sContainerName="ShieldBorderTickContainer",fWidth=0.0000000,eBorderTickType=EHealthTickType.EHTT_Shield,mcBorderTickMask=none,mcLeftBorderTick=none,mcRightBorderTick=none)
    m_BarTickTypes[2]=(sMaskName="DamageBorderTickMask",sContainerName="DamageBorderTickContainer",fWidth=0.0000000,eBorderTickType=EHealthTickType.EHTT_Damage,mcBorderTickMask=none,mcLeftBorderTick=none,mcRightBorderTick=none)
    m_BarTickTypes[3]=(sMaskName="ShadowBorderTickMask",sContainerName="ShadowBorderTickContainer",fWidth=0.0000000,eBorderTickType=EHealthTickType.EHTT_Shadow,mcBorderTickMask=none,mcLeftBorderTick=none,mcRightBorderTick=none)
    m_fTickPadding=1.0000000
}