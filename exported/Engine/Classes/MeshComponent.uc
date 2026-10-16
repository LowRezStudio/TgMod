class MeshComponent extends PrimitiveComponent
    abstract
    native(Mesh)
    noexport;

var(Rendering) const array<MaterialInterface> Materials;
var int MatResGrpId;
var array<MaterialInterface> SavedBodyMICs;
var array<MaterialInterface> DefaultBodyMICs;
var array<MaterialInterface> DyedBodyMICs;
var transient bool m_bForceHideComponent;

// Export UMeshComponent::execGetMaterial(FFrame&, void* const)
native function MaterialInterface GetMaterial(int ElementIndex);

// Export UMeshComponent::execSetMaterial(FFrame&, void* const)
native function SetMaterial(int ElementIndex, MaterialInterface Material);

// Export UMeshComponent::execGetNumElements(FFrame&, void* const)
native function int GetNumElements();

// Export UMeshComponent::execPrestreamTextures(FFrame&, void* const)
native final function PrestreamTextures(float Seconds, bool bPrioritizeCharacterTextures, optional int CinematicTextureGroups = 0);

function MaterialInstanceConstant CreateAndSetMaterialInstanceConstant(int ElementIndex)
{
    local MaterialInstanceConstant Instance;

    Instance = new (self) Class'Engine.MaterialInstanceConstant';
    Instance.SetParent(GetMaterial(ElementIndex));
    SetMaterial(ElementIndex, Instance);
    return Instance;
    //return ReturnValue;    
}

function MaterialInstanceTimeVarying CreateAndSetMaterialInstanceTimeVarying(int ElementIndex)
{
    local MaterialInstanceTimeVarying Instance;

    Instance = new (self) Class'Engine.MaterialInstanceTimeVarying';
    Instance.SetParent(GetMaterial(ElementIndex));
    SetMaterial(ElementIndex, Instance);
    return Instance;
    //return ReturnValue;    
}

// Export UMeshComponent::execFxAdd(FFrame&, void* const)
native function FxAdd(Object Fx);

// Export UMeshComponent::execFxRemove(FFrame&, void* const)
native function FxRemove(Object Fx);

// Export UMeshComponent::execFxGet(FFrame&, void* const)
native function Object FxGet(name nmGroup, int nMode, optional int nIndex, optional int nSocketIndex, optional int nEquipSlot);

// Export UMeshComponent::execFxGetAll(FFrame&, void* const)
native function array<Object> FxGetAll(name nmGroup, int nMode, optional int nIndex, optional int nSocketIndex, optional int nEquipSlot);

// Export UMeshComponent::execFxActivateGroup(FFrame&, void* const)
native function Object FxActivateGroup(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UMeshComponent::execFxDeactivateGroup(FFrame&, void* const)
native function FxDeactivateGroup(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);

// Export UMeshComponent::execFxDeactivateAll(FFrame&, void* const)
native function FxDeactivateAll(optional int nEquipSlot);

// Export UMeshComponent::execFxSpawnTracer(FFrame&, void* const)
native function FxSpawnTracer(name nmGroup, int nMode, Vector HitLocation, optional int nSocketIndex, optional int nEquipSlot);

// Export UMeshComponent::execFxSpawnEmitter(FFrame&, void* const)
native function FxSpawnEmitter(name nmGroup, int nMode, Vector HitLocation, Vector HitNormal, optional int nSocketIndex, optional int nEquipSlot);

// Export UMeshComponent::execFxSpawnSound(FFrame&, void* const)
native function FxSpawnSound(name nmGroup, int nMode, Vector SoundLocation, optional int nSocketIndex, optional int nEquipSlot);

// Export UMeshComponent::execFxActivateIndependant(FFrame&, void* const)
native function Object FxActivateIndependant(name nmGroup, int nMode, Vector HitLocation, Vector HitNormal, optional int nSocketIndex, optional int nEquipSlot, optional bool bUseSocketOverride = true, optional array<ParticleSysParam> Params);

// Export UMeshComponent::execSetDefaultSkin(FFrame&, void* const)
native function SetDefaultSkin(int nIndex);

// Export UMeshComponent::execGetDefaultMaterial(FFrame&, void* const)
native function MaterialInterface GetDefaultMaterial(int nIndex);

// Export UMeshComponent::execOnMeshSetHidden(FFrame&, void* const)
native function OnMeshSetHidden(bool bHidden);

// Export UMeshComponent::execSwapMaterial(FFrame&, void* const)
native function SwapMaterial(MaterialInterface MI, optional bool bNoParamReaping);

// Export UMeshComponent::execApplyDye(FFrame&, void* const)
native function ApplyDye(MaterialInterface PrimaryDyeMI, MaterialInterface SecondaryDyeMI, MaterialInterface EmissiveDyeMI);

// Export UMeshComponent::execRecalculateFx(FFrame&, void* const)
native function RecalculateFx();

defaultproperties
{
    ReplacementPrimitive=none
    bUseAsOccluder=true
    CastShadow=true
    bAcceptsLights=true
}