class TgAnimBlendInterpBySpeed extends AnimNodeBlend
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var TgPawn m_TgPawn;
var () float m_fBlendTime;
var () float m_fFullRunSpeed;
var () float m_fFullIdleSpeed;

defaultproperties
{
    m_fBlendTime=0.2000000
    m_fFullRunSpeed=350.0000000
    m_fFullIdleSpeed=50.0000000
    Children=/* Array type was not detected. */
}
