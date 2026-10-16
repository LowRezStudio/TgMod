class LensFlareComponent extends PrimitiveComponent
    native(LensFlare)
    editinlinenew
    hidecategories(Object,Physics,Collision);

struct LensFlareElementInstance
{
};

struct native LensFlareElementMaterials
{
    var() array<MaterialInterface> ElementMaterials;

    structdefaultproperties
    {
        ElementMaterials=none
    }
};

var() const LensFlare Template;
var const export editinline DrawLightConeComponent PreviewInnerCone;
var const export editinline DrawLightConeComponent PreviewOuterCone;
var const export editinline DrawLightRadiusComponent PreviewRadius;
var() bool bAutoActivate;
var transient bool bIsActive;
var transient bool bHasTranslucency;
var transient bool bHasUnlitTranslucency;
var transient bool bHasUnlitDistortion;
var transient bool bUsesSceneColor;
var transient bool bHasSeparateTranslucency;
var transient bool bUseTrueConeCalculation;
var bool bVisibleForMobile;
var transient float OuterCone;
var transient float InnerCone;
var transient float ConeFudgeFactor;
var transient float Radius;
var transient float MinStrength;
var(Rendering) LinearColor SourceColor;
var transient array<LensFlareElementMaterials> Materials;
var native const Pointer ReleaseResourcesFence;
var transient float NextTraceTime;

// Export ULensFlareComponent::execSetTemplate(FFrame&, void* const)
native final function SetTemplate(LensFlare NewTemplate, optional bool bForceSet = false);

// Export ULensFlareComponent::execSetSourceColor(FFrame&, void* const)
native function SetSourceColor(LinearColor InSourceColor);

// Export ULensFlareComponent::execSetIsActive(FFrame&, void* const)
native function SetIsActive(bool bInIsActive);

// Export ULensFlareComponent::execGetMaterial(FFrame&, void* const)
native function MaterialInterface GetMaterial(int ElementIndex);

// Export ULensFlareComponent::execSetMaterial(FFrame&, void* const)
native function SetMaterial(int ElementIndex, MaterialInterface Material);

function MaterialInstanceConstant CreateAndSetMaterialInstanceConstant(int ElementIndex)
{
    local MaterialInstanceConstant Instance;

    Instance = new (self) Class'Engine.MaterialInstanceConstant';
    Instance.SetParent(GetMaterial(ElementIndex));
    SetMaterial(ElementIndex, Instance);
    return Instance;
    //return ReturnValue;    
}

defaultproperties
{
    bAutoActivate=true
    SourceColor=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000)
    ReplacementPrimitive=none
    bFirstFrameOcclusion=true
    bIgnoreNearPlaneIntersection=true
    bTickInEditor=true
    TickGroup=ETickingGroup.TG_PostAsyncWork
}