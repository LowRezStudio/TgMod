class AnimNode_MultiBlendPerBone extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object);

enum EWeightCheck
{
    EWC_AnimNodeSlotNotPlaying,     // 0
    EWC_MAX                         // 1
};

enum EBlendType
{
    EBT_ParentBoneSpace,            // 0
    EBT_MeshSpace,                  // 1
    EBT_MAX                         // 2
};

struct native WeightNodeRule
{
    var() name NodeName;
    var AnimNodeBlendBase CachedNode;
    var AnimNodeSlot CachedSlotNode;
    var() AnimNode_MultiBlendPerBone.EWeightCheck WeightCheck;
    var() int ChildIndex;

    structdefaultproperties
    {
        NodeName="None"
        CachedNode=none
        CachedSlotNode=none
        WeightCheck=EWeightCheck.EWC_AnimNodeSlotNotPlaying
        ChildIndex=0
    }
};

struct native WeightRule
{
    var() WeightNodeRule FirstNode;
    var() WeightNodeRule SecondNode;

    structdefaultproperties
    {
        FirstNode=(NodeName="None",CachedNode=none,CachedSlotNode=none,WeightCheck=EWeightCheck.EWC_AnimNodeSlotNotPlaying,ChildIndex=0)
        SecondNode=(NodeName="None",CachedNode=none,CachedSlotNode=none,WeightCheck=EWeightCheck.EWC_AnimNodeSlotNotPlaying,ChildIndex=0)
    }
};

struct native BranchInfo
{
    var() name BoneName;
    var() float PerBoneWeightIncrease;

    structdefaultproperties
    {
        BoneName="None"
        PerBoneWeightIncrease=1.0000000
    }
};

struct native PerBoneMaskInfo
{
    var() array<BranchInfo> BranchList;
    var() float DesiredWeight;
    var() float BlendTimeToGo;
    var() array<WeightRule> WeightRuleList;
    var() bool bWeightBasedOnNodeRules;
    var() bool bDisableForNonLocalHumanPlayers;
    var transient bool bPendingBlend;
    var transient array<float> PerBoneWeights;
    var transient array<byte> TransformReqBone;
    var transient int TransformReqBoneIndex;

    structdefaultproperties
    {
        BranchList=none
        DesiredWeight=0.0000000
        BlendTimeToGo=0.0000000
        WeightRuleList=none
        bWeightBasedOnNodeRules=false
        bDisableForNonLocalHumanPlayers=false
        bPendingBlend=false
        PerBoneWeights=none
        TransformReqBone=none
        TransformReqBoneIndex=0
    }
};

var const transient Pawn PawnOwner;
var() editfixedsize editinline array<editinline PerBoneMaskInfo> MaskList;
var() AnimNode_MultiBlendPerBone.EBlendType RotationBlendType;

// Export UAnimNode_MultiBlendPerBone::execSetMaskWeight(FFrame&, void* const)
native final function SetMaskWeight(int MaskIndex, float DesiredWeight, float BlendTime);

defaultproperties
{
    Children[0]=(Name="Source",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
}