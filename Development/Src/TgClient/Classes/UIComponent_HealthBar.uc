class UIComponent_HealthBar extends UIComponent
    native(UIComponent)
    config(Engine);

enum EHealthTickType {
    EHTT_Health,  // 0
    EHTT_Shield,  // 1
    EHTT_Shadow,  // 2
    EHTT_Damage,  // 3
};

enum EHealthTickColor_Player {
    EHTCP_Invalid,  // 0
    EHTCP_Blue,  // 1
    EHTCP_Red,  // 2
    EHTCP_Purple,  // 3
    EHTCP_Orange,  // 4
    EHTCP_Yellow,  // 5
    EHTCP_Shadow,  // 6
};

struct BarTickTypes {
    var const string sMaskName;
    var const string sContainerName;
    var float fWidth;
    var UIComponent_HealthBar.EHealthTickType eBorderTickType;
    var GFxObject mcBorderTickMask;
    var GFxObject mcLeftBorderTick;
    var GFxObject mcRightBorderTick;
    structdefaultproperties {}
};

var array<GFxObject> m_mcHealthBarTicks;
var GFxObject m_mcHealthBarContainer;
var array<BarTickTypes> m_BarTickTypes;
var int m_nLastUsedHealthTickColorFrame;
var float m_fDisplayedMaxHealth;
var float m_fDisplayedHealthPct;
var float m_fActualHealthPct;
var float m_fLastDisplayedHealthPct;
var float m_fDisplayedShieldPct;
var float m_fActualShieldPct;
var float m_fLastDisplayedShieldPct;
var float m_fHealthPerTick;
var float m_fBarWidth;
var float m_fTickPadding;

defaultproperties
{
    m_BarTickTypes[0]=(sMaskName="HealthBorderTickMask",sContainerName="HealthBorderTickContainer",fWidth=0.0000000,eBorderTickType=EHTT_Health,mcBorderTickMask=none,mcLeftBorderTick=none,mcRightBorderTick=none)
    m_BarTickTypes[1]=(sMaskName="ShieldBorderTickMask",sContainerName="ShieldBorderTickContainer",fWidth=0.0000000,eBorderTickType=EHTT_Shield,mcBorderTickMask=none,mcLeftBorderTick=none,mcRightBorderTick=none)
    m_BarTickTypes[2]=(sMaskName="ShadowBorderTickMask",sContainerName="ShadowBorderTickContainer",fWidth=0.0000000,eBorderTickType=EHTT_Shadow,mcBorderTickMask=none,mcLeftBorderTick=none,mcRightBorderTick=none)
    m_fHealthPerTick=250.0000000
}
