class ParticleModuleTypeDataRibbon extends ParticleModuleTypeDataBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum ETrailsRenderAxisOption
{
    Trails_CameraUp,                // 0
    Trails_SourceUp,                // 1
    Trails_WorldUp,                 // 2
    Trails_MAX                      // 3
};

var int MaxTessellationBetweenParticles;
var(Trail) int SheetsPerTrail;
var(Trail) int MaxTrailCount;
var(Trail) int MaxParticleInTrailCount;
var(Trail) bool bDeadTrailsOnDeactivate;
var(Trail) bool bDeadTrailsOnSourceLoss;
var(Trail) bool bClipSourceSegement;
var(Trail) bool bEnablePreviousTangentRecalculation;
var(Trail) bool bTangentRecalculationEveryFrame;
var(Trail) bool bSpawnInitialParticle;
var(Rendering) bool bRenderGeometry;
var(Rendering) bool bRenderSpawnPoints;
var(Rendering) bool bRenderTangents;
var(Rendering) bool bRenderTessellation;
var(Rendering) bool bEnableTangentDiffInterpScale;
var(Trail) ParticleModuleTypeDataRibbon.ETrailsRenderAxisOption RenderAxis;
var(Spawn) float TangentSpawningScalar;
var(Rendering) float TilingDistance;
var(Rendering) float DistanceTessellationStepSize;
var(Rendering) float TangentTessellationScalar;

defaultproperties
{
    MaxTessellationBetweenParticles=25
    SheetsPerTrail=1
    MaxTrailCount=1
    MaxParticleInTrailCount=500
    bDeadTrailsOnDeactivate=true
    bDeadTrailsOnSourceLoss=true
    bClipSourceSegement=true
    bEnablePreviousTangentRecalculation=true
    bRenderGeometry=true
    DistanceTessellationStepSize=15.0000000
    TangentTessellationScalar=5.0000000
}