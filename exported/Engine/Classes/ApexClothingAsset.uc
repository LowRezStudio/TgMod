class ApexClothingAsset extends ApexAsset
    native(Mesh)
    hidecategories(Object,Object);

struct native ClothingLodInfo
{
    var() init const editfixedsize array<init int> LODMaterialMap;

    structdefaultproperties
    {
        LODMaterialMap=none
    }
};

var() const editfixedsize array<ClothingLodInfo> LodMaterialInfo;
var native Pointer MApexAsset;
var() const editfixedsize array<MaterialInterface> Materials;
var const deprecated ApexGenericAsset ApexClothingLibrary;
var() const bool bUseHardwareCloth;
var() const bool bFallbackSkinning;
var() const bool bSlowStart;
var() const bool bRecomputeNormals;
var() const bool bAllowAdaptiveTargetFrequency;
var() const bool bResetAfterTeleport;
var() const bool bUseLocalSpaceSimulation;
var bool bHasUniqueAssetMaterialNames;
var(Sound) bool IgnoreInitialTrigger;
var() const int UVChannelForTangentUpdate;
var() const float MaxDistanceBlendTime;
var() const float ContinuousRotationThreshold;
var() const float ContinuousDistanceThreshold;
var() const float LodWeightsMaxDistance;
var() const float LodWeightsDistanceWeight;
var() const float LodWeightsBias;
var() const float LodWeightsBenefitsBias;
var() const float LODDecayTime;
var(Sound) SoundCue SoundOnMove;
var(Sound) SoundCue SoundOnRest;
var(Sound) SoundCue SoundWhileMoving;
var(Sound) float SpeedThresholdOnMove;
var(Sound) float SpeedThresholdOnRest;

defaultproperties
{
    bUseHardwareCloth=true
    bSlowStart=true
    bResetAfterTeleport=true
    MaxDistanceBlendTime=1.0000000
    ContinuousRotationThreshold=84.0000000
    ContinuousDistanceThreshold=50.0000000
    LodWeightsMaxDistance=10000.0000000
    LodWeightsDistanceWeight=1.0000000
    LODDecayTime=10.0000000
}