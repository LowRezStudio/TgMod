class SplineLoftActor extends SplineActor
    native(Spline)
    placeable
    hidecategories(Navigation);

var() interp float ScaleX;
var() interp float ScaleY;
var export editinline array<export editinline SplineMeshComponent> SplineMeshComps;
var() const StaticMesh DeformMesh;
var() const array<MaterialInterface> DeformMeshMaterials;
var() interp float Roll;
var() Vector WorldXDir;
var() Vector2D Offset;
var() bool bSmoothInterpRollAndScale;
var() bool bAcceptsLights;
var() const editconst export editinline DynamicLightEnvironmentComponent MeshLightEnvironment;
var() float MeshMaxDrawDistance;

// Export USplineLoftActor::execClearLoftMesh(FFrame&, void* const)
native function ClearLoftMesh();

// Export USplineLoftActor::execUpdateSplineParams(FFrame&, void* const)
native function UpdateSplineParams();

defaultproperties
{
    ScaleX=1.0000000
    ScaleY=1.0000000
    WorldXDir=(X=1.0000000,Y=0.0000000,Z=0.0000000)
    bSmoothInterpRollAndScale=true
    bAcceptsLights=true
    bStatic=true
    bWorldGeometry=true
    bGameRelevant=true
    bMovable=false
    bCollideActors=true
    bBlockActors=true
    bEdShouldSnap=true
}