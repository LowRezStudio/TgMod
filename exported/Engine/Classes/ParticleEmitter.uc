class ParticleEmitter extends Object
    abstract
    native(Particle)
    editinlinenew
    hidecategories(Object);

enum EParticleBurstMethod
{
    EPBM_Instant,                   // 0
    EPBM_Interpolated,              // 1
    EPBM_MAX                        // 2
};

enum EParticleSubUVInterpMethod
{
    PSUVIM_None,                    // 0
    PSUVIM_Linear,                  // 1
    PSUVIM_Linear_Blend,            // 2
    PSUVIM_Random,                  // 3
    PSUVIM_Random_Blend,            // 4
    PSUVIM_MAX                      // 5
};

enum EEmitterRenderMode
{
    ERM_Normal,                     // 0
    ERM_Point,                      // 1
    ERM_Cross,                      // 2
    ERM_None,                       // 3
    ERM_MAX                         // 4
};

struct native ParticleBurst
{
    var() int Count;
    var() int CountLow;
    var() float Time;

    structdefaultproperties
    {
        Count=0
        CountLow=-1
        Time=0.0000000
    }
};

var(Particle) name EmitterName;
var() editconst int m_nActivationMask;
var() ParticleChannelContainer m_ParticleChannels;
var transient int SubUVDataOffset;
var(Cascade) ParticleEmitter.EEmitterRenderMode EmitterRenderMode;
var export editinline array<export editinline ParticleLODLevel> LODLevels;
var bool ConvertedModules;
var(Cascade) editoronly bool bCollapsed;
var transient bool bIsSoloing;
var bool bCookedOut;
var int PeakActiveParticles;
var(Particle) int InitialAllocationCount;
var(Particle) float MediumDetailSpawnRateScale;

// Export UParticleEmitter::execGetMaxLifespan(FFrame&, void* const)
native function float GetMaxLifespan(float InComponentDelay);

defaultproperties
{
    EmitterName="Particle Emitter"
    m_ParticleChannels=(bInitialized=false,Default=true,Friendly=false,Enemy=false,LocalOwner=false,Channel5=false,Channel6=false,Channel7=false,Channel8=false,VerticalTargeter=false,Filter2=false,NotLocalOwner=false,CustomFilter1=false,CustomFilter2=false,CustomFilter3=false,CustomFilter4=false,CustomFilter5=false,CustomFilter6=false,CustomFilter7=false)
    ConvertedModules=true
    MediumDetailSpawnRateScale=1.0000000
}