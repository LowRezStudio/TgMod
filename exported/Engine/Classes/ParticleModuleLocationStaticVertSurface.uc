class ParticleModuleLocationStaticVertSurface extends ParticleModuleLocationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum ELocationStaticVertSurfaceSource
{
    VERTSTATICSURFACESOURCE_Vert,   // 0
    VERTSTATICSURFACESOURCE_Surface,// 1
    VERTSTATICSURFACESOURCE_MAX     // 2
};

var(VertSurface) ParticleModuleLocationStaticVertSurface.ELocationStaticVertSurfaceSource SourceType;
var(VertSurface) Vector UniversalOffset;
var(VertSurface) bool bUpdatePositionEachFrame;
var(VertSurface) bool bOrientMeshEmitters;
var(VertSurface) bool bEnforceNormalCheck;
var(VertSurface) name StaticMeshActorParamName;
var(VertSurface) Vector NormalToCompare;
var(VertSurface) float NormalCheckToleranceDegrees;
var float NormalCheckTolerance;
var(VertSurface) array<int> ValidMaterialIndices;

defaultproperties
{
    bOrientMeshEmitters=true
    StaticMeshActorParamName="VertSurfaceActor"
    bSpawnModule=true
    bUpdateModule=true
    bFinalUpdateModule=true
    bSupported3DDrawMode=true
}