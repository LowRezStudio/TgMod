class MaterialInstance extends MaterialInterface
    abstract
    native(Material);

var() PhysicalMaterial PhysMaterial;
var() const MaterialInterface Parent;
var(PhysicalMaterialMask) Texture2D PhysMaterialMask;
var(PhysicalMaterialMask) int PhysMaterialMaskUVChannel;
var(PhysicalMaterialMask) PhysicalMaterial BlackPhysicalMaterial;
var(PhysicalMaterialMask) PhysicalMaterial WhitePhysicalMaterial;
var bool bHasStaticPermutationResource;
var native transient bool bStaticPermutationDirty;
var private native const bool ReentrantFlag;
var private const transient bool bNeedsMaterialFlattening;
var() const bool bCleanupUnusedTextures;
var duplicatetransient const ShaderCache CookedShaderCache;
var duplicatetransient native const Pointer StaticParameters[3];
var duplicatetransient native const Pointer StaticPermutationResources[3];
var duplicatetransient native const Pointer Resources[3];
var private const deprecated array<deprecated Texture> ReferencedTextures;
var private const Guid ParentLightingGuid;

// Export UMaterialInstance::execSetParent(FFrame&, void* const)
native function SetParent(MaterialInterface NewParent);

// Export UMaterialInstance::execSetVectorParameterValue(FFrame&, void* const)
native function SetVectorParameterValue(name ParameterName, const out LinearColor Value);

// Export UMaterialInstance::execSetScalarParameterValue(FFrame&, void* const)
native function SetScalarParameterValue(name ParameterName, float Value);

// Export UMaterialInstance::execSetScalarCurveParameterValue(FFrame&, void* const)
native function SetScalarCurveParameterValue(name ParameterName, const out InterpCurveFloat Value);

// Export UMaterialInstance::execSetTextureParameterValue(FFrame&, void* const)
native function SetTextureParameterValue(name ParameterName, Texture Value);

// Export UMaterialInstance::execGetTextureParameterValue(FFrame&, void* const)
native function bool GetTextureParameterValue(name ParameterName, out Texture Value);

// Export UMaterialInstance::execSetFontParameterValue(FFrame&, void* const)
native function SetFontParameterValue(name ParameterName, Font FontValue, int FontPage);

// Export UMaterialInstance::execClearParameterValues(FFrame&, void* const)
native function ClearParameterValues();

// Export UMaterialInstance::execIsInMapOrTransientPackage(FFrame&, void* const)
native function bool IsInMapOrTransientPackage();

defaultproperties
{
    PhysMaterialMaskUVChannel=-1
}