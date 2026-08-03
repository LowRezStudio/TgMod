class UIComponent_HudSkillIcon_Ult extends UIComponent_HudSkillIcon
    native(UIComponent);

var GFxObject m_mcUltimatePercent;
var GFxObject m_mcUltimateEffectBot;
var GFxObject m_mcUltimateEffectTop;
var AkBaseSoundObject m_scUltimateReady;
var float m_fPulseTimer;

defaultproperties
{
    m_scUltimateReady=AkEvent'WW_UI_Default.UI_InGame_Alert_UltimateReady_1P_Play'
}