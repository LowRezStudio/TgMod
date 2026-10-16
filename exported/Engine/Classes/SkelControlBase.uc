class SkelControlBase extends AnimObject
    abstract
    native(Anim)
    hidecategories(Object,Object);

enum EBoneControlSpace
{
    BCS_WorldSpace,                 // 0
    BCS_ActorSpace,                 // 1
    BCS_ComponentSpace,             // 2
    BCS_ParentBoneSpace,            // 3
    BCS_BoneSpace,                  // 4
    BCS_OtherBoneSpace,             // 5
    BCS_BaseMeshSpace,              // 6
    BCS_MAX                         // 7
};

var(Controller) name ControlName;
var(Controller) float ControlStrength;
var(Controller) float BlendInTime;
var(Controller) float BlendOutTime;
var(Controller) Object.AlphaBlendType BlendType;
var(Controller) bool bPostPhysicsController;
var(Controller) bool bSetStrengthFromAnimNode;
var(Controller) bool bInvertStrengthFromAnimNode;
var transient bool bInitializedCachedNodeList;
var(Controller) bool bControlledByAnimMetada;
var(Controller) bool bInvertMetadataWeight;
var(Controller) bool bPropagateSetActive;
var(Performance) bool bIgnoreWhenNotRendered;
var bool bShouldTickInScript;
var bool bShouldTickOwner;
var() editconst deprecated bool bEnableEaseInOut;
var float StrengthTarget;
var transient float BlendTimeToGo;
var(Controller) array<name> StrengthAnimNodeNameList;
var transient array<AnimNode> CachedNodeList;
var const transient float AnimMetadataWeight;
var const transient int AnimMetaDataUpdateTag;
var(Controller) float BoneScale;
var transient int ControlTickTag;
var(Performance) int IgnoreAtOrAboveLOD;
var SkelControlBase NextControl;
var deprecated int ControlPosX;
var deprecated int ControlPosY;

// Export USkelControlBase::execSetSkelControlActive(FFrame&, void* const)
native final function SetSkelControlActive(bool bInActive);

// Export USkelControlBase::execSetSkelControlStrength(FFrame&, void* const)
native final function SetSkelControlStrength(float NewStrength, float InBlendTime);

event TickSkelControl(float DeltaTime, SkeletalMeshComponent SkelComp)
{
    //return;    
}

// Export USkelControlBase::execGetControlMetadataWeight(FFrame&, void* const)
native final function float GetControlMetadataWeight();

defaultproperties
{
    ControlStrength=1.0000000
    BlendInTime=0.2000000
    BlendOutTime=0.2000000
    StrengthTarget=1.0000000
    BoneScale=1.0000000
    IgnoreAtOrAboveLOD=1000
}