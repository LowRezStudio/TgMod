class TgSkelControlSingleBone_Ammo extends TgSkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object);

var TgPawn m_PawnOwner;
var() bool m_bInvertStrengthFromAmmo;
var() float m_fFlatInterpolationRateDecrease;
var() float m_fInterpolationRateDecrease;
var() float m_fFlatInterpolationRateIncrease;
var() float m_fInterpolationRateIncrease;
var() int m_nMaxAmmoFallback;

defaultproperties
{
    m_fFlatInterpolationRateDecrease=1.0000000
    m_fInterpolationRateDecrease=1.0000000
    m_fFlatInterpolationRateIncrease=1.0000000
    m_fInterpolationRateIncrease=1.0000000
    m_nMaxAmmoFallback=10
}