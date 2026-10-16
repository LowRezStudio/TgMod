class TgAnimSequenceChain extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var () bool m_bLoopChain;
var () bool m_bResetOnRelevant;
var () bool m_bDelayBlendOutToPlayAnim;
var () bool m_bAdvanceOnReplay;
var () bool m_bAdvanceOnAnimEnd;
var bool m_bIsAllowedToBlendOut;
var bool m_ReplayedThisFrame;

defaultproperties
{
    m_bAdvanceOnReplay=true
    m_bAdvanceOnAnimEnd=true
    m_bIsAllowedToBlendOut=true
    DefaultBlendTime=0.2000000
    Children=/* Array type was not detected. */
}
