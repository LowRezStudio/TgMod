class ParticleModuleLocationSkelVertSurface extends ParticleModuleLocationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum ELocationSkelVertSurfaceSource
{
    VERTSURFACESOURCE_Vert,         // 0
    VERTSURFACESOURCE_Surface,      // 1
    VERTSURFACESOURCE_MAX           // 2
};

var(VertSurface) ParticleModuleLocationSkelVertSurface.ELocationSkelVertSurfaceSource SourceType;
var(VertSurface) Vector UniversalOffset;
var(VertSurface) bool bUpdatePositionEachFrame;
var(VertSurface) bool bOrientMeshEmitters;
var(VertSurface) bool bEnforceNormalCheck;
var(VertSurface) name SkelMeshActorParamName;
var(VertSurface) array<name> ValidAssociatedBones;
var(VertSurface) Vector NormalToCompare;
var(VertSurface) float NormalCheckToleranceDegrees;
var float NormalCheckTolerance;
var(VertSurface) array<int> ValidMaterialIndices;

defaultproperties
{
    bOrientMeshEmitters=true
    SkelMeshActorParamName="VertSurfaceActor"
    bSpawnModule=true
    bUpdateModule=true
    bFinalUpdateModule=true
    bSupported3DDrawMode=true
}