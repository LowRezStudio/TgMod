class UIComponent_HudSkillIcon_Ult extends UIComponent_HudSkillIcon
    native(UIComponent)
    config(Engine);

var GFxObject m_mcUltimatePercent;
var GFxObject m_mcUltimateEffectBot;
var GFxObject m_mcUltimateEffectTop;
var AkBaseSoundObject m_scUltimateReady;
var float m_fPulseTimer;

defaultproperties
{
    m_scUltimateReady=AkEvent'UI_InGame_Alert_UltimateReady_1P_Play'
}
