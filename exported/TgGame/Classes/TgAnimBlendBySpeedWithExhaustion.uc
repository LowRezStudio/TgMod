class TgAnimBlendBySpeedWithExhaustion extends TgAnimBlendBySpeed
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var(Exhaustion) bool m_bEnableExhaustion;
var(Exhaustion) float m_fExhaustionLevel;
var(Exhaustion) array<int> m_ExhaustedChildren;
var(Exhaustion) array<int> m_GainExhaustionChildren;
var(Exhaustion) float m_fExhaustionGainSpeed;
var(Exhaustion) float m_fExhaustionLossSpeed;
var(Exhaustion) float m_fExhaustionLevelMax;
var(Exhaustion) float m_fExhaustionLevelMin;

defaultproperties
{
    m_fExhaustionLevel=1.0000000
    m_fExhaustionGainSpeed=0.2500000
    m_fExhaustionLossSpeed=0.3000000
    m_fExhaustionLevelMax=2.5000000
    m_fExhaustionLevelMin=1.0000000
}