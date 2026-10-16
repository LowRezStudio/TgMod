class AmbientOcclusionEffect extends PostProcessEffect
    native
    hidecategories(Object);

enum EAmbientOcclusionQuality
{
    AO_High,                        // 0
    AO_Medium,                      // 1
    AO_Low,                         // 2
    AO_MAX                          // 3
};

var(Color) interp LinearColor OcclusionColor;
var(Color) float OcclusionPower;
var(Color) float OcclusionScale;
var(Color) float OcclusionBias;
var(Color) float MinOcclusion;
var deprecated bool SSAO2;
var(Occlusion) bool bAngleBasedSSAO;
var(Occlusion) float OcclusionRadius;
var deprecated float OcclusionAttenuation;
var(Occlusion) AmbientOcclusionEffect.EAmbientOcclusionQuality OcclusionQuality;
var(Occlusion) float OcclusionFadeoutMinDistance;
var(Occlusion) float OcclusionFadeoutMaxDistance;
var(Halo) float HaloDistanceThreshold;
var(Halo) float HaloDistanceScale;
var(Halo) float HaloOcclusion;
var(Filter) float EdgeDistanceThreshold;
var(Filter) float EdgeDistanceScale;
var(Filter) float FilterDistanceScale;
var deprecated int FilterSize;
var(History) float HistoryConvergenceTime;
var float HistoryWeightConvergenceTime;

defaultproperties
{
    OcclusionColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    OcclusionPower=4.0000000
    OcclusionScale=20.0000000
    MinOcclusion=0.1000000
    OcclusionRadius=25.0000000
    OcclusionQuality=EAmbientOcclusionQuality.AO_Medium
    OcclusionFadeoutMinDistance=4000.0000000
    OcclusionFadeoutMaxDistance=4500.0000000
    HaloDistanceThreshold=40.0000000
    HaloDistanceScale=0.1000000
    HaloOcclusion=0.0400000
    EdgeDistanceThreshold=10.0000000
    EdgeDistanceScale=0.0030000
    FilterDistanceScale=10.0000000
    HistoryWeightConvergenceTime=0.0700000
    bAffectsLightingOnly=true
    SceneDPG=ESceneDepthPriorityGroup.SDPG_World
}