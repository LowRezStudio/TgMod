class UIComponent_TorvaldShieldBar extends UIComponent
    native(UIComponent);

var GFxObject m_mcBarContainer;
var GFxObject m_mcShieldMask;
var GFxObject m_mcDamageMask;
var TgPawn_Gauntlet m_CachedViewedTorvald;
var TgPawn_Lazarus m_CachedLazarus;
var float m_fCurrentDamagePct;
var float m_fCurrentShieldPct;
var bool m_bVisible;
var float m_fDamageInterpSpeed;
var float m_fMinDamageInterpSpeed;

defaultproperties
{
    m_fDamageInterpSpeed=4.5000000
    m_fMinDamageInterpSpeed=0.1000000
}