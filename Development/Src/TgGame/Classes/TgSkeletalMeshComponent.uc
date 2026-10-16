class TgSkeletalMeshComponent extends SkeletalMeshComponent
    native(Pawns)
    editinlinenew
    hidecategories(Object)
    config(Engine);

struct AnimNotifyParticleCacheEntry {
    var bool bCached;
    var AnimNotify_PlayParticleEffect Notify;
    var export editinline ParticleSystemComponent PSC;
    structdefaultproperties {}
};

var bool c_bFxApplied;
var bool c_bIsFemale;
var array<TgSpecialFx> c_FxList;
var array<TgSpecialFx> c_DatabaseFxList;
var int m_nAssemblyId;
var Vector FPCTranslation;
var Rotator FPCRotation;
var Vector FPCScale;
var int c_AudioGroupId;
var int c_nForceUpdateAttachmentsInTick;
var export editinline array<export editinline TgHeadShotComponent> c_HeadShotComponents;
var init transient array<init AnimNotifyParticleCacheEntry> AnimNotifyPlayParticleEffectEntries;

native function InitRagdoll();  // Export UTgSkeletalMeshComponent::execInitRagdoll(FFrame&, void* const)

native function EndRagdoll();  // Export UTgSkeletalMeshComponent::execEndRagdoll(FFrame&, void* const)

native function FxAdd(Object Fx);  // Export UTgSkeletalMeshComponent::execFxAdd(FFrame&, void* const)

native function FxRemove(Object Fx);  // Export UTgSkeletalMeshComponent::execFxRemove(FFrame&, void* const)

native function Object FxGet(name nmGroup, int nMode, optional int nIndex, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgSkeletalMeshComponent::execFxGet(FFrame&, void* const)

native function array<Object> FxGetAll(name nmGroup, int nMode, optional int nIndex, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgSkeletalMeshComponent::execFxGetAll(FFrame&, void* const)

native function Object FxActivateGroup(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgSkeletalMeshComponent::execFxActivateGroup(FFrame&, void* const)

native function FxDeactivateGroup(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgSkeletalMeshComponent::execFxDeactivateGroup(FFrame&, void* const)

native function FxDeactivateAll(optional int nEquipSlot);  // Export UTgSkeletalMeshComponent::execFxDeactivateAll(FFrame&, void* const)

native function FxSpawnTracer(name nmGroup, int nMode, Vector HitLocation, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgSkeletalMeshComponent::execFxSpawnTracer(FFrame&, void* const)

native function FxSpawnEmitter(name nmGroup, int nMode, Vector HitLocation, Vector HitNormal, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgSkeletalMeshComponent::execFxSpawnEmitter(FFrame&, void* const)

native function FxSpawnSound(name nmGroup, int nMode, Vector SoundLocation, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgSkeletalMeshComponent::execFxSpawnSound(FFrame&, void* const)

native function Object FxActivateIndependant(name nmGroup, int nMode, Vector HitLocation, Vector HitNormal, optional int nSocketIndex, optional int nEquipSlot, optional bool bUseSocketOverride=true, optional array<ParticleSysParam> Params);  // Export UTgSkeletalMeshComponent::execFxActivateIndependant(FFrame&, void* const)

native function SetDefaultSkin(int nIndex);  // Export UTgSkeletalMeshComponent::execSetDefaultSkin(FFrame&, void* const)

native function MaterialInterface GetDefaultMaterial(int nIndex);  // Export UTgSkeletalMeshComponent::execGetDefaultMaterial(FFrame&, void* const)

native function SwapMaterial(MaterialInterface MI, optional bool bNoParamReaping);  // Export UTgSkeletalMeshComponent::execSwapMaterial(FFrame&, void* const)

native function float GetCurrentDeployPercentage();  // Export UTgSkeletalMeshComponent::execGetCurrentDeployPercentage(FFrame&, void* const)

native function ActivateOnWhenDeployedFx(bool bOn);  // Export UTgSkeletalMeshComponent::execActivateOnWhenDeployedFx(FFrame&, void* const)

native function ActivateWhileAliveFx(bool bOn, optional name nmDisplayGroup);  // Export UTgSkeletalMeshComponent::execActivateWhileAliveFx(FFrame&, void* const)

native function RecalculateFx();  // Export UTgSkeletalMeshComponent::execRecalculateFx(FFrame&, void* const)

native function OnMeshSetHidden(bool bHidden);  // Export UTgSkeletalMeshComponent::execOnMeshSetHidden(FFrame&, void* const)

native function AnimTree GetAnimTree();  // Export UTgSkeletalMeshComponent::execGetAnimTree(FFrame&, void* const)

native function SetForceUpdateAttachmentsInTick(bool bSet);  // Export UTgSkeletalMeshComponent::execSetForceUpdateAttachmentsInTick(FFrame&, void* const)

function bool GetAnimNotifyParticleCacheEntryFor(const AnimNotify_PlayParticleEffect AnimNotifyData, out AnimNotifyParticleCacheEntry CacheEntry) { }

function ParticleSystemComponent GetPSCForPlayParticleEffect(const AnimNotify_PlayParticleEffect AnimNotifyData) { }

function CachePSC(ParticleSystemComponent PSC, AnimNotifyParticleCacheEntry CacheEntry, const AnimNotify_PlayParticleEffect AnimNotifyData) { }

defaultproperties
{
    c_nOverrideSkinId=-1
    c_nOverrideSkinLevel=-1
    ReplacementPrimitive=none
}
