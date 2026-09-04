class ParticleModuleAttractorSkelVertSurface extends ParticleModuleAttractorBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum EVertSurfaceAttractorFalloffType
{
    VSFOFF_Constant,                // 0
    VSFOFF_Linear,                  // 1
    VSFOFF_Exponent,                // 2
    VSFOFF_MAX                      // 3
};

enum EAttractorSkelVertSurfaceDestination
{
    VERTSURFACEDEST_Vert,           // 0
    VERTSURFACEDEST_Surface,        // 1
    VERTSURFACEDEST_MAX             // 2
};

var() ParticleModuleAttractorSkelVertSurface.EVertSurfaceAttractorFalloffType FalloffType;
var(VertSurface) ParticleModuleAttractorSkelVertSurface.EAttractorSkelVertSurfaceDestination DestinationType;
var() bool bParticleLifeRelative;
var(VertSurface) bool bEnforceNormalCheck;
var() interp RawDistributionFloat FalloffExponent;
var() interp RawDistributionFloat Range;
var() interp RawDistributionFloat Strength;
var() interp RawDistributionFloat CollisionRadius;
var() interp RawDistributionFloat DragCoefficient;
var() interp RawDistributionFloat DragRadius;
var(VertSurface) Vector UniversalOffset;
var(VertSurface) name SkelMeshActorParamName;
var(VertSurface) array<name> ValidAssociatedBones;
var(VertSurface) Vector NormalToCompare;
var(VertSurface) float NormalCheckToleranceDegrees;
var float NormalCheckTolerance;
var(VertSurface) array<int> ValidMaterialIndices;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorSkelVertSurface.DistributionFalloffExponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionFalloffExponent'
    begin object name="DistributionFalloffExponent" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorSkelVertSurface.DistributionRange'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRange'
    begin object name="DistributionRange" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorSkelVertSurface.DistributionStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrength'
    begin object name="DistributionStrength" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorSkelVertSurface.DistributionDragCoefficient'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDragCoefficient'
    begin object name="DistributionDragCoefficient" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorSkelVertSurface.DistributionDragRadius'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDragRadius'
    begin object name="DistributionDragRadius" class=Engine.DistributionFloatConstant
    end object
    FalloffExponent=(Distribution=Distribution=DistributionFalloffExponent,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Range=(Distribution=Distribution=DistributionRange,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Strength=(Distribution=Distribution=DistributionStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    DragCoefficient=(Distribution=Distribution=DistributionDragCoefficient,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    DragRadius=(Distribution=Distribution=DistributionDragRadius,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    SkelMeshActorParamName="VertSurfaceActor"
    bSpawnModule=true
    bUpdateModule=true
    bFinalUpdateModule=true
    bSupported3DDrawMode=true
}