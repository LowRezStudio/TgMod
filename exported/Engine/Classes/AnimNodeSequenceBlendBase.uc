class AnimNodeSequenceBlendBase extends AnimNodeSequence
    abstract
    native(Anim)
    hidecategories(Object,Object,Object);

struct native AnimInfo
{
    var const name AnimSeqName;
    var const transient AnimSequence AnimSeq;
    var const transient int AnimLinkupIndex;

    structdefaultproperties
    {
        AnimSeqName="None"
        AnimSeq=none
        AnimLinkupIndex=0
    }
};

struct native AnimBlendInfo
{
    var() name AnimName;
    var AnimInfo AnimInfo;
    var transient float Weight;

    structdefaultproperties
    {
        AnimName="None"
        AnimInfo=(AnimSeqName="None",AnimSeq=none,AnimLinkupIndex=0)
        Weight=0.0000000
    }
};

var(Animations) editfixedsize export editinline array<export editinline AnimBlendInfo> Anims;

defaultproperties
{
    Anims[0]=(AnimName="None",AnimInfo=(AnimSeqName="None",AnimSeq=none,AnimLinkupIndex=0),Weight=1.0000000)
    Anims[1]=(AnimName="None",AnimInfo=(AnimSeqName="None",AnimSeq=none,AnimLinkupIndex=0),Weight=0.0000000)
}