class UIComponent_HealthBar_Player extends UIComponent_HealthBar
    native(UIComponent);

var GFxObject m_mcCurrentHealthText;
var GFxObject m_mcMaxHealthText;
var GFxObject m_mcHealthTip;
var GFxObject m_mcHealthColor;
var UIComponent_HealthBarDamageOverlay m_DamageOverlay;
var UIComponent_TorvaldShieldText m_TorvaldShield;
var float m_fHealInterpSpeed;
var float m_fDamageInterpSpeed;
var float m_fMinHealInterpSpeed;
var float m_fMinDamageInterpSpeed;
var int m_nLastViewTargetId;
var TgPawn m_LastViewedPawn;
var int m_nLastCurrentHealthTextValue;
var int m_nLastMaxHealthTextValue;

defaultproperties
{
    m_fHealInterpSpeed=5.0000000
    m_fDamageInterpSpeed=5.0000000
    m_fMinHealInterpSpeed=0.1000000
    m_fMinDamageInterpSpeed=0.1000000
}