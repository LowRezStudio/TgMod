class TgAnimNodeBlendList extends AnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

struct ChildBlendParam {
    var () int FromChild;
    var () int ToChild;
    var () float BlendTime;
    var () float MaxBlendTime;
    structdefaultproperties {}
};

var (animation) float DefaultBlendTime;
var (animation) array<float> ChildBlendTimes;
var (animation) array<ChildBlendParam> SpecificChildBlendTimes;

native function float GetBlendTime(int ChildIndex);  // Export UTgAnimNodeBlendList::execGetBlendTime(FFrame&, void* const)

defaultproperties
{
    DefaultBlendTime=0.2500000
}
