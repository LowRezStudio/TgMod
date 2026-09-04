class TgAnimNodeBlendByVerticalAim extends AnimNodeBlendBase
    native
    hidecategories(Object,Object,Object)
    config(Engine);

var () float m_Aim;
var () Vector2D m_Range;
var () float m_AngleOffset;
var transient float m_PreviousAim;
var transient bool bInitialized;
var () bool m_bLoopChildrenOnRelevant;
var () bool m_bPlayChildrenOnRelevant;
var () name m_AnimName_Up;
var () name m_AnimName_Center;
var () name m_AnimName_Down;
var transient AnimNodeSequence m_SeqNode1;
var transient AnimNodeSequence m_SeqNode2;

native function PlayAnim(optional bool bLoop=false, optional float Rate=1.0000000, optional float StartTime=0.0000000);  // Export UTgAnimNodeBlendByVerticalAim::execPlayAnim(FFrame&, void* const)

event OnBecomeRelevant() { }

defaultproperties
{
    m_Range=(X=-1.0000000,Y=1.0000000)
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
