class TgAnimNodeBlendList extends AnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native ChildBlendParam
{
    var() int FromChild;
    var() int ToChild;
    var() float BlendTime;
    var() float MaxBlendTime;

    structdefaultproperties
    {
        FromChild=0
        ToChild=0
        BlendTime=0.0000000
        MaxBlendTime=0.0000000
    }
};

var(animation) float DefaultBlendTime;
var(animation) array<float> ChildBlendTimes;
var(animation) array<ChildBlendParam> SpecificChildBlendTimes;

// Export UTgAnimNodeBlendList::execGetBlendTime(FFrame&, void* const)
native function float GetBlendTime(int ChildIndex);

defaultproperties
{
    DefaultBlendTime=0.2500000
}