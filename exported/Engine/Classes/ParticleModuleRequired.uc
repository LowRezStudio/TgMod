class ParticleModuleRequired extends ParticleModule
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Cascade);

enum EParticleSortMode
{
    PSORTMODE_None,                 // 0
    PSORTMODE_ViewProjDepth,        // 1
    PSORTMODE_DistanceToView,       // 2
    PSORTMODE_Age_OldestFirst,      // 3
    PSORTMODE_Age_NewestFirst,      // 4
    PSORTMODE_MAX                   // 5
};

enum EEmitterNormalsMode
{
    ENM_CameraFacing,               // 0
    ENM_Spherical,                  // 1
    ENM_Cylindrical,                // 2
    ENM_MAX                         // 3
};

var(Emitter) MaterialInterface Material;
var(Emitter) ParticleSpriteEmitter.EParticleScreenAlignment ScreenAlignment;
var(Emitter) ParticleModuleRequired.EParticleSortMode SortMode;
var ParticleEmitter.EParticleBurstMethod ParticleBurstMethod;
var(SubUV) ParticleEmitter.EParticleSubUVInterpMethod InterpolationMethod;
var(Normals) ParticleModuleRequired.EEmitterNormalsMode EmitterNormalsMode;
var(Emitter) bool bAllowImageFlipping;
var(Emitter) bool bSquareImageFlipping;
var(Emitter) bool bUseLocalSpace;
var(Emitter) bool bKillOnDeactivate;
var(Emitter) bool bKillOnCompleted;
var deprecated bool bRequiresSorting;
var(Emitter) bool bUseLegacyEmitterTime;
var(DistanceCulling) bool bEnableNearParticleCulling;
var(DistanceCulling) bool bEnableFarParticleCulling;
var(ParticleTrimming) bool bEnableParticleTrimming;
var(Duration) bool bEmitterDurationUseRange;
var(Duration) bool bDurationRecalcEachLoop;
var(Delay) bool bEmitterDelayUseRange;
var(Delay) bool bDelayFirstLoopOnly;
var(SubUV) bool bScaleUV;
var bool bDirectUV;
var(MacroUV) bool bOverrideSystemMacroUV;
var(Rendering) bool bUseMaxDrawCount;
var(Emitter) bool bOrbitModuleAffectsVelocityAlignment;
var(DistanceCulling) float NearCullDistance;
var(DistanceCulling) float NearFadeDistance;
var(DistanceCulling) float FarFadeDistance;
var(DistanceCulling) float FarCullDistance;
var array<Vector2D> TrimmedVertices;
var(Duration) float EmitterDuration;
var(Duration) float EmitterDurationLow;
var(Duration) int EmitterLoops;
var RawDistributionFloat SpawnRate;
var noclear export array<export ParticleBurst> BurstList;
var(Delay) float EmitterDelay;
var(Delay) float EmitterDelayLow;
var(SubUV) int SubImages_Horizontal;
var(SubUV) int SubImages_Vertical;
var float RandomImageTime;
var(SubUV) int RandomImageChanges;
var(MacroUV) Vector MacroUVPosition;
var(MacroUV) float MacroUVRadius;
var(Rendering) int MaxDrawCount;
var float DownsampleThresholdScreenFraction;
var(Normals) Vector NormalsSphereCenter;
var(Normals) Vector NormalsCylinderDirection;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleRequired.RequiredDistributionSpawnRate'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RequiredDistributionSpawnRate'
    begin object name="RequiredDistributionSpawnRate" class=Engine.DistributionFloatConstant
    end object
    bUseLegacyEmitterTime=true
    bEnableParticleTrimming=true
    bUseMaxDrawCount=true
    NearCullDistance=10.0000000
    NearFadeDistance=150.0000000
    FarFadeDistance=2000.0000000
    FarCullDistance=2100.0000000
    EmitterDuration=1.0000000
    SpawnRate=(Distribution=Distribution=RequiredDistributionSpawnRate,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    SubImages_Horizontal=1
    SubImages_Vertical=1
    MaxDrawCount=500
    NormalsSphereCenter=(X=0.0000000,Y=0.0000000,Z=100.0000000)
    NormalsCylinderDirection=(X=0.0000000,Y=0.0000000,Z=1.0000000)
    bSpawnModule=true
    bUpdateModule=true
}