class MaterialInterface extends Surface
    abstract
    native(Material)
    forcescriptorder(true);

enum EMaterialUsage
{
    MATUSAGE_SkeletalMesh,          // 0
    MATUSAGE_FracturedMeshes,       // 1
    MATUSAGE_ParticleSprites,       // 2
    MATUSAGE_BeamTrails,            // 3
    MATUSAGE_ParticleSubUV,         // 4
    MATUSAGE_SpeedTree,             // 5
    MATUSAGE_StaticLighting,        // 6
    MATUSAGE_GammaCorrection,       // 7
    MATUSAGE_LensFlare,             // 8
    MATUSAGE_InstancedMeshParticles,// 9
    MATUSAGE_FluidSurface,          // 10
    MATUSAGE_Decals,                // 11
    MATUSAGE_MaterialEffect,        // 12
    MATUSAGE_MorphTargets,          // 13
    MATUSAGE_FogVolumes,            // 14
    MATUSAGE_RadialBlur,            // 15
    MATUSAGE_InstancedMeshes,       // 16
    MATUSAGE_SplineMesh,            // 17
    MATUSAGE_ScreenDoorFade,        // 18
    MATUSAGE_APEXMesh,              // 19
    MATUSAGE_Terrain,               // 20
    MATUSAGE_Landscape,             // 21
    MATUSAGE_MobileLandscape,       // 22
    MATUSAGE_MAX                    // 23
};

struct native LightmassMaterialInterfaceSettings
{
    var(Material) bool bCastShadowAsMasked;
    var(Material) float EmissiveBoost;
    var(Material) float DiffuseBoost;
    var float SpecularBoost;
    var(Material) float ExportResolutionScale;
    var(Material) float DistanceFieldPenumbraScale;
    var bool bOverrideCastShadowAsMasked;
    var bool bOverrideEmissiveBoost;
    var bool bOverrideDiffuseBoost;
    var bool bOverrideSpecularBoost;
    var bool bOverrideExportResolutionScale;
    var bool bOverrideDistanceFieldPenumbraScale;

    structdefaultproperties
    {
        bCastShadowAsMasked=false
        EmissiveBoost=1.0000000
        DiffuseBoost=1.0000000
        SpecularBoost=1.0000000
        ExportResolutionScale=1.0000000
        DistanceFieldPenumbraScale=1.0000000
        bOverrideCastShadowAsMasked=false
        bOverrideEmissiveBoost=false
        bOverrideDiffuseBoost=false
        bOverrideSpecularBoost=false
        bOverrideExportResolutionScale=false
        bOverrideDistanceFieldPenumbraScale=false
    }
};

var native const transient RenderCommandFence_Mirror ParentRefFence;
var(Lightmass) protected LightmassMaterialInterfaceSettings LightmassSettings;
var const bool bHasQualitySwitch;
var(ParticleTrimming) editoronly bool bRunTrimmingTool;
var(ParticleTrimming) editoronly bool bUseCachedCircleVerts;
var(ParticleTrimming) editoronly bool bScanRedChannel;
var(ParticleTrimming) editoronly bool bScanGreenChannel;
var(ParticleTrimming) editoronly bool bScanBlueChannel;
var(ParticleTrimming) editoronly bool bScanAlphaChannel;
var(ParticleTrimming) editoronly bool bClearData;
var(Mobile) bool bAutoFlattenMobile;
var(Mobile) bool bAutoFlattenMobileNormalTexture;
var(Mobile) bool bMobileAllowFog;
var(Mobile,Generation) bool bGenerateSubUV;
var(Mobile,Specular) bool bUseMobileSpecular;
var deprecated bool bUseMobileVertexSpecular;
var(Mobile,Specular) bool bUseMobilePixelSpecular;
var(Mobile,BumpOffset) bool bUseMobileBumpOffset;
var(Mobile,TextureBlending) bool bLockColorBlending;
var(Mobile,ColorBlending) bool bUseMobileUniformColorMultiply;
var(Mobile,ColorBlending) bool bUseMobileVertexColorMultiply;
var(Mobile,ColorBlending) bool bUseMobileDetailNormal;
var(Mobile,TextureTransform) bool bBaseTextureTransformed;
var(Mobile,TextureTransform) bool bEmissiveTextureTransformed;
var(Mobile,TextureTransform) bool bNormalTextureTransformed;
var(Mobile,TextureTransform) bool bMaskTextureTransformed;
var(Mobile,TextureTransform) bool bDetailTextureTransformed;
var(Mobile,VertexAnimation) bool bUseMobileWaveVertexMovement;
var(Mobile,Flatten) bool bMobileEnableBounceLight;
var(Mobile,Landscape) bool bUseMobileLandscapeMonochromeLayerBlending;
var(ParticleTrimming) array<Vector2D> TrimmedVertices;
var(Mobile) Color FlattenBackgroundColor;
var(Mobile) Texture MobileBaseTexture;
var duplicatetransient deprecated Texture FlattenedTexture;
var(Mobile) EngineTypes.EMobileTexCoordsSource MobileBaseTextureTexCoordsSource;
var(Mobile) EngineTypes.EMobileAmbientOcclusionSource MobileAmbientOcclusionSource;
var(Mobile,Specular) EngineTypes.EMobileSpecularMask MobileSpecularMask;
var(Mobile,Emissive) EngineTypes.EMobileEmissiveColorSource MobileEmissiveColorSource;
var(Mobile,Emissive) EngineTypes.EMobileValueSource MobileEmissiveMaskSource;
var(Mobile,Environment) EngineTypes.EMobileValueSource MobileEnvironmentMaskSource;
var(Mobile,Environment) EngineTypes.EMobileEnvironmentBlendMode MobileEnvironmentBlendMode;
var(Mobile,RimLighting) EngineTypes.EMobileValueSource MobileRimLightingMaskSource;
var(Mobile,Masking) EngineTypes.EMobileTexCoordsSource MobileMaskTextureTexCoordsSource;
var(Mobile,Masking) EngineTypes.EMobileAlphaValueSource MobileAlphaValueSource;
var(Mobile,TextureBlending) EngineTypes.EMobileTexCoordsSource MobileDetailTextureTexCoordsSource;
var(Mobile,TextureBlending) EngineTypes.EMobileTextureBlendFactorSource MobileTextureBlendFactorSource;
var(Mobile,ColorBlending) EngineTypes.EMobileColorMultiplySource MobileColorMultiplySource;
var(Mobile) Texture MobileNormalTexture;
var(Mobile,Generation) float SubUVFrameRate;
var(Mobile,Generation) int SubUVFrameCountAlongAxes;
var(Mobile,Generation) float SubUVFrameSize;
var(Mobile,Specular) LinearColor MobileSpecularColor;
var(Mobile,Specular) float MobileSpecularPower;
var(Mobile,Emissive) Texture MobileEmissiveTexture;
var(Mobile,Emissive) LinearColor MobileEmissiveColor;
var(Mobile,Environment) Texture MobileEnvironmentTexture;
var(Mobile,Environment) float MobileEnvironmentAmount;
var(Mobile,Environment) LinearColor MobileEnvironmentColor;
var(Mobile,Environment) float MobileEnvironmentFresnelAmount;
var(Mobile,Environment) float MobileEnvironmentFresnelExponent;
var(Mobile,RimLighting) float MobileRimLightingStrength;
var(Mobile,RimLighting) float MobileRimLightingExponent;
var(Mobile,RimLighting) LinearColor MobileRimLightingColor;
var(Mobile,BumpOffset) float MobileBumpOffsetReferencePlane;
var(Mobile,BumpOffset) float MobileBumpOffsetHeightRatio;
var(Mobile,Masking) Texture MobileMaskTexture;
var(Mobile,Masking) float MobileOpacityMultiplier;
var(Mobile,TextureBlending) Texture MobileDetailTexture;
var(Mobile,TextureBlending) Texture MobileDetailTexture2;
var(Mobile,TextureBlending) Texture MobileDetailTexture3;
var deprecated LinearColor DefaultUniformColor;
var(Mobile,ColorBlending) LinearColor MobileDefaultUniformColor;
var deprecated float TransformCenterX;
var(Mobile,TextureTransform) float MobileTransformCenterX;
var deprecated float TransformCenterY;
var(Mobile,TextureTransform) float MobileTransformCenterY;
var deprecated float PannerSpeedX;
var(Mobile,TextureTransform) float MobilePannerSpeedX;
var deprecated float PannerSpeedY;
var(Mobile,TextureTransform) float MobilePannerSpeedY;
var deprecated float RotateSpeed;
var(Mobile,TextureTransform) float MobileRotateSpeed;
var deprecated float FixedScaleX;
var(Mobile,TextureTransform) float MobileFixedScaleX;
var deprecated float FixedScaleY;
var(Mobile,TextureTransform) float MobileFixedScaleY;
var deprecated float SineScaleX;
var(Mobile,TextureTransform) float MobileSineScaleX;
var deprecated float SineScaleY;
var(Mobile,TextureTransform) float MobileSineScaleY;
var deprecated float SineScaleFrequencyMultipler;
var(Mobile,TextureTransform) float MobileSineScaleFrequencyMultipler;
var deprecated float FixedOffsetX;
var(Mobile,TextureTransform) float MobileFixedOffsetX;
var deprecated float FixedOffsetY;
var(Mobile,TextureTransform) float MobileFixedOffsetY;
var(Mobile,VertexAnimation) float MobileTangentVertexFrequencyMultiplier;
var(Mobile,VertexAnimation) float MobileVerticalFrequencyMultiplier;
var(Mobile,VertexAnimation) float MobileMaxVertexMovementAmplitude;
var(Mobile,VertexAnimation) float MobileSwayFrequencyMultiplier;
var(Mobile,VertexAnimation) float MobileSwayMaxAngle;
var(Mobile,Flatten) Vector MobileDirectionalLightDirection;
var(Mobile,Flatten) float MobileDirectionalLightBrightness;
var(Mobile,Flatten) Color MobileDirectionalLightColor;
var(Mobile,Flatten) Vector MobileBounceLightDirection;
var(Mobile,Flatten) float MobileBounceLightBrightness;
var(Mobile,Flatten) Color MobileBounceLightColor;
var(Mobile,Flatten) float MobileSkyLightBrightness;
var(Mobile,Flatten) Color MobileSkyLightColor;
var(Mobile,Landscape) name MobileLandscapeLayerNames[4];
var(Mobile,Landscape) Color MobileLandscapeMonochomeLayerColors[4];

// Export UMaterialInterface::execGetMaterial(FFrame&, void* const)
native final function Material GetMaterial();

// Export UMaterialInterface::execGetPhysicalMaterial(FFrame&, void* const)
native final function PhysicalMaterial GetPhysicalMaterial();

// Export UMaterialInterface::execGetParameterDesc(FFrame&, void* const)
native function bool GetParameterDesc(name ParameterName, out string OutDesc);

// Export UMaterialInterface::execGetFontParameterValue(FFrame&, void* const)
native function bool GetFontParameterValue(name ParameterName, out Font OutFontValue, out int OutFontPage);

// Export UMaterialInterface::execGetScalarParameterValue(FFrame&, void* const)
native function bool GetScalarParameterValue(name ParameterName, out float OutValue);

// Export UMaterialInterface::execGetScalarCurveParameterValue(FFrame&, void* const)
native function bool GetScalarCurveParameterValue(name ParameterName, out InterpCurveFloat OutValue);

// Export UMaterialInterface::execGetTextureParameterValue(FFrame&, void* const)
native function bool GetTextureParameterValue(name ParameterName, out Texture OutValue);

// Export UMaterialInterface::execGetVectorParameterValue(FFrame&, void* const)
native function bool GetVectorParameterValue(name ParameterName, out LinearColor OutValue);

// Export UMaterialInterface::execGetVectorCurveParameterValue(FFrame&, void* const)
native function bool GetVectorCurveParameterValue(name ParameterName, out InterpCurveVector OutValue);

// Export UMaterialInterface::execGetLinearColorParameterValue(FFrame&, void* const)
native function bool GetLinearColorParameterValue(name ParameterName, out LinearColor OutValue);

// Export UMaterialInterface::execGetLinearColorCurveParameterValue(FFrame&, void* const)
native function bool GetLinearColorCurveParameterValue(name ParameterName, out InterpCurveLinearColor OutValue);

// Export UMaterialInterface::execGetGroupName(FFrame&, void* const)
native function bool GetGroupName(name ParameterName, out name GroupName);

// Export UMaterialInterface::execGetMobileScalarParameterValue(FFrame&, void* const)
native function bool GetMobileScalarParameterValue(name ParameterName, out float OutValue);

// Export UMaterialInterface::execGetMobileTextureParameterValue(FFrame&, void* const)
native function bool GetMobileTextureParameterValue(name ParameterName, out Texture OutValue);

// Export UMaterialInterface::execGetMobileVectorParameterValue(FFrame&, void* const)
native function bool GetMobileVectorParameterValue(name ParameterName, out LinearColor OutValue);

// Export UMaterialInterface::execSetForceMipLevelsToBeResident(FFrame&, void* const)
native function SetForceMipLevelsToBeResident(bool OverrideForceMiplevelsToBeResident, bool bForceMiplevelsToBeResidentValue, float ForceDuration, optional int CinematicTextureGroups = 0);

defaultproperties
{
    LightmassSettings=(bCastShadowAsMasked=false,EmissiveBoost=1.0000000,DiffuseBoost=1.0000000,SpecularBoost=1.0000000,ExportResolutionScale=1.0000000,DistanceFieldPenumbraScale=1.0000000,bOverrideCastShadowAsMasked=false,bOverrideEmissiveBoost=false,bOverrideDiffuseBoost=false,bOverrideSpecularBoost=false,bOverrideExportResolutionScale=false,bOverrideDistanceFieldPenumbraScale=false)
    bMobileAllowFog=true
    FlattenBackgroundColor=(R=0,G=0,B=0,A=255)
    MobileDetailTextureTexCoordsSource=EMobileTexCoordsSource.MTCS_TexCoords1
    MobileSpecularColor=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000)
    MobileSpecularPower=16.0000000
    MobileEmissiveColor=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000)
    MobileEnvironmentAmount=1.0000000
    MobileEnvironmentColor=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000)
    MobileEnvironmentFresnelExponent=1.0000000
    MobileRimLightingExponent=2.0000000
    MobileRimLightingColor=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000)
    MobileBumpOffsetReferencePlane=0.5000000
    MobileBumpOffsetHeightRatio=0.0500000
    MobileOpacityMultiplier=1.0000000
    MobileDefaultUniformColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    MobileTransformCenterX=0.5000000
    MobileTransformCenterY=0.5000000
    MobileFixedScaleX=1.0000000
    MobileFixedScaleY=1.0000000
    MobileSineScaleFrequencyMultipler=1.0000000
    MobileTangentVertexFrequencyMultiplier=0.1250000
    MobileVerticalFrequencyMultiplier=0.1000000
    MobileMaxVertexMovementAmplitude=5.0000000
    MobileSwayFrequencyMultiplier=0.0700000
    MobileSwayMaxAngle=2.0000000
    MobileDirectionalLightDirection=(X=0.0000000,Y=-45.0000000,Z=45.0000000)
    MobileDirectionalLightBrightness=2.0000000
    MobileDirectionalLightColor=(R=255,G=255,B=255,A=0)
    MobileBounceLightDirection=(X=0.0000000,Y=45.0000000,Z=-27.5000000)
    MobileBounceLightBrightness=0.2500000
    MobileBounceLightColor=(R=255,G=255,B=255,A=0)
    MobileSkyLightBrightness=0.2500000
    MobileSkyLightColor=(R=255,G=255,B=255,A=0)
    MobileLandscapeMonochomeLayerColors[0]=(R=255,G=255,B=255,A=0)
    MobileLandscapeMonochomeLayerColors[1]=(R=255,G=255,B=255,A=0)
    MobileLandscapeMonochomeLayerColors[2]=(R=255,G=255,B=255,A=0)
    MobileLandscapeMonochomeLayerColors[3]=(R=255,G=255,B=255,A=0)
}