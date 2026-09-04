class TgAnimBlendByPercent extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native BlendByPercentValues
{
    var() float fPercent;

    structdefaultproperties
    {
        fPercent=0.0000000
    }
};

var float m_fCurrentPercent;
var(NodeSettings) array<BlendByPercentValues> m_ChildParams;

// Export UTgAnimBlendByPercent::execUpdatePercent(FFrame&, void* const)
native function UpdatePercent(float fPercent);

// Export UTgAnimBlendByPercent::execSetActiveChild(FFrame&, void* const)
native function SetActiveChild(int ChildIndex, float BlendTime);

defaultproperties
{
    m_ChildParams[0]=(fPercent=0.0000000)
    m_ChildParams[1]=(fPercent=1.0000000)
    Children=/* Array type was not detected. */
}