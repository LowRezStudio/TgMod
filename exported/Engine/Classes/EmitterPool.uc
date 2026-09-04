class EmitterPool extends Actor
    transient
    native
    config(Game)
    notplaceable
    hidecategories(Navigation);

struct native EmitterBaseInfo
{
    var export editinline ParticleSystemComponent PSC;
    var Actor Base;
    var Vector RelativeLocation;
    var Rotator RelativeRotation;
    var bool bInheritBaseScale;

    structdefaultproperties
    {
        PSC=none
        Base=none
        RelativeLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        RelativeRotation=(Pitch=0,Yaw=0,Roll=0)
        bInheritBaseScale=false
    }
};

var protected export editinline ParticleSystemComponent PSCTemplate;
var const export editinline transient array<export editinline ParticleSystemComponent> PoolComponents;
var export editinline transient array<export editinline ParticleSystemComponent> ActiveComponents;
var int MaxActiveEffects;
var globalconfig bool bLogPoolOverflow;
var globalconfig bool bLogPoolOverflowList;
var transient array<EmitterBaseInfo> RelativePSCs;
var float SMC_MIC_ReductionTime;
var transient float SMC_MIC_CurrentReductionTime;
var int IdealStaticMeshComponents;
var int IdealMaterialInstanceConstants;
var private const export editinline transient array<export editinline StaticMeshComponent> FreeSMComponents;
var private const transient array<MaterialInstanceConstant> FreeMatInstConsts;

// Export UEmitterPool::execOnParticleSystemFinished(FFrame&, void* const)
native function OnParticleSystemFinished(ParticleSystemComponent PSC);

// Export UEmitterPool::execClearPoolComponents(FFrame&, void* const)
native final function ClearPoolComponents(optional bool bClearActive = false);

// Export UEmitterPool::execReturnToPool(FFrame&, void* const)
protected native final function ReturnToPool(ParticleSystemComponent PSC);

// Export UEmitterPool::execFreeStaticMeshComponents(FFrame&, void* const)
protected native final function FreeStaticMeshComponents(ParticleSystemComponent PSC);

// Export UEmitterPool::execGetFreeStaticMeshComponent(FFrame&, void* const)
protected native final function StaticMeshComponent GetFreeStaticMeshComponent(optional bool bCreateNewObject = true);

// Export UEmitterPool::execFreeMaterialInstanceConstants(FFrame&, void* const)
protected native final function FreeMaterialInstanceConstants(StaticMeshComponent SMC);

// Export UEmitterPool::execGetFreeMatInstConsts(FFrame&, void* const)
protected native final function MaterialInstanceConstant GetFreeMatInstConsts(optional bool bCreateNewObject = true);

// Export UEmitterPool::execGetPooledComponent(FFrame&, void* const)
protected native final function ParticleSystemComponent GetPooledComponent(ParticleSystem EmitterTemplate, bool bAutoActivate);

// Export UEmitterPool::execSpawnEmitter(FFrame&, void* const)
native function ParticleSystemComponent SpawnEmitter(ParticleSystem EmitterTemplate, Vector SpawnLocation, optional Rotator SpawnRotation, optional Actor AttachToActor, optional Actor InInstigator, optional int MaxDLEPooledReuses, optional bool bInheritScaleFromBase, optional ParticleChannelContainer PSysChannels);

// Export UEmitterPool::execSpawnEmitterMeshAttachment(FFrame&, void* const)
native function ParticleSystemComponent SpawnEmitterMeshAttachment(ParticleSystem EmitterTemplate, SkeletalMeshComponent Mesh, name AttachPointName, optional bool bAttachToSocket, optional Vector RelativeLoc, optional Rotator RelativeRot, optional ParticleChannelContainer PSysChannels);

// Export UEmitterPool::execSpawnEmitterCustomLifetime(FFrame&, void* const)
native function ParticleSystemComponent SpawnEmitterCustomLifetime(ParticleSystem EmitterTemplate, optional bool bSkipAutoActivate);

defaultproperties
{
    // Reference: ParticleSystemComponent'Engine.Default__EmitterPool.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0" class=Engine.ParticleSystemComponent
        SecondsBeforeInactive=0.0000000
        ReplacementPrimitive=none
        AbsoluteTranslation=true
        AbsoluteRotation=true
    end object
    PSCTemplate=ParticleSystemComponent0
    bLogPoolOverflow=true
    SMC_MIC_ReductionTime=2.5000000
    IdealStaticMeshComponents=250
    IdealMaterialInstanceConstants=250
}