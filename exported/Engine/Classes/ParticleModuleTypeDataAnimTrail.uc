class ParticleModuleTypeDataAnimTrail extends ParticleModuleTypeDataBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Anim) name ControlEdgeName;
var(Trail) int SheetsPerTrail;
var(Trail) bool bDeadTrailsOnDeactivate;
var(Trail) bool bClipSourceSegement;
var(Trail) bool bEnablePreviousTangentRecalculation;
var(Trail) bool bTangentRecalculationEveryFrame;
var(Rendering) bool bRenderGeometry;
var(Rendering) bool bRenderSpawnPoints;
var(Rendering) bool bRenderTangents;
var(Rendering) bool bRenderTessellation;
var(Rendering) float TilingDistance;
var(Rendering) float DistanceTessellationStepSize;
var(Rendering) float TangentTessellationScalar;

defaultproperties
{
    SheetsPerTrail=1
    bDeadTrailsOnDeactivate=true
    bClipSourceSegement=true
    bEnablePreviousTangentRecalculation=true
    bRenderGeometry=true
    DistanceTessellationStepSize=10.0000000
}