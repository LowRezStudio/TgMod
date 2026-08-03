class TgStaticMeshComponent extends StaticMeshComponent
    native(Pawns)
    editinlinenew
    hidecategories(Object);

var bool c_bFxApplied;
var array<TgSpecialFx> c_FxList;
var array<TgSpecialFx> c_DatabaseFxList;
var array<Fx_AssemblyData> c_FxAssemblyData;
var int m_nAssemblyId;

// Export UTgStaticMeshComponent::execFxAdd(FFrame&, void* const)
native function FxAdd(Object Fx);

// Export UTgStaticMeshComponent::execFxRemove(FFrame&, void* const)
native function FxRemove(Object Fx);

// Export UTgStaticMeshComponent::execFxGet(FFrame&, void* const)
native function Object FxGet(name nmGroup, int nMode, optional int nIndex, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgStaticMeshComponent::execFxGetAll(FFrame&, void* const)
native function array<Object> FxGetAll(name nmGroup, int nMode, optional int nIndex, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgStaticMeshComponent::execFxActivateGroup(FFrame&, void* const)
native function Object FxActivateGroup(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgStaticMeshComponent::execFxDeactivateGroup(FFrame&, void* const)
native function FxDeactivateGroup(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgStaticMeshComponent::execFxDeactivateAll(FFrame&, void* const)
native function FxDeactivateAll(optional int nEquipSlot);

// Export UTgStaticMeshComponent::execFxSpawnTracer(FFrame&, void* const)
native function FxSpawnTracer(name nmGroup, int nMode, Vector HitLocation, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgStaticMeshComponent::execFxSpawnEmitter(FFrame&, void* const)
native function FxSpawnEmitter(name nmGroup, int nMode, Vector HitLocation, Vector HitNormal, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgStaticMeshComponent::execFxSpawnSound(FFrame&, void* const)
native function FxSpawnSound(name nmGroup, int nMode, Vector SoundLocation, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgStaticMeshComponent::execFxActivateIndependant(FFrame&, void* const)
native function Object FxActivateIndependant(name nmGroup, int nMode, Vector HitLocation, Vector HitNormal, optional int nSocketIndex, optional int nEquipSlot, optional bool bUseSocketOverride = true, optional array<ParticleSysParam> Params);

// Export UTgStaticMeshComponent::execSwapMaterial(FFrame&, void* const)
native function SwapMaterial(MaterialInterface MI, optional bool bNoParamReaping);

// Export UTgStaticMeshComponent::execSetDefaultSkin(FFrame&, void* const)
native function SetDefaultSkin(int nIndex);

// Export UTgStaticMeshComponent::execGetDefaultMaterial(FFrame&, void* const)
native function MaterialInterface GetDefaultMaterial(int nIndex);

// Export UTgStaticMeshComponent::execOnMeshSetHidden(FFrame&, void* const)
native function OnMeshSetHidden(bool bHidden);

// Export UTgStaticMeshComponent::execRecalculateFx(FFrame&, void* const)
native function RecalculateFx();

defaultproperties
{
    ReplacementPrimitive=none
}