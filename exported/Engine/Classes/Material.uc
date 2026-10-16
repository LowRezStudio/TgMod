class Material extends MaterialInterface
    native(Material)
    hidecategories(Object);

struct MaterialInput
{
    var MaterialExpression Expression;
    var int OutputIndex;
    var string InputName;
    var int Mask;
    var int MaskR;
    var int MaskG;
    var int MaskB;
    var int MaskA;
    var int GCC64_Padding;

    structdefaultproperties
    {
        Expression=none
        OutputIndex=0
        InputName=""
        Mask=0
        MaskR=0
        MaskG=0
        MaskB=0
        MaskA=0
        GCC64_Padding=0
    }
};

struct ColorMaterialInput extends MaterialInput
{
    var bool UseConstant;
    var Color Constant;
};

struct ScalarMaterialInput extends MaterialInput
{
    var bool UseConstant;
    var float Constant;
};

struct VectorMaterialInput extends MaterialInput
{
    var bool UseConstant;
    var Vector Constant;
};

struct Vector2MaterialInput extends MaterialInput
{
    var bool UseConstant;
    var float ConstantX;
    var float ConstantY;
};

struct native MaterialFunctionInfo
{
    var Guid StateId;
    var MaterialFunction Function;

    structdefaultproperties
    {
        StateId=(A=0,B=0,C=0,D=0)
        Function=none
    }
};

var(PhysicalMaterial) PhysicalMaterial PhysMaterial;
var Class<PhysicalMaterial> PhysicalMaterial;
var(PhysicalMaterial) Texture2D PhysMaterialMask;
var(PhysicalMaterial) int PhysMaterialMaskUVChannel;
var(PhysicalMaterial) PhysicalMaterial BlackPhysicalMaterial;
var(PhysicalMaterial) PhysicalMaterial WhitePhysicalMaterial;
var ColorMaterialInput DiffuseColor;
var ScalarMaterialInput DiffusePower;
var ColorMaterialInput SpecularColor;
var ScalarMaterialInput SpecularPower;
var VectorMaterialInput Normal;
var ColorMaterialInput EmissiveColor;
var ScalarMaterialInput Opacity;
var ScalarMaterialInput OpacityMask;
var() float OpacityMaskClipValue;
var(Misc) float ShadowDepthBias;
var Vector2MaterialInput Distortion;
var() EngineTypes.EBlendMode BlendMode;
var() EngineTypes.EMaterialLightingModel LightingModel;
var(D3D11) const EngineTypes.EMaterialTessellationMode D3D11TessellationMode;
var ColorMaterialInput CustomLighting;
var ColorMaterialInput CustomSkylightDiffuse;
var VectorMaterialInput AnisotropicDirection;
var ScalarMaterialInput TwoSidedLightingMask;
var ColorMaterialInput TwoSidedLightingColor;
var VectorMaterialInput WorldPositionOffset;
var VectorMaterialInput WorldDisplacement;
var ScalarMaterialInput TessellationMultiplier;
var ColorMaterialInput SubsurfaceInscatteringColor;
var ColorMaterialInput SubsurfaceAbsorptionColor;
var ScalarMaterialInput SubsurfaceScatteringRadius;
var(D3D11) bool EnableSubsurfaceScattering;
var(Misc) bool EnableSeparateTranslucency;
var(D3D11) bool bEnableMaskedAntialiasing;
var() bool TwoSided;
var(Translucency) bool TwoSidedSeparatePass;
var(Translucency) bool bDisableDepthTest;
var(Translucency) bool bSceneTextureRenderBehindTranslucency;
var(Translucency) bool bAllowFog;
var(Translucency) bool bTranslucencyReceiveDominantShadowsFromStatic;
var(Translucency) bool bTranslucencyInheritDominantShadowsFromOpaque;
var(Translucency) bool bAllowTranslucencyDoF;
var(Translucency) bool bUseOneLayerDistortion;
var(Translucency) bool bUseLitTranslucencyDepthPass;
var(Translucency) bool bUseLitTranslucencyPostRenderDepthPass;
var(Translucency) bool bCastLitTranslucencyShadowAsMasked;
var(MutuallyExclusiveUsage) const bool bUsedAsLightFunction;
var(MutuallyExclusiveUsage) const bool bUsedWithFogVolumes;
var duplicatetransient const bool bUsedAsSpecialEngineMaterial;
var(Usage) const bool bUsedWithSkeletalMesh;
var(Usage) const bool bUsedWithTerrain;
var(Usage) const bool bUsedWithLandscape;
var(Usage) const bool bUsedWithMobileLandscape;
var(Usage) const bool bUsedWithFracturedMeshes;
var const bool bUsedWithParticleSystem;
var(Usage) const bool bUsedWithParticleSprites;
var(Usage) const bool bUsedWithBeamTrails;
var(Usage) const bool bUsedWithParticleSubUV;
var(Usage) const bool bUsedWithSpeedTree;
var(Usage) const bool bUsedWithStaticLighting;
var(Usage) const bool bUsedWithLensFlare;
var(Usage) const bool bUsedWithGammaCorrection;
var(Usage) const bool bUsedWithInstancedMeshParticles;
var(Usage) const bool bUsedWithFluidSurfaces;
var(MutuallyExclusiveUsage) const bool bUsedWithDecals;
var(Usage) const bool bUsedWithMaterialEffect;
var(Usage) const bool bUsedWithMorphTargets;
var(Usage) const bool bUsedWithRadialBlur;
var(Usage) const bool bUsedWithInstancedMeshes;
var(Usage) const bool bUsedWithSplineMeshes;
var(Usage) const bool bUsedWithAPEXMeshes;
var(Usage) const bool bUsedWithScreenDoorFade;
var(D3D11) const bool bEnableCrackFreeDisplacement;
var(D3D11) const bool bTessellationFrustumCulling;
var(D3D11) const bool bTessellationBackfaceCulling;
var(D3D11) bool bUseImageBasedReflections;
var(Misc) bool Wireframe;
var(Misc) bool bPerPixelCameraVector;
var(Misc) bool bAllowLightmapSpecular;
var(Misc) bool bOverrideLowQualitySpecular;
var(Misc) const bool bCleanupUnusedTextures;
var deprecated bool bIsFallbackMaterial;
var private bool bUsesDistortion;
var private bool bIsMasked;
var private duplicatetransient transient bool bIsPreviewMaterial;
var(D3D11) float ImageReflectionNormalDampening;
var duplicatetransient const ShaderCache CookedShaderCache;
var duplicatetransient native const Pointer MaterialResources[3];
var duplicatetransient native const Pointer DefaultMaterialInstances[3];
var int EditorX;
var int EditorY;
var int EditorPitch;
var int EditorYaw;
var array<MaterialExpression> Expressions;
var array<MaterialFunctionInfo> MaterialFunctionInfos;
var native map{VOID,VOID} EditorParameters;
var private const deprecated array<deprecated Texture> ReferencedTextures;

defaultproperties
{
    PhysMaterialMaskUVChannel=-1
    DiffuseColor=(UseConstant=false,Constant=(R=128,G=128,B=128,A=0),Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
    DiffusePower=(UseConstant=false,Constant=1.0000000,Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
    SpecularColor=(UseConstant=false,Constant=(R=128,G=128,B=128,A=0),Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
    SpecularPower=(UseConstant=false,Constant=15.0000000,Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
    Opacity=(UseConstant=false,Constant=1.0000000,Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
    OpacityMask=(UseConstant=false,Constant=1.0000000,Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
    OpacityMaskClipValue=0.3333000
    TwoSidedLightingColor=(UseConstant=false,Constant=(R=255,G=255,B=255,A=0),Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
    SubsurfaceInscatteringColor=(UseConstant=false,Constant=(R=255,G=255,B=255,A=0),Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
    SubsurfaceAbsorptionColor=(UseConstant=false,Constant=(R=230,G=200,B=200,A=0),Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
    bAllowFog=true
    bUsedWithStaticLighting=true
    bAllowLightmapSpecular=true
    ImageReflectionNormalDampening=5.0000000
}