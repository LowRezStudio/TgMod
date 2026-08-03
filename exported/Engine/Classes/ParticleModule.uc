class ParticleModule extends Object
    abstract
    native(Particle)
    editinlinenew
    hidecategories(Object);

enum EModuleType
{
    EPMT_General,                   // 0
    EPMT_TypeData,                  // 1
    EPMT_Beam,                      // 2
    EPMT_Trail,                     // 3
    EPMT_Spawn,                     // 4
    EPMT_Required,                  // 5
    EPMT_Event,                     // 6
    EPMT_MAX                        // 7
};

enum EParticleSourceSelectionMethod
{
    EPSSM_Random,                   // 0
    EPSSM_Sequential,               // 1
    EPSSM_MAX                       // 2
};

struct native transient ParticleCurvePair
{
    var init string CurveName;
    var init Object CurveObject;

    structdefaultproperties
    {
        CurveName=""
        CurveObject=none
    }
};

struct native ParticleRandomSeedInfo
{
    var() name ParameterName;
    var() bool bGetSeedFromInstance;
    var() bool bInstanceSeedIsIndex;
    var() bool bResetSeedOnEmitterLooping;
    var() array<int> RandomSeeds;

    structdefaultproperties
    {
        ParameterName="None"
        bGetSeedFromInstance=false
        bInstanceSeedIsIndex=false
        bResetSeedOnEmitterLooping=true
        RandomSeeds=none
    }
};

var bool bSpawnModule;
var bool bUpdateModule;
var bool bFinalUpdateModule;
var bool bCurvesAsColor;
var(Cascade) bool b3DDrawMode;
var bool bSupported3DDrawMode;
var bool bEnabled;
var bool bEditable;
var bool LODDuplicate;
var bool bSupportsRandomSeed;
var bool bRequiresLoopingNotification;
var const byte LODValidity;

defaultproperties
{
    bEnabled=true
    bEditable=true
    LODDuplicate=true
}