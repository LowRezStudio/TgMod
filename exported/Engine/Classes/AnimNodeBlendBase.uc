class AnimNodeBlendBase extends AnimNode
    abstract
    native(Anim)
    hidecategories(Object,Object,Object);

struct native AnimBlendChild
{
    var() name Name;
    var export editinline AnimNode Anim;
    var float Weight;
    var const transient float BlendWeight;
    var bool bMirrorSkeleton;
    var bool bIsAdditive;

    structdefaultproperties
    {
        Name="None"
        Anim=none
        Weight=0.0000000
        BlendWeight=0.0000000
        bMirrorSkeleton=false
        bIsAdditive=false
    }
};

struct native AnimationEndInformation
{
    var init array<init AnimNode> TreeBranchToLeaf;
    var float PlayedTime;
    var float ExcessTime;

    structdefaultproperties
    {
        TreeBranchToLeaf=none
        PlayedTime=0.0000000
        ExcessTime=0.0000000
    }
};

var editfixedsize export editinline array<export editinline AnimBlendChild> Children;
var bool bFixNumChildren;
var() bool m_bForceChildToLoop;
var() Object.AlphaBlendType BlendType;

// Export UAnimNodeBlendBase::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float Rate = 1.0000000, optional float StartTime = 0.0000000);

// Export UAnimNodeBlendBase::execStopAnim(FFrame&, void* const)
native function StopAnim();

// Export UAnimNodeBlendBase::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();
