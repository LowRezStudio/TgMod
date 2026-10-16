class UIComponent_HealthBarDamageOverlay extends UIComponent
    native(UIComponent);

var UIComponent_HealthBar m_HealthbarOwner;
var bool m_bWidthDirty;
var int m_nDamageBarExtraWidth;
var int m_nLowHealthBarExtraWidth;
var GFxObject m_mcDamageOverlay;
var GFxObject m_mcLowHealthOverlay;
var float m_fOnDamageColorMaxThreshold;
var float m_fOnDamageColorMinThreshold;
var float m_fLowHealthPulseMaxThreshold;
var float m_fLowHealthPulseMinThreshold;
var float m_fLowHealthPulseInterp;
var float m_fLowHealthPulseMinInterpSpeed;
var float m_fLowHealthPulseMaxInterpSpeed;
var float m_fLowHealthInterpExp;
var float m_fOnDamageMaxAlpha;
var float m_fLowHealthMinAlpha;
var float m_fLowHealthMaxAlpha;

defaultproperties
{
    m_bWidthDirty=true
    m_nDamageBarExtraWidth=14
    m_nLowHealthBarExtraWidth=7
    m_fOnDamageColorMaxThreshold=100.0000000
    m_fLowHealthPulseMaxThreshold=0.5000000
    m_fLowHealthPulseMinThreshold=0.4000000
    m_fLowHealthPulseMinInterpSpeed=0.5000000
    m_fLowHealthPulseMaxInterpSpeed=2.0000000
    m_fLowHealthInterpExp=2.0000000
    m_fOnDamageMaxAlpha=0.3500000
    m_fLowHealthMinAlpha=0.5000000
    m_fLowHealthMaxAlpha=1.0000000
}