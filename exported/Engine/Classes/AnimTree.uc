class AnimTree extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native AnimGroup
{
    var const transient array<AnimNodeSequence> SeqNodes;
    var const transient AnimNodeSequence SynchMaster;
    var const transient AnimNodeSequence NotifyMaster;
    var() const name GroupName;
    var() const float RateScale;
    var const float SynchPctPosition;
    var() const bool bOnlyFireNotifiesOnBestGroupMember;

    structdefaultproperties
    {
        SeqNodes=none
        SynchMaster=none
        NotifyMaster=none
        GroupName="None"
        RateScale=1.0000000
        SynchPctPosition=0.0000000
        bOnlyFireNotifiesOnBestGroupMember=false
    }
};

struct native SkelControlListHead
{
    var name BoneName;
    var export editinline SkelControlBase ControlHead;

    structdefaultproperties
    {
        BoneName="None"
        ControlHead=none
    }
};

struct native PreviewSkelMeshStruct
{
    var() name DisplayName;
    var() SkeletalMesh PreviewSkelMesh;
    var() array<MorphTargetSet> PreviewMorphSets;

    structdefaultproperties
    {
        DisplayName="None"
        PreviewSkelMesh=none
        PreviewMorphSets=none
    }
};

struct native PreviewSocketStruct
{
    var() name DisplayName;
    var() name SocketName;
    var() SkeletalMesh PreviewSkelMesh;
    var() StaticMesh PreviewStaticMesh;

    structdefaultproperties
    {
        DisplayName="None"
        SocketName="None"
        PreviewSkelMesh=none
        PreviewStaticMesh=none
    }
};

struct native PreviewAnimSetsStruct
{
    var() name DisplayName;
    var() array<AnimSet> PreviewAnimSets;

    structdefaultproperties
    {
        DisplayName="None"
        PreviewAnimSets=none
    }
};

struct native HelmetMorphRestrictions
{
    var() name MorphName;
    var() float Weight;

    structdefaultproperties
    {
        MorphName="None"
        Weight=0.0000000
    }
};

var() const AnimTree AnimTreeTemplate;
var() bool bEnablePooling;
var bool bUseSavedPose;
var editoronly transient bool bBeingEdited;
var duplicatetransient bool bParentNodeArrayBuilt;
var bool bRebuildAnimTickArray;
var(Speed) bool m_bControlSpeed;
var() array<AnimGroup> AnimGroups;
var deprecated array<deprecated name> PrioritizedSkelBranches;
var() array<name> ComposePrePassBoneNames;
var() array<name> ComposePostPassBoneNames;
var export editinline array<export editinline MorphNodeBase> RootMorphNodes;
var export editinline array<export editinline TgAnimTreeComment> m_AnimTreeComments;
var export editinline array<export editinline SkelControlListHead> SkelControlLists;
var array<BoneAtom> SavedPose;
var duplicatetransient array<AnimNode> AnimTickArray;
var(Speed) float m_fSpeed;
var(MorphGroup) array<name> m_MasterMorphWeightNodeNames;
var array<name> m_MasterMorphWeightGroups;
var(MorphGroup) array<HelmetMorphRestrictions> m_HelmetMorphRestrictions;

// Export UAnimTree::execFindSkelControl(FFrame&, void* const)
native final function SkelControlBase FindSkelControl(name InControlName);

// Export UAnimTree::execFindMorphNode(FFrame&, void* const)
native final function MorphNodeBase FindMorphNode(name InNodeName);

// Export UAnimTree::execSetUseSavedPose(FFrame&, void* const)
native final function SetUseSavedPose(bool bUseSaved);

// Export UAnimTree::execSetAnimGroupForNode(FFrame&, void* const)
native final function bool SetAnimGroupForNode(AnimNodeSequence SeqNode, name GroupName, optional bool bCreateIfNotFound);

// Export UAnimTree::execGetGroupSynchMaster(FFrame&, void* const)
native final function AnimNodeSequence GetGroupSynchMaster(name GroupName);

// Export UAnimTree::execGetGroupNotifyMaster(FFrame&, void* const)
native final function AnimNodeSequence GetGroupNotifyMaster(name GroupName);

// Export UAnimTree::execForceGroupRelativePosition(FFrame&, void* const)
native final function ForceGroupRelativePosition(name GroupName, float RelativePosition);

// Export UAnimTree::execGetGroupRelativePosition(FFrame&, void* const)
native final function float GetGroupRelativePosition(name GroupName);

// Export UAnimTree::execSetGroupRateScale(FFrame&, void* const)
native final function SetGroupRateScale(name GroupName, float NewRateScale);

// Export UAnimTree::execGetGroupRateScale(FFrame&, void* const)
native final function float GetGroupRateScale(name GroupName);

// Export UAnimTree::execGetGroupIndex(FFrame&, void* const)
native final function int GetGroupIndex(name GroupName);

defaultproperties
{
    Children[0]=(Name="Child",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    bFixNumChildren=true
}