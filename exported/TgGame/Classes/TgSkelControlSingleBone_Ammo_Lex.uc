class TgSkelControlSingleBone_Ammo_Lex extends TgSkelControlSingleBone
    native(AnimNodesLex)
    hidecategories(Object,Object);

var TgPawn_Lex m_Lex;
var() bool m_bLeftGun;
var() float m_fFlatInterpolationRateDecrease;
var() float m_fInterpolationRateDecrease;
var() float m_fFlatInterpolationRateIncrease;
var() float m_fInterpolationRateIncrease;

defaultproperties
{
    m_fFlatInterpolationRateDecrease=1.0000000
    m_fInterpolationRateDecrease=1.0000000
    m_fFlatInterpolationRateIncrease=1.0000000
    m_fInterpolationRateIncrease=1.0000000
}