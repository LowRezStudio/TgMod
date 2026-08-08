class TgPawn_Biped extends TgPawn
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var () name m_nmLeftFootBone;
var () name m_nmRightFootBone;
var () name m_nmLeftFootControlName;
var () name m_nmRightFootControlName;
var float m_fOldLocationZ;
var bool m_bEnableRightFootPlacement;
var bool m_bEnableLeftFootPlacement;
var bool m_bMayDisableFootIKFromAnimNodes;
var bool m_bInitializedFootIKCachedNodeList;
var bool m_bApplyLeftHandWeaponIK;
var bool m_bSetHandIKStrengthFromAnimNodes;
var bool m_bInitializedHandIKCachedNodeList;
var bool c_bPlayingRefire;
var bool c_bRefireIsUpperBody;
var const float m_fZSmoothingRate;
var float m_fMaxFootPlacementDistSquared;
var SkelControlFootPlacement m_LeftLegControl;
var SkelControlFootPlacement m_RightLegControl;
var array<name> m_FootIKZeroStrengthAnimNodeNameList;
var array<AnimNode> m_FootIKZeroStrengthCachedNodeList;
var Vector m_vPreviousRightFootPosition;
var Vector m_vPreviousLeftFootPosition;
var float m_fCachedRightTracedFloor;
var float m_fCachedLeftTracedFloor;
var float m_fCachedRightFloorNormalZ;
var float m_fCachedLeftFloorNormalZ;
var int m_nCachedLeftFootBoneIndex;
var int m_nCachedRightFootBoneIndex;
var name m_SkelControl_LeftHandName;
var SkelControlLimb m_SkelControl_LeftHand;
var SkelControlSingleBone m_SkelControl_LeftHandRotate;
var name m_SkelControl_RightHandName;
var SkelControlLimb m_SkelControl_RightHand;
var SkelControlSingleBone m_SkelControl_RightHandRotate;
var SkelControlSingleBone m_SkelControl_RightToLeftPropSwitch;
var array<name> m_HandIKFullStrengthAnimNodeNameList;
var array<name> m_HandIKZeroStrengthAnimNodeNameList;
var array<AnimNode> m_HandIKFullStengthCachedNodeList;
var array<AnimNode> m_HandIKZeroStrengthCachedNodeList;
var MaterialInstanceConstant m_FadeMaterialControllerBody;
var name c_RefireBeginBlendAnimationName;
var name c_RefireEndBlendAnimationName;
var AnimSet c_RefireAnimSet;
var float c_fRefireDuration;
var float c_fRefireEndDuration;

native function bool InitializeLeftHandIKAnimNodes(SkeletalMeshComponent SkelComp);  // Export UTgPawn_Biped::execInitializeLeftHandIKAnimNodes(FFrame&, void* const)

native function bool InitializeFootIKZeroStrengthAnimNodes(SkeletalMeshComponent SkelComp);  // Export UTgPawn_Biped::execInitializeFootIKZeroStrengthAnimNodes(FFrame&, void* const)

native function BeginRefire();  // Export UTgPawn_Biped::execBeginRefire(FFrame&, void* const)

native function EndRefire();  // Export UTgPawn_Biped::execEndRefire(FFrame&, void* const)

native function EndRefireTimer();  // Export UTgPawn_Biped::execEndRefireTimer(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated function CacheMainMeshReferences(TgSkeletalMeshComponent smcomp) { }

exec function zpivot(float F) { }

simulated event EnableFootControls(int foot, bool bDisable) { }

exec function SetAimTarget(float X, float Y, float Z) { }

simulated function bool CanTrackATarget() { }

event Landed(vector HitNormal, actor FloorActor) { }

defaultproperties
{}
