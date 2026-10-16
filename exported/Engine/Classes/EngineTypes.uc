class EngineTypes extends Object
    abstract
    native;

enum EPathFindingError
{
    PATHERROR_STARTPOLYNOTFOUND,    // 0
    PATHERROR_GOALPOLYNOTFOUND,     // 1
    PATHERROR_ANCHORPYLONNOTFOUND,  // 2
    PATHERROR_NOPATHFOUND,          // 3
    PATHERROR_COMPUTEVALIDFINALDEST_FAIL,// 4
    PATHERROR_GETNEXTMOVELOCATION_FAIL,// 5
    PATHERROR_MOVETIMEOUT,          // 6
    PATHERROR_MAX                   // 7
};

enum EBlendMode
{
    BLEND_Opaque,                   // 0
    BLEND_Masked,                   // 1
    BLEND_Translucent,              // 2
    BLEND_Additive,                 // 3
    BLEND_Modulate,                 // 4
    BLEND_ModulateAndAdd,           // 5
    BLEND_SoftMasked,               // 6
    BLEND_AlphaComposite,           // 7
    BLEND_DitheredTranslucent,      // 8
    BLEND_MAX                       // 9
};

enum EMaterialLightingModel
{
    MLM_Phong,                      // 0
    MLM_NonDirectional,             // 1
    MLM_Unlit,                      // 2
    MLM_SHPRT,                      // 3
    MLM_Custom,                     // 4
    MLM_Anisotropic,                // 5
    MLM_MAX                         // 6
};

enum EMaterialTessellationMode
{
    MTM_NoTessellation,             // 0
    MTM_FlatTessellation,           // 1
    MTM_PNTriangles,                // 2
    MTM_MAX                         // 3
};

enum EMobileValueSource
{
    MVS_Constant,                   // 0
    MVS_VertexColorRed,             // 1
    MVS_VertexColorGreen,           // 2
    MVS_VertexColorBlue,            // 3
    MVS_VertexColorAlpha,           // 4
    MVS_BaseTextureRed,             // 5
    MVS_BaseTextureGreen,           // 6
    MVS_BaseTextureBlue,            // 7
    MVS_BaseTextureAlpha,           // 8
    MVS_MaskTextureRed,             // 9
    MVS_MaskTextureGreen,           // 10
    MVS_MaskTextureBlue,            // 11
    MVS_MaskTextureAlpha,           // 12
    MVS_NormalTextureAlpha,         // 13
    MVS_EmissiveTextureRed,         // 14
    MVS_EmissiveTextureGreen,       // 15
    MVS_EmissiveTextureBlue,        // 16
    MVS_EmissiveTextureAlpha,       // 17
    MVS_MAX                         // 18
};

enum EMobileTextureBlendFactorSource
{
    MTBFS_VertexColor,              // 0
    MTBFS_MaskTexture,              // 1
    MTBFS_MAX                       // 2
};

enum EMobileTexCoordsSource
{
    MTCS_TexCoords0,                // 0
    MTCS_TexCoords1,                // 1
    MTCS_TexCoords2,                // 2
    MTCS_TexCoords3,                // 3
    MTCS_MAX                        // 4
};

enum EMobileAlphaValueSource
{
    MAVS_DiffuseTextureAlpha,       // 0
    MAVS_MaskTextureRed,            // 1
    MAVS_MaskTextureGreen,          // 2
    MAVS_MaskTextureBlue,           // 3
    MAVS_MAX                        // 4
};

enum EMobileColorMultiplySource
{
    MCMS_None,                      // 0
    MCMS_BaseTextureRed,            // 1
    MCMS_BaseTextureGreen,          // 2
    MCMS_BaseTextureBlue,           // 3
    MCMS_BaseTextureAlpha,          // 4
    MCMS_MaskTextureRed,            // 5
    MCMS_MaskTextureGreen,          // 6
    MCMS_MaskTextureBlue,           // 7
    MCMS_MaskTextureAlpha,          // 8
    MCMS_MAX                        // 9
};

enum EMobileEmissiveColorSource
{
    MECS_EmissiveTexture,           // 0
    MECS_BaseTexture,               // 1
    MECS_Constant,                  // 2
    MECS_MAX                        // 3
};

enum EMobileEnvironmentBlendMode
{
    MEBM_Add,                       // 0
    MEBM_Lerp,                      // 1
    MEBM_MAX                        // 2
};

enum EMobileSpecularMask
{
    MSM_Constant,                   // 0
    MSM_Luminance,                  // 1
    MSM_DiffuseRed,                 // 2
    MSM_DiffuseGreen,               // 3
    MSM_DiffuseBlue,                // 4
    MSM_DiffuseAlpha,               // 5
    MSM_MaskTextureRGB,             // 6
    MSM_MaskTextureRed,             // 7
    MSM_MaskTextureGreen,           // 8
    MSM_MaskTextureBlue,            // 9
    MSM_MaskTextureAlpha,           // 10
    MSM_MAX                         // 11
};

enum EMobileAmbientOcclusionSource
{
    MAOS_Disabled,                  // 0
    MAOS_VertexColorRed,            // 1
    MAOS_VertexColorGreen,          // 2
    MAOS_VertexColorBlue,           // 3
    MAOS_VertexColorAlpha,          // 4
    MAOS_MAX                        // 5
};

enum ELightingBuildQuality
{
    Quality_Preview,                // 0
    Quality_Medium,                 // 1
    Quality_High,                   // 2
    Quality_Production,             // 3
    Quality_NoGlobalIllumination,   // 4
    Quality_MAX                     // 5
};

struct native SubtitleCue
{
    var() const localized string Text;
    var() const localized float Time;
    var() int m_nMsgId;

    structdefaultproperties
    {
        Text=""
        Time=0.0000000
        m_nMsgId=0
    }
};

struct native LocalizedSubtitle
{
    var string LanguageExt;
    var array<SubtitleCue> Subtitles;
    var bool bMature;
    var bool bManualWordWrap;
    var bool bSingleLine;

    structdefaultproperties
    {
        LanguageExt=""
        Subtitles=none
        bMature=false
        bManualWordWrap=false
        bSingleLine=false
    }
};

struct LightMapRef
{
    var private native const Pointer Reference;
};

struct native DominantShadowInfo
{
    var Matrix WorldToLight;
    var Matrix LightToWorld;
    var Box LightSpaceImportanceBounds;
    var int ShadowMapSizeX;
    var int ShadowMapSizeY;

    structdefaultproperties
    {
        WorldToLight=(XPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),WPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
        LightToWorld=(XPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),WPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
        LightSpaceImportanceBounds=(Min=(X=0.0000000,Y=0.0000000,Z=0.0000000),Max=(X=0.0000000,Y=0.0000000,Z=0.0000000),IsValid=0)
        ShadowMapSizeX=0
        ShadowMapSizeY=0
    }
};

struct native LightmassLightSettings
{
    var(General) float IndirectLightingScale;
    var(General) float IndirectLightingSaturation;
    var(General) float ShadowExponent;

    structdefaultproperties
    {
        IndirectLightingScale=1.0000000
        IndirectLightingSaturation=1.0000000
        ShadowExponent=2.0000000
    }
};

struct native LightmassPointLightSettings extends LightmassLightSettings
{
    var(Point) float LightSourceRadius;

    structdefaultproperties
    {
        LightSourceRadius=100.0000000
        IndirectLightingScale=0.0000000
        IndirectLightingSaturation=0.0000000
        ShadowExponent=0.0000000
    }
};

struct native LightmassDirectionalLightSettings extends LightmassLightSettings
{
    var(Directional) float LightSourceAngle;

    structdefaultproperties
    {
        LightSourceAngle=3.0000000
        IndirectLightingScale=0.0000000
        IndirectLightingSaturation=0.0000000
        ShadowExponent=0.0000000
    }
};

struct LightmassPrimitiveSettings
{
    var() bool bUseTwoSidedLighting;
    var() bool bShadowIndirectOnly;
    var() bool bUseEmissiveForStaticLighting;
    var() float EmissiveLightFalloffExponent;
    var() float EmissiveLightExplicitInfluenceRadius;
    var() float EmissiveBoost;
    var() float DiffuseBoost;
    var float SpecularBoost;
    var() float FullyOccludedSamplesFraction;

    structdefaultproperties
    {
        bUseTwoSidedLighting=false
        bShadowIndirectOnly=false
        bUseEmissiveForStaticLighting=false
        EmissiveLightFalloffExponent=2.0000000
        EmissiveLightExplicitInfluenceRadius=0.0000000
        EmissiveBoost=1.0000000
        DiffuseBoost=1.0000000
        SpecularBoost=1.0000000
        FullyOccludedSamplesFraction=1.0000000
    }
};

struct native LightmassDebugOptions
{
    var() bool bDebugMode;
    var() bool bStatsEnabled;
    var() bool bGatherBSPSurfacesAcrossComponents;
    var() float CoplanarTolerance;
    var() bool bUseDeterministicLighting;
    var() bool bUseImmediateImport;
    var() bool bImmediateProcessMappings;
    var() bool bSortMappings;
    var() bool bDumpBinaryFiles;
    var() bool bDebugMaterials;
    var() bool bPadMappings;
    var() bool bDebugPaddings;
    var() bool bOnlyCalcDebugTexelMappings;
    var() bool bUseRandomColors;
    var() bool bColorBordersGreen;
    var() bool bColorByExecutionTime;
    var() float ExecutionTimeDivisor;
    var bool bInitialized;

    structdefaultproperties
    {
        bDebugMode=false
        bStatsEnabled=false
        bGatherBSPSurfacesAcrossComponents=true
        CoplanarTolerance=0.0010000
        bUseDeterministicLighting=true
        bUseImmediateImport=true
        bImmediateProcessMappings=true
        bSortMappings=true
        bDumpBinaryFiles=false
        bDebugMaterials=false
        bPadMappings=true
        bDebugPaddings=false
        bOnlyCalcDebugTexelMappings=false
        bUseRandomColors=false
        bColorBordersGreen=false
        bColorByExecutionTime=false
        ExecutionTimeDivisor=15.0000000
        bInitialized=false
    }
};

struct native SwarmDebugOptions
{
    var() bool bDistributionEnabled;
    var() bool bForceContentExport;
    var bool bInitialized;

    structdefaultproperties
    {
        bDistributionEnabled=true
        bForceContentExport=false
        bInitialized=false
    }
};

struct native RootMotionCurve
{
    var() name AnimName;
    var() InterpCurveVector Curve;
    var() float MaxCurveTime;

    structdefaultproperties
    {
        AnimName="None"
        Curve=(Points=none,InterpMethod=EInterpMethodType.IMT_UseFixedTangentEvalAndNewAutoTangents)
        MaxCurveTime=0.0000000
    }
};

struct native PrimitiveMaterialRef
{
    var export editinline PrimitiveComponent Primitive;
    var int MaterialIndex;

    structdefaultproperties
    {
        Primitive=none
        MaterialIndex=0
    }
};

struct native PostProcessMaterialRef
{
    var MaterialEffect Effect;

    structdefaultproperties
    {
        Effect=none
    }
};

struct native MaterialReferenceList
{
    var() MaterialInterface TargetMaterial;
    var edithide array<PrimitiveMaterialRef> AffectedMaterialRefs;
    var edithide array<PostProcessMaterialRef> AffectedPPChainMaterialRefs;

    structdefaultproperties
    {
        TargetMaterial=none
        AffectedMaterialRefs=none
        AffectedPPChainMaterialRefs=none
    }
};

struct native VelocityObstacleStat
{
    var Vector Position;
    var Vector Velocity;
    var float Radius;
    var int Priority;

    structdefaultproperties
    {
        Position=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Velocity=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Radius=0.0000000
        Priority=0
    }
};
