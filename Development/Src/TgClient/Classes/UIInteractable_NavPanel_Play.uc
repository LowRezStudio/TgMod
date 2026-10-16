class UIInteractable_NavPanel_Play extends UIInteractable_NavPanel
    native(UIComponent)
    config(Engine);

var float m_fFlareScaleTime[4];
var float m_fFlareAlphaTime[5];
var float m_fFlareScaleTimer[4];
var float m_fFlareAlphaTimer[5];
var GFxObject m_mcFlare;

defaultproperties
{
    m_fFlareScaleTime[0]=3.0000000
    m_fFlareScaleTime[1]=0.5000000
    m_fFlareScaleTime[2]=1.2500000
    m_fFlareScaleTime[3]=0.2083330
    m_fFlareAlphaTime[0]=3.0000000
    m_fFlareAlphaTime[1]=0.0833330
    m_fFlareAlphaTime[2]=0.4166660
    m_fFlareAlphaTime[3]=1.2500000
    m_fFlareAlphaTime[4]=0.2083330
}
