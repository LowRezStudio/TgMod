class TgAnimBlendByPercent extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

struct BlendByPercentValues {
    var () float fPercent;
    structdefaultproperties {}
};

var float m_fCurrentPercent;
var (NodeSettings) array<BlendByPercentValues> m_ChildParams;

native function UpdatePercent(float fPercent);  // Export UTgAnimBlendByPercent::execUpdatePercent(FFrame&, void* const)

native function SetActiveChild(INT ChildIndex, FLOAT BlendTime);  // Export UTgAnimBlendByPercent::execSetActiveChild(FFrame&, void* const)

defaultproperties
{
    m_ChildParams[0]=(fPercent=0.0000000)
    m_ChildParams[1]=(fPercent=1.0000000)
    Children=/* Array type was not detected. */
}
