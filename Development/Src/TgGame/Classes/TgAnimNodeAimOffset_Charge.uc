class TgAnimNodeAimOffset_Charge extends TgAnimNodeAimOffset
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var () bool m_bInterpToCurrentTurnRate;
var () float m_fInterpSpeed;
var () float m_fMaxYawRate;
var transient float m_fAimYawOffset;
var transient Rotator m_rCachedOwnerRotator;

defaultproperties
{
    m_bInterpToCurrentTurnRate=true
    m_fInterpSpeed=4.0000000
    m_fMaxYawRate=16384.0000000
}
