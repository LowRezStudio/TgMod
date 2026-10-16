class ParticleSystemComponent extends PrimitiveComponent
    native(Particle)
    editinlinenew
    hidecategories(Object,Physics,Collision);

enum ParticleReplayState
{
    PRS_Disabled,                   // 0
    PRS_Capturing,                  // 1
    PRS_Replaying,                  // 2
    PRS_MAX                         // 3
};

enum EParticleEventType
{
    EPET_Any,                       // 0
    EPET_Spawn,                     // 1
    EPET_Death,                     // 2
    EPET_Collision,                 // 3
    EPET_WorldAttractorCollision,   // 4
    EPET_Kismet,                    // 5
    EPET_MAX                        // 6
};

struct ParticleEmitterInstance
{
};

struct native ParticleEmitterInstanceMotionBlurInfo
{
    var native const transient Map_Mirror ParticleMBInfoMap;
};

struct native ViewParticleEmitterInstanceMotionBlurInfo
{
    var native const transient Map_Mirror EmitterInstanceMBInfoMap;
};

struct native ParticleEventData
{
    var int Type;
    var name EventName;
    var float EmitterTime;
    var Vector Location;
    var Vector Direction;
    var Vector Velocity;

    structdefaultproperties
    {
        Type=0
        EventName="None"
        EmitterTime=0.0000000
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Direction=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Velocity=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

struct native ParticleEventSpawnData extends ParticleEventData
{
};

struct native ParticleEventDeathData extends ParticleEventData
{
    var float ParticleTime;
};

struct native ParticleEventCollideData extends ParticleEventData
{
    var float ParticleTime;
    var Vector Normal;
    var float Time;
    var int Item;
    var name BoneName;
};

struct native ParticleEventAttractorCollideData extends ParticleEventCollideData
{
};

struct native ParticleEventKismetData extends ParticleEventData
{
    var bool UsePSysCompLocation;
    var Vector Normal;
};

var() const ParticleSystem Template;
var Class<ParticleLightEnvironmentComponent> LightEnvironmentClass;
var transient Actor LightEnvironmentSharedInstigator;
var transient int MaxLightEnvironmentPooledReuses;
var native const transient array<Pointer> EmitterInstances;
var private duplicatetransient const transient array<export editinline StaticMeshComponent> SMComponents;
var private duplicatetransient const transient array<MaterialInterface> SMMaterialInterfaces;
var private duplicatetransient const transient array<export editinline SkeletalMeshComponent> SkelMeshComponents;
var native const transient array<ViewParticleEmitterInstanceMotionBlurInfo> ViewMBInfoArray;
var() bool bAutoActivate;
var const transient bool bWasCompleted;
var const transient bool bHasDurationElapsed;
var const transient bool bSuppressSpawning;
var const transient bool bWasDeactivated;
var() bool bResetOnDetach;
var bool bUpdateOnDedicatedServer;
var transient bool bJustAttached;
var transient bool bIsActive;
var transient bool bHasBeenActivated;
var bool bWarmingUp;
var bool bIsCachedInPool;
var(LOD) bool bOverrideLODMethod;
var bool bSkipUpdateDynamicDataDuringTick;
var bool bSkipBoundsUpdate;
var bool bUpdateComponentInTick;
var bool bDeferredBeamUpdate;
var transient bool bForcedInActive;
var transient bool bIsWarmingUp;
var transient bool bIsViewRelevanceDirty;
var transient bool bRecacheViewRelevance;
var bool m_EmitBasedOnAnimNotify;
var transient bool bLODUpdatePending;
var transient bool bSkipSpawnCountCheck;
var transient bool m_bRealTimeTicking;
var const bool bHasSavedScale3D;
var() editinline array<editinline ParticleSysParam> InstanceParameters;
var Vector OldPosition;
var Vector PartSysVelocity;
var float WarmupTime;
var float WarmupTickRate;
var private transient int LODLevel;
var() float SecondsBeforeInactive;
var private transient float TimeSinceLastForceUpdateTransform;
var float MaxTimeBeforeForceUpdateTransform;
var transient float AccumTickTime;
var(LOD) ParticleSystem.ParticleSystemLODMethod LODMethod;
var const transient ParticleSystemComponent.ParticleReplayState ReplayState;
var const transient array<MaterialViewRelevance> CachedViewRelevanceFlags;
var float m_ActiveRemainingTime;
var transient ParticleChannelContainer m_ParticleChannels;
var() const editinline array<editinline ParticleSystemReplay> ReplayClips;
var const transient int ReplayClipIDNumber;
var const transient int ReplayFrameIndex;
var transient float AccumLODDistanceCheckTime;
var transient array<ParticleEventSpawnData> SpawnEvents;
var transient array<ParticleEventDeathData> DeathEvents;
var transient array<ParticleEventCollideData> CollisionEvents;
var transient array<ParticleEventKismetData> KismetEvents;
var transient array<ParticleEventAttractorCollideData> AttractorCollisionEvents;
var native const transient Pointer ReleaseResourcesFence;
var() float CustomTimeDilation;
var transient float EmitterDelay;
var const float FOV;
var const Vector SavedScale3D;
//var delegate<OnSystemFinished> __OnSystemFinished__Delegate;
//var delegate<OnSystemDurationElapsed> __OnSystemDurationElapsed__Delegate;

delegate OnSystemFinished(ParticleSystemComponent PSystem)
{
    //return;    
}

delegate OnSystemDurationElapsed(ParticleSystemComponent PSystem)
{
    //return;    
}

// Export UParticleSystemComponent::execSetTemplate(FFrame&, void* const)
native final function SetTemplate(ParticleSystem NewTemplate);

// Export UParticleSystemComponent::execActivateSystem(FFrame&, void* const)
native final function ActivateSystem(optional bool bFlagAsJustAttached = false);

// Export UParticleSystemComponent::execDeactivateSystem(FFrame&, void* const)
native final function DeactivateSystem();

// Export UParticleSystemComponent::execKillParticlesForced(FFrame&, void* const)
native final function KillParticlesForced();

// Export UParticleSystemComponent::execKillParticlesInEmitter(FFrame&, void* const)
native final function KillParticlesInEmitter(name InEmitterName);

// Export UParticleSystemComponent::execSetSkipUpdateDynamicDataDuringTick(FFrame&, void* const)
native final function SetSkipUpdateDynamicDataDuringTick(bool bInSkipUpdateDynamicDataDuringTick);

// Export UParticleSystemComponent::execGetSkipUpdateDynamicDataDuringTick(FFrame&, void* const)
native final function bool GetSkipUpdateDynamicDataDuringTick();

// Export UParticleSystemComponent::execSetSkipBoundsUpdate(FFrame&, void* const)
native final function SetSkipBoundsUpdate(bool bInSkipBoundsUpdate);

// Export UParticleSystemComponent::execGetSkipBoundsUpdate(FFrame&, void* const)
native final function bool GetSkipBoundsUpdate();

// Export UParticleSystemComponent::execSetKillOnDeactivate(FFrame&, void* const)
native function SetKillOnDeactivate(int EmitterIndex, bool bKill);

// Export UParticleSystemComponent::execSetKillOnCompleted(FFrame&, void* const)
native function SetKillOnCompleted(int EmitterIndex, bool bKill);

// Export UParticleSystemComponent::execRewindEmitterInstance(FFrame&, void* const)
native function RewindEmitterInstance(int EmitterIndex);

// Export UParticleSystemComponent::execRewindEmitterInstances(FFrame&, void* const)
native function RewindEmitterInstances();

// Export UParticleSystemComponent::execSetBeamType(FFrame&, void* const)
native function SetBeamType(int EmitterIndex, int NewMethod);

// Export UParticleSystemComponent::execSetBeamTessellationFactor(FFrame&, void* const)
native function SetBeamTessellationFactor(int EmitterIndex, float NewFactor);

// Export UParticleSystemComponent::execSetBeamEndPoint(FFrame&, void* const)
native function SetBeamEndPoint(int EmitterIndex, Vector NewEndPoint);

// Export UParticleSystemComponent::execSetBeamDistance(FFrame&, void* const)
native function SetBeamDistance(int EmitterIndex, float Distance);

// Export UParticleSystemComponent::execSetBeamSourcePoint(FFrame&, void* const)
native function SetBeamSourcePoint(int EmitterIndex, Vector NewSourcePoint, int SourceIndex);

// Export UParticleSystemComponent::execSetBeamSourceTangent(FFrame&, void* const)
native function SetBeamSourceTangent(int EmitterIndex, Vector NewTangentPoint, int SourceIndex);

// Export UParticleSystemComponent::execSetBeamSourceStrength(FFrame&, void* const)
native function SetBeamSourceStrength(int EmitterIndex, float NewSourceStrength, int SourceIndex);

// Export UParticleSystemComponent::execSetBeamTargetPoint(FFrame&, void* const)
native function SetBeamTargetPoint(int EmitterIndex, Vector NewTargetPoint, int TargetIndex);

// Export UParticleSystemComponent::execSetBeamTargetTangent(FFrame&, void* const)
native function SetBeamTargetTangent(int EmitterIndex, Vector NewTangentPoint, int TargetIndex);

// Export UParticleSystemComponent::execSetBeamTargetStrength(FFrame&, void* const)
native function SetBeamTargetStrength(int EmitterIndex, float NewTargetStrength, int TargetIndex);

// Export UParticleSystemComponent::execDetermineLODLevelForLocation(FFrame&, void* const)
native function int DetermineLODLevelForLocation(const out Vector EffectLocation);

// Export UParticleSystemComponent::execDetermineDesiredLODLevel(FFrame&, void* const)
native function int DetermineDesiredLODLevel();

// Export UParticleSystemComponent::execGetMaxLifespan(FFrame&, void* const)
native function float GetMaxLifespan();

// Export UParticleSystemComponent::execSystemHasCompleted(FFrame&, void* const)
native function bool SystemHasCompleted();

// Export UParticleSystemComponent::execSystemHasDurationElapsed(FFrame&, void* const)
native function bool SystemHasDurationElapsed();

// Export UParticleSystemComponent::execSetLODLevel(FFrame&, void* const)
native final function SetLODLevel(int InLODLevel);

// Export UParticleSystemComponent::execSetEditorLODLevel(FFrame&, void* const)
native final function SetEditorLODLevel(int InLODLevel);

// Export UParticleSystemComponent::execGetLODLevel(FFrame&, void* const)
native final function int GetLODLevel();

// Export UParticleSystemComponent::execGetEditorLODLevel(FFrame&, void* const)
native final function int GetEditorLODLevel();

// Export UParticleSystemComponent::execSetFloatParameter(FFrame&, void* const)
native final function SetFloatParameter(name ParameterName, float Param);

// Export UParticleSystemComponent::execSetFloatRandParameter(FFrame&, void* const)
native final function SetFloatRandParameter(name ParameterName, float Param, float ParamLow);

// Export UParticleSystemComponent::execSetVectorParameter(FFrame&, void* const)
native final function SetVectorParameter(name ParameterName, Vector Param);

// Export UParticleSystemComponent::execSetVectorRandParameter(FFrame&, void* const)
native final function SetVectorRandParameter(name ParameterName, const out Vector Param, const out Vector ParamLow);

// Export UParticleSystemComponent::execSetColorParameter(FFrame&, void* const)
native final function SetColorParameter(name ParameterName, Color Param);

// Export UParticleSystemComponent::execSetActorParameter(FFrame&, void* const)
native final function SetActorParameter(name ParameterName, Actor Param);

// Export UParticleSystemComponent::execSetMaterialParameter(FFrame&, void* const)
native final function SetMaterialParameter(name ParameterName, MaterialInterface Param);

// Export UParticleSystemComponent::execSetValueNameParameter(FFrame&, void* const)
native final function SetValueNameParameter(name ParameterName, name Param);

// Export UParticleSystemComponent::execGetFloatParameter(FFrame&, void* const)
native function bool GetFloatParameter(const name InName, out float OutFloat);

// Export UParticleSystemComponent::execGetVectorParameter(FFrame&, void* const)
native function bool GetVectorParameter(const name InName, out Vector OutVector);

// Export UParticleSystemComponent::execGetColorParameter(FFrame&, void* const)
native function bool GetColorParameter(const name InName, out Color OutColor);

// Export UParticleSystemComponent::execGetActorParameter(FFrame&, void* const)
native function bool GetActorParameter(const name InName, out Actor OutActor);

// Export UParticleSystemComponent::execGetMaterialParameter(FFrame&, void* const)
native function bool GetMaterialParameter(const name InName, out MaterialInterface OutMaterial);

// Export UParticleSystemComponent::execGetValueNameParameter(FFrame&, void* const)
native function bool GetValueNameParameter(const name ParameterName, out name Param);

// Export UParticleSystemComponent::execClearParameter(FFrame&, void* const)
native final function ClearParameter(name ParameterName, optional PrimitiveComponent.EParticleSysParamType ParameterType);

// Export UParticleSystemComponent::execSetActive(FFrame&, void* const)
native final function SetActive(bool bNowActive, optional bool bFlagAsJustAttached);

// Export UParticleSystemComponent::execResetToDefaults(FFrame&, void* const)
native final function ResetToDefaults();

// Export UParticleSystemComponent::execSetStopSpawning(FFrame&, void* const)
native final function SetStopSpawning(int InEmitterIndex, bool bInStopSpawning);

// Export UParticleSystemComponent::execUpdateEmitterMasks(FFrame&, void* const)
native function UpdateEmitterMasks();

// Export UParticleSystemComponent::execSetFOV(FFrame&, void* const)
native final function SetFOV(float NewFOV);

defaultproperties
{
    LightEnvironmentClass=Class'Engine.ParticleLightEnvironmentComponent'
    MaxLightEnvironmentPooledReuses=10
    bAutoActivate=true
    bIsViewRelevanceDirty=true
    SecondsBeforeInactive=1.0000000
    MaxTimeBeforeForceUpdateTransform=5.0000000
    m_ParticleChannels=(bInitialized=true,Default=true,Friendly=false,Enemy=false,LocalOwner=false,Channel5=false,Channel6=false,Channel7=false,Channel8=false,VerticalTargeter=false,Filter2=false,NotLocalOwner=false,CustomFilter1=false,CustomFilter2=false,CustomFilter3=false,CustomFilter4=false,CustomFilter5=false,CustomFilter6=false,CustomFilter7=false)
    CustomTimeDilation=1.0000000
    ReplacementPrimitive=none
    bTickInEditor=true
}