class ParticleSystem extends Object
    native(Particle)
    hidecategories(Object);

enum EParticleSystemUpdateMode
{
    EPSUM_RealTime,                 // 0
    EPSUM_FixedTime,                // 1
    EPSUM_MAX                       // 2
};

enum ParticleSystemLODMethod
{
    PARTICLESYSTEMLODMETHOD_Automatic,// 0
    PARTICLESYSTEMLODMETHOD_DirectSet,// 1
    PARTICLESYSTEMLODMETHOD_ActivateAutomatic,// 2
    PARTICLESYSTEMLODMETHOD_MAX     // 3
};

enum EParticleSystemOcclusionBoundsMethod
{
    EPSOBM_None,                    // 0
    EPSOBM_ParticleBounds,          // 1
    EPSOBM_CustomBounds,            // 2
    EPSOBM_MAX                      // 3
};

struct native ParticleSystemLOD
{
    var() bool bLit;

    structdefaultproperties
    {
        bLit=false
    }
};

struct ParticleChannelContainer
{
    var bool bInitialized;
    var(Channel) bool Default;
    var(Channel) bool Friendly;
    var(Channel) bool Enemy;
    var(Channel) bool LocalOwner;
    var bool Channel5;
    var bool Channel6;
    var bool Channel7;
    var bool Channel8;
    var(Filter) bool VerticalTargeter;
    var bool Filter2;
    var(Filter) bool NotLocalOwner;
    var(Filter) bool CustomFilter1;
    var(Filter) bool CustomFilter2;
    var(Filter) bool CustomFilter3;
    var(Filter) bool CustomFilter4;
    var(Filter) bool CustomFilter5;
    var(Filter) bool CustomFilter6;
    var(Filter) bool CustomFilter7;

    structdefaultproperties
    {
        bInitialized=true
        Default=true
        Friendly=false
        Enemy=false
        LocalOwner=false
        Channel5=false
        Channel6=false
        Channel7=false
        Channel8=false
        VerticalTargeter=false
        Filter2=false
        NotLocalOwner=false
        CustomFilter1=false
        CustomFilter2=false
        CustomFilter3=false
        CustomFilter4=false
        CustomFilter5=false
        CustomFilter6=false
        CustomFilter7=false
    }
};

struct native LODSoloTrack
{
    var transient array<byte> SoloEnableSetting;

    structdefaultproperties
    {
        SoloEnableSetting=none
    }
};

var() ParticleSystem.EParticleSystemUpdateMode SystemUpdateMode;
var(LOD) ParticleSystem.ParticleSystemLODMethod LODMethod;
var(Occlusion) ParticleSystem.EParticleSystemOcclusionBoundsMethod OcclusionBoundsMethod;
var() float UpdateTime_FPS;
var float UpdateTime_Delta;
var() float WarmupTime;
var() float WarmupTickRate;
var() int TranslucencySortPriority;
var export editinline array<export editinline ParticleEmitter> Emitters;
var export editinline transient ParticleSystemComponent PreviewComponent;
var const deprecated bool bLit;
var() bool bOrientZAxisTowardCamera;
var bool bRegenerateLODDuplicate;
var(Bounds) bool bUseFixedRelativeBoundingBox;
var() bool m_bDeactivateOnInactive;
var() bool m_bDeactivateOnInactiveIfEmitterPool;
var bool m_bHasDisplayMasks;
var bool bShouldResetPeakCounts;
var transient bool bHasPhysics;
var(Thumbnail) bool bUseRealtimeThumbnail;
var bool ThumbnailImageOutOfDate;
var() bool bSkipSpawnCountCheck;
var(Delay) bool bUseDelayRange;
var export InterpCurveEdSetup CurveEdSetup;
var(LOD) float LODDistanceCheckTime;
var(LOD) editfixedsize array<float> LODDistances;
var(LOD) array<ParticleSystemLOD> LODSettings;
var(Bounds) Box FixedRelativeBoundingBox;
var() float SecondsBeforeInactive;
var(Delay) float Delay;
var(Delay) float DelayLow;
var(MacroUV) Vector MacroUVPosition;
var(MacroUV) float MacroUVRadius;
var(Occlusion) Box CustomOcclusionBounds;
var transient array<LODSoloTrack> SoloTracking;

// Export UParticleSystem::execGetCurrentLODMethod(FFrame&, void* const)
native function ParticleSystem.ParticleSystemLODMethod GetCurrentLODMethod();

// Export UParticleSystem::execGetLODLevelCount(FFrame&, void* const)
native function int GetLODLevelCount();

// Export UParticleSystem::execGetLODDistance(FFrame&, void* const)
native function float GetLODDistance(int LODLevelIndex);

// Export UParticleSystem::execSetCurrentLODMethod(FFrame&, void* const)
native function SetCurrentLODMethod(ParticleSystem.ParticleSystemLODMethod InMethod);

// Export UParticleSystem::execSetLODDistance(FFrame&, void* const)
native function bool SetLODDistance(int LODLevelIndex, float InDistance);

// Export UParticleSystem::execGetMaxLifespan(FFrame&, void* const)
native function float GetMaxLifespan(float InComponentDelay);

// Export UParticleSystem::execHasLocalEmitter(FFrame&, void* const)
native function bool HasLocalEmitter();

defaultproperties
{
    UpdateTime_FPS=60.0000000
    UpdateTime_Delta=1.0000000
    m_bDeactivateOnInactiveIfEmitterPool=true
    ThumbnailImageOutOfDate=true
    LODDistanceCheckTime=0.2500000
    FixedRelativeBoundingBox=(Min=(X=-1.0000000,Y=-1.0000000,Z=-1.0000000),Max=(X=1.0000000,Y=1.0000000,Z=1.0000000),IsValid=0)
    MacroUVRadius=200.0000000
}