class Engine extends Subsystem
    abstract
    transient
    native(GameEngine)
    config(Engine);

enum ETransitionType
{
    TT_None,                        // 0
    TT_Paused,                      // 1
    TT_Loading,                     // 2
    TT_Saving,                      // 3
    TT_Connecting,                  // 4
    TT_Precaching,                  // 5
    TT_MAX                          // 6
};

struct native StatColorMapEntry
{
    var globalconfig float In;
    var globalconfig Color Out;

    structdefaultproperties
    {
        In=0.0000000
        Out=(R=0,G=0,B=0,A=0)
    }
};

struct native StatColorMapping
{
    var globalconfig string StatName;
    var globalconfig array<config StatColorMapEntry> ColorMap;
    var globalconfig bool DisableBlend;

    structdefaultproperties
    {
        StatName=""
        ColorMap=none
        DisableBlend=false
    }
};

struct native DropNoteInfo
{
    var Vector Location;
    var Rotator Rotation;
    var string Comment;

    structdefaultproperties
    {
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Rotation=(Pitch=0,Yaw=0,Roll=0)
        Comment=""
    }
};

var private Font TinyFont;
var globalconfig string TinyFontName;
var private Font SmallFont;
var globalconfig string SmallFontName;
var private Font MediumFont;
var globalconfig string MediumFontName;
var private Font LargeFont;
var globalconfig string LargeFontName;
var private Font SubtitleFont;
var globalconfig string SubtitleFontName;
var private array<Font> AdditionalFonts;
var globalconfig array<config string> AdditionalFontNames;
var Class<Console> ConsoleClass;
var globalconfig string ConsoleClassName;
var Class<GameViewportClient> GameViewportClientClass;
var globalconfig string GameViewportClientClassName;
var Class<DataStoreClient> DataStoreClientClass;
var globalconfig string DataStoreClientClassName;
var Class<LocalPlayer> LocalPlayerClass;
var config string LocalPlayerClassName;
var Material DefaultMaterial;
var globalconfig string DefaultMaterialName;
var Material DefaultDecalMaterial;
var globalconfig string DefaultDecalMaterialName;
var Texture DefaultTexture;
var globalconfig string DefaultTextureName;
var Material WireframeMaterial;
var globalconfig string WireframeMaterialName;
var Material EmissiveTexturedMaterial;
var globalconfig string EmissiveTexturedMaterialName;
var Material GeomMaterial;
var globalconfig string GeomMaterialName;
var Material DefaultFogVolumeMaterial;
var globalconfig string DefaultFogVolumeMaterialName;
var Material TickMaterial;
var globalconfig string TickMaterialName;
var Material CrossMaterial;
var globalconfig string CrossMaterialName;
var Material LevelColorationLitMaterial;
var globalconfig string LevelColorationLitMaterialName;
var Material LevelColorationUnlitMaterial;
var globalconfig string LevelColorationUnlitMaterialName;
var Material LightingTexelDensityMaterial;
var globalconfig string LightingTexelDensityName;
var Material ShadedLevelColorationLitMaterial;
var globalconfig string ShadedLevelColorationLitMaterialName;
var Material ShadedLevelColorationUnlitMaterial;
var globalconfig string ShadedLevelColorationUnlitMaterialName;
var Material RemoveSurfaceMaterial;
var globalconfig string RemoveSurfaceMaterialName;
var Material VertexColorMaterial;
var globalconfig string VertexColorMaterialName;
var Material VertexColorViewModeMaterial_ColorOnly;
var globalconfig string VertexColorViewModeMaterialName_ColorOnly;
var Material VertexColorViewModeMaterial_AlphaAsColor;
var globalconfig string VertexColorViewModeMaterialName_AlphaAsColor;
var Material VertexColorViewModeMaterial_RedOnly;
var globalconfig string VertexColorViewModeMaterialName_RedOnly;
var Material VertexColorViewModeMaterial_GreenOnly;
var globalconfig string VertexColorViewModeMaterialName_GreenOnly;
var Material VertexColorViewModeMaterial_BlueOnly;
var globalconfig string VertexColorViewModeMaterialName_BlueOnly;
var Material HeatmapMaterial;
var globalconfig string HeatmapMaterialName;
var Material BoneWeightMaterial;
var globalconfig string BoneWeightMaterialName;
var Material TangentColorMaterial;
var globalconfig string TangentColorMaterialName;
var Material MobileEmulationMasterMaterial;
var globalconfig string MobileEmulationMasterMaterialName;
var Material ProcBuildingSimpleMaterial;
var globalconfig string ProcBuildingSimpleMaterialName;
var StaticMesh BuildingQuadStaticMesh;
var globalconfig string BuildingQuadStaticMeshName;
var globalconfig float ProcBuildingLODColorTexelsPerWorldUnit;
var globalconfig float ProcBuildingLODLightingTexelsPerWorldUnit;
var globalconfig int MaxProcBuildingLODColorTextureSize;
var globalconfig int MaxProcBuildingLODLightingTextureSize;
var globalconfig bool UseProcBuildingLODTextureCropping;
var globalconfig bool ForcePowerOfTwoProcBuildingLODTextures;
var globalconfig bool bCombineSimilarMappings;
var globalconfig bool bRenderLightMapDensityGrayscale;
var bool bScreenshotRequested;
var transient bool bUseSound;
var(Settings) config bool bUseBackgroundLevelStreaming;
var(Settings) config bool bSubtitlesEnabled;
var(Settings) config bool bSubtitlesForcedOff;
var config bool bSmoothFrameRate;
var config bool bCheckForMultiplePawnsSpawnedInAFrame;
var globalconfig bool bShouldGenerateSimpleLightmaps;
var(Settings) config bool bForceStaticTerrain;
var config bool bForceCPUSkinning;
var config bool bUsePostProcessEffects;
var config bool bOnScreenKismetWarnings;
var config bool bEnableKismetLogging;
var config bool bAllowMatureLanguage;
var globalconfig bool bDisablePhysXHardwareSupport;
var config bool bPauseOnLossOfFocus;
var globalconfig bool bCheckParticleRenderSize;
var const globalconfig bool bEnableColorClear;
var transient bool bAreConstraintsDirty;
var transient bool bHasPendingGlobalReattach;
var globalconfig bool bEnableOnScreenDebugMessages;
var transient bool bEnableOnScreenDebugMessagesDisplay;
var globalconfig bool bSuppressMapWarnings;
var globalconfig bool bCookSeparateSharedMPGameContent;
var globalconfig bool bUseRecastNavMesh;
var bool bDisableAILogging;
var globalconfig bool bUseNormalMapsForSimpleLightMaps;
var transient bool bStartWithMatineeCapture;
var transient bool bCompressMatineeCapture;
var transient bool bLockReadOnlyLevels;
var globalconfig float MaxRMSDForCombiningMappings;
var globalconfig int ImageReflectionTextureSize;
var globalconfig LinearColor LightingOnlyBrightness;
var globalconfig array<config Color> LightComplexityColors;
var globalconfig array<config LinearColor> ShaderComplexityColors;
var globalconfig float MaxPixelShaderAdditiveComplexityCount;
var globalconfig float MinTextureDensity;
var globalconfig float IdealTextureDensity;
var globalconfig float MaxTextureDensity;
var globalconfig float MinLightMapDensity;
var globalconfig float IdealLightMapDensity;
var globalconfig float MaxLightMapDensity;
var globalconfig float RenderLightMapDensityGrayscaleScale;
var globalconfig float RenderLightMapDensityColorScale;
var globalconfig LinearColor LightMapDensityVertexMappedColor;
var globalconfig LinearColor LightMapDensitySelectedColor;
var globalconfig array<config StatColorMapping> StatColorMappings;
var Material EditorBrushMaterial;
var globalconfig string EditorBrushMaterialName;
var PhysicalMaterial DefaultPhysMaterial;
var globalconfig string DefaultPhysMaterialName;
var PhysicalMaterial LandscapeHolePhysMaterial;
var globalconfig string LandscapeHolePhysMaterialName;
var ApexDestructibleDamageParameters ApexDamageParams;
var globalconfig string ApexDamageParamsName;
var Material TerrainErrorMaterial;
var globalconfig string TerrainErrorMaterialName;
var globalconfig int TerrainMaterialMaxTextureCount;
var globalconfig int TerrainTessellationCheckCount;
var globalconfig float TerrainTessellationCheckDistance;
var Class<OnlineSubsystem> OnlineSubsystemClass;
var globalconfig string DefaultOnlineSubsystemName;
var private PostProcessChain DefaultPostProcess;
var private config string DefaultPostProcessName;
var PostProcessChain ThumbnailSkeletalMeshPostProcess;
var config string ThumbnailSkeletalMeshPostProcessName;
var PostProcessChain ThumbnailParticleSystemPostProcess;
var config string ThumbnailParticleSystemPostProcessName;
var PostProcessChain ThumbnailMaterialPostProcess;
var config string ThumbnailMaterialPostProcessName;
var PostProcessChain DefaultUIScenePostProcess;
var config string DefaultUIScenePostProcessName;
var Material DefaultUICaretMaterial;
var globalconfig string DefaultUICaretMaterialName;
var Material SceneCaptureReflectActorMaterial;
var globalconfig string SceneCaptureReflectActorMaterialName;
var Material SceneCaptureCubeActorMaterial;
var globalconfig string SceneCaptureCubeActorMaterialName;
var Texture2D ScreenDoorNoiseTexture;
var globalconfig string ScreenDoorNoiseTextureName;
var Texture2D ImageGrainNoiseTexture;
var globalconfig string ImageGrainNoiseTextureName;
var Texture2D RandomAngleTexture;
var globalconfig string RandomAngleTextureName;
var Texture2D RandomNormalTexture;
var globalconfig string RandomNormalTextureName;
var Texture2D RandomMirrorDiscTexture;
var globalconfig string RandomMirrorDiscTextureName;
var Texture WeightMapPlaceholderTexture;
var globalconfig string WeightMapPlaceholderTextureName;
var Texture2D LightMapDensityTexture;
var globalconfig string LightMapDensityTextureName;
var Texture2D LightMapDensityNormal;
var globalconfig string LightMapDensityNormalName;
var SoundNodeWave DefaultSound;
var globalconfig string DefaultSoundName;
var(Settings) config float TimeBetweenPurgingPendingKillObjects;
var(Settings) config float MaxTimeBetweenPurgingPendingKillObjects;
var(Settings) config int GarbageCollectionDelayMinimumMemoryMB;
var const Client Client;
var init array<init LocalPlayer> GamePlayers;
var const GameViewportClient GameViewport;
var init array<init string> DeferredCommands;
var int TickCycles;
var int GameCycles;
var int ClientCycles;
var config float MaxSmoothedFrameRate;
var config float MinSmoothedFrameRate;
var config int NumPawnsAllowedToBeSpawnedInAFrame;
var native Pointer RemoteControlExec;
var native Pointer MobileMaterialEmulator;
var(Colors) Color C_WorldBox;
var(Colors) Color C_BrushWire;
var(Colors) Color C_AddWire;
var(Colors) Color C_SubtractWire;
var(Colors) Color C_SemiSolidWire;
var(Colors) Color C_NonSolidWire;
var(Colors) Color C_WireBackground;
var(Colors) Color C_ScaleBoxHi;
var(Colors) Color C_VolumeCollision;
var(Colors) Color C_BSPCollision;
var(Colors) Color C_OrthoBackground;
var(Colors) Color C_Volume;
var(Colors) Color C_BrushShape;
var(Settings) float StreamingDistanceFactor;
var const config string ScoutClassName;
var Engine.ETransitionType TransitionType;
var string TransitionDescription;
var string TransitionGameType;
var config float MeshLODRange;
var config float CameraRotationThreshold;
var config float CameraTranslationThreshold;
var config float PrimitiveProbablyVisibleTime;
var config float PercentUnoccludedRequeries;
var config float MaxOcclusionPixelsFraction;
var config int MaxFluidNumVerts;
var config float FluidSimulationTimeLimit;
var config int MaxParticleResize;
var config int MaxParticleResizeWarn;
var config int MaxParticleVertexMemory;
var transient int MaxParticleSpriteCount;
var transient int MaxParticleSubUVCount;
var config int BeginUPTryCount;
var transient array<DropNoteInfo> PendingDroppedNotes;
var globalconfig string DynamicCoverMeshComponentName;
var globalconfig float NetClientTicksPerSecond;
var globalconfig float MaxTrackedOcclusionIncrement;
var globalconfig float TrackedOcclusionStepSize;
var globalconfig LinearColor DefaultSelectedMaterialColor;
var globalconfig LinearColor DefaultHoveredMaterialColor;
var transient LinearColor SelectedMaterialColor;
var transient LinearColor UnselectedMaterialColor;
var globalconfig array<config name> IgnoreSimulatedFuncWarnings;
var private transient int ScreenSaverInhibitorSemaphore;
var private transient Pointer ScreenSaverInhibitor;
var TranslationContext GlobalTranslationContext;
var const transient Double LoadingMovieStartTime;
var transient string MatineeCaptureName;
var transient string MatineePackageCaptureName;
var transient string VisibleLevelsForMatineeCapture;
var transient int MatineeCaptureFPS;
var transient int MatineeCaptureType;
var NetDriver PeerNetDriver;

// Export UEngine::execIsEditor(FFrame&, void* const)
native static final function bool IsEditor();

// Export UEngine::execIsGame(FFrame&, void* const)
native static final function bool IsGame();

// Export UEngine::execGetCurrentWorldInfo(FFrame&, void* const)
native static final function WorldInfo GetCurrentWorldInfo();

// Export UEngine::execGetBuildDate(FFrame&, void* const)
native static final function string GetBuildDate();

// Export UEngine::execGetDeviceUUID(FFrame&, void* const)
native static final function string GetDeviceUUID();

// Export UEngine::execGetOSVersion(FFrame&, void* const)
native static final function float GetOSVersion();

// Export UEngine::execGetDevicePushNotificationToken(FFrame&, void* const)
native static final function string GetDevicePushNotificationToken();

// Export UEngine::execBuildBugSubmissionString(FFrame&, void* const)
native static final function string BuildBugSubmissionString(string BugField, string BugFieldData);

// Export UEngine::execHasNetworkConnection(FFrame&, void* const)
native static final function bool HasNetworkConnection();

// Export UEngine::execCreatePeerNetDriver(FFrame&, void* const)
native static final function CreatePeerNetDriver();

// Export UEngine::execCleanUpPeerNetDriver(FFrame&, void* const)
native static final function CleanUpPeerNetDriver();

// Export UEngine::execResetPeerNetDriver(FFrame&, void* const)
native static final function ResetPeerNetDriver();

// Export UEngine::execGetTinyFont(FFrame&, void* const)
native static final function Font GetTinyFont();

// Export UEngine::execGetSmallFont(FFrame&, void* const)
native static final function Font GetSmallFont();

// Export UEngine::execGetMediumFont(FFrame&, void* const)
native static final function Font GetMediumFont();

// Export UEngine::execGetLargeFont(FFrame&, void* const)
native static final function Font GetLargeFont();

// Export UEngine::execGetSubtitleFont(FFrame&, void* const)
native static final function Font GetSubtitleFont();

// Export UEngine::execGetAdditionalFont(FFrame&, void* const)
native static final function Font GetAdditionalFont(int AdditionalFontIndex);

// Export UEngine::execIsSplitScreen(FFrame&, void* const)
native static final function bool IsSplitScreen();

// Export UEngine::execIsStereoscopic3D(FFrame&, void* const)
native static final function bool IsStereoscopic3D();

// Export UEngine::execIsUsingES2Renderer(FFrame&, void* const)
native static final function bool IsUsingES2Renderer();

// Export UEngine::execGetAudioDevice(FFrame&, void* const)
native static final function AudioDevice GetAudioDevice();

// Export UEngine::execGetLastMovieName(FFrame&, void* const)
native static final function string GetLastMovieName();

// Export UEngine::execPlayLoadMapMovie(FFrame&, void* const)
native static final function bool PlayLoadMapMovie();

// Export UEngine::execPlayLoadMapMovieByMapName(FFrame&, void* const)
native static final function bool PlayLoadMapMovieByMapName(string MovieName);

// Export UEngine::execStopMovie(FFrame&, void* const)
native static final function StopMovie(bool bDelayStopUntilGameHasRendered);

// Export UEngine::execRemoveAllOverlays(FFrame&, void* const)
native static final function RemoveAllOverlays();

// Export UEngine::execAddOverlay(FFrame&, void* const)
native static final function AddOverlay(Font Font, string Text, float X, float Y, float ScaleX, float ScaleY, bool bIsCentered);

// Export UEngine::execAddOverlayWrapped(FFrame&, void* const)
native static final function AddOverlayWrapped(Font Font, string Text, float X, float Y, float ScaleX, float ScaleY, float WrapWidth);

// Export UEngine::execIsRealDStereoEnabled(FFrame&, void* const)
native static final function bool IsRealDStereoEnabled();

// Export UEngine::execGetEngine(FFrame&, void* const)
native static final function Engine GetEngine();

// Export UEngine::execGetDefaultPostProcessChain(FFrame&, void* const)
native static final function PostProcessChain GetDefaultPostProcessChain();

// Export UEngine::execGetWorldPostProcessChain(FFrame&, void* const)
native static final function PostProcessChain GetWorldPostProcessChain();

// Export UEngine::execAddTextureStreamingSlaveLoc(FFrame&, void* const)
native final function AddTextureStreamingSlaveLoc(Vector InLoc, float BoostFactor, bool bOverrideLocation, float OverrideDuration);

// Export UEngine::execBasicSaveObject(FFrame&, void* const)
native static final function bool BasicSaveObject(Object Obj, string PathName, bool bIsSaveGame, int Version, optional bool bEncrypt = false);

// Export UEngine::execBasicLoadObject(FFrame&, void* const)
native static final function bool BasicLoadObject(Object Obj, string PathName, bool bIsSaveGame, int Version);

// Export UEngine::execLaunchURL(FFrame&, void* const)
native static final function LaunchURL(string URL);

// Export UEngine::execGetSystemSettingBool(FFrame&, void* const)
native final function bool GetSystemSettingBool(string SettingName);

// Export UEngine::execGetSystemSettingInt(FFrame&, void* const)
native final function int GetSystemSettingInt(string SettingName);

// Export UEngine::execGetSystemSettingFloat(FFrame&, void* const)
native final function float GetSystemSettingFloat(string SettingName);

defaultproperties
{
    TinyFontName="EngineFonts.TinyFont"
    SmallFontName="EngineFonts.SmallFont"
    MediumFontName="EngineFonts.SmallFont"
    LargeFontName="EngineFonts.SmallFont"
    SubtitleFontName="EngineFonts.SmallFont"
    ConsoleClassName="Engine.Console"
    GameViewportClientClassName="TgClient.TgGameViewportClient"
    DataStoreClientClassName="Engine.DataStoreClient"
    LocalPlayerClassName="Engine.LocalPlayer"
    DefaultMaterialName="EngineMaterials.DefaultMaterial"
    DefaultDecalMaterialName="EngineMaterials.DefaultDecalMaterial"
    DefaultTextureName="EngineMaterials.DefaultDiffuse"
    WireframeMaterialName="EngineDebugMaterials.WireframeMaterial"
    EmissiveTexturedMaterialName="EngineMaterials.EmissiveTexturedMaterial"
    GeomMaterialName="EngineDebugMaterials.GeomMaterial"
    DefaultFogVolumeMaterialName="EngineMaterials.FogVolumeMaterial"
    TickMaterialName="EditorMaterials.Tick_Mat"
    CrossMaterialName="EditorMaterials.Cross_Mat"
    LevelColorationLitMaterialName="EngineDebugMaterials.LevelColorationLitMaterial"
    LevelColorationUnlitMaterialName="EngineDebugMaterials.LevelColorationUnlitMaterial"
    LightingTexelDensityName="EngineDebugMaterials.MAT_LevelColorationLitLightmapUVs"
    ShadedLevelColorationLitMaterialName="EngineDebugMaterials.ShadedLevelColorationLitMaterial"
    ShadedLevelColorationUnlitMaterialName="EngineDebugMaterials.ShadedLevelColorationUnlitMaterial"
    RemoveSurfaceMaterialName="EngineMaterials.RemoveSurfaceMaterial"
    VertexColorMaterialName="EngineDebugMaterials.VertexColorMaterial"
    VertexColorViewModeMaterialName_ColorOnly="EngineDebugMaterials.VertexColorViewMode_ColorOnly"
    VertexColorViewModeMaterialName_AlphaAsColor="EngineDebugMaterials.VertexColorViewMode_AlphaAsColor"
    VertexColorViewModeMaterialName_RedOnly="EngineDebugMaterials.VertexColorViewMode_RedOnly"
    VertexColorViewModeMaterialName_GreenOnly="EngineDebugMaterials.VertexColorViewMode_GreenOnly"
    VertexColorViewModeMaterialName_BlueOnly="EngineDebugMaterials.VertexColorViewMode_BlueOnly"
    HeatmapMaterialName="EngineDebugMaterials.HeatmapMaterial"
    BoneWeightMaterialName="EngineDebugMaterials.BoneWeightMaterial"
    TangentColorMaterialName="EngineDebugMaterials.TangentColorMaterial"
    MobileEmulationMasterMaterialName="MobileEngineMaterials.MobileMasterMaterial"
    ProcBuildingSimpleMaterialName="EngineBuildings.ProcBuildingSimpleMaterial"
    BuildingQuadStaticMeshName="EngineBuildings.BuildingQuadMesh"
    ProcBuildingLODColorTexelsPerWorldUnit=0.0750000
    ProcBuildingLODLightingTexelsPerWorldUnit=0.0150000
    MaxProcBuildingLODColorTextureSize=1024
    MaxProcBuildingLODLightingTextureSize=256
    UseProcBuildingLODTextureCropping=true
    ForcePowerOfTwoProcBuildingLODTextures=true
    bUseSound=true
    bUseBackgroundLevelStreaming=true
    bSubtitlesEnabled=true
    bSmoothFrameRate=true
    bDisablePhysXHardwareSupport=true
    bCheckParticleRenderSize=true
    bSuppressMapWarnings=true
    bUseRecastNavMesh=true
    bUseNormalMapsForSimpleLightMaps=true
    MaxRMSDForCombiningMappings=6.0000000
    ImageReflectionTextureSize=1024
    LightingOnlyBrightness=(R=0.3000000,G=0.3000000,B=0.3000000,A=1.0000000)
    LightComplexityColors=/* ERROR: System.ArgumentOutOfRangeException */
    ShaderComplexityColors=/* ERROR: System.ArgumentOutOfRangeException */
    MaxPixelShaderAdditiveComplexityCount=900.0000000
    IdealTextureDensity=13.0000000
    MaxTextureDensity=55.0000000
    IdealLightMapDensity=0.0500000
    MaxLightMapDensity=0.2000000
    RenderLightMapDensityGrayscaleScale=1.0000000
    RenderLightMapDensityColorScale=1.0000000
    LightMapDensityVertexMappedColor=(R=0.6500000,G=0.6500000,B=0.2500000,A=1.0000000)
    LightMapDensitySelectedColor=(R=1.0000000,G=0.2000000,B=1.0000000,A=1.0000000)
    StatColorMappings[0]=(StatName="AverageFPS",ColorMap=((In=15.0000000,Out=(R=255,G=0,B=0,A=0)),(In=30.0000000,Out=(R=255,G=255,B=0,A=0)),(In=45.0000000,Out=(R=0,G=255,B=0,A=0))),DisableBlend=false)
    StatColorMappings[1]=(StatName="Frametime",ColorMap=((In=1.0000000,Out=(R=0,G=255,B=0,A=0)),(In=25.0000000,Out=(R=0,G=255,B=0,A=0)),(In=29.0000000,Out=(R=255,G=255,B=0,A=0)),(In=33.0000000,Out=(R=255,G=0,B=0,A=0))),DisableBlend=false)
    StatColorMappings[2]=(StatName="Streaming fudge factor",ColorMap=((In=0.0000000,Out=(R=0,G=255,B=0,A=0)),(In=1.0000000,Out=(R=0,G=255,B=0,A=0)),(In=2.5000000,Out=(R=255,G=255,B=0,A=0)),(In=5.0000000,Out=(R=255,G=0,B=0,A=0)),(In=10.0000000,Out=(R=255,G=0,B=0,A=0))),DisableBlend=false)
    EditorBrushMaterialName="EngineMaterials.EditorBrushMaterial"
    DefaultPhysMaterialName="EngineMaterials.DefaultPhysicalMaterial"
    LandscapeHolePhysMaterialName="EngineMaterials.LandscapeHolePhysicalMaterial"
    TerrainErrorMaterialName="EngineDebugMaterials.MaterialError_Mat"
    TerrainMaterialMaxTextureCount=16
    TerrainTessellationCheckCount=6
    TerrainTessellationCheckDistance=4096.0000000
    DefaultPostProcessName="TgPostProcess.PostProcess.PP_Hit"
    ThumbnailSkeletalMeshPostProcessName="EngineMaterials.DefaultThumbnailPostProcess"
    ThumbnailParticleSystemPostProcessName="EngineMaterials.DefaultThumbnailPostProcess"
    ThumbnailMaterialPostProcessName="EngineMaterials.DefaultThumbnailPostProcess"
    DefaultUIScenePostProcessName="EngineMaterials.DefaultUIPostProcess"
    DefaultUICaretMaterialName="EngineMaterials.BlinkingCaret"
    SceneCaptureReflectActorMaterialName="EngineMaterials.ScreenMaterial"
    SceneCaptureCubeActorMaterialName="EngineMaterials.CubeMaterial"
    ScreenDoorNoiseTextureName="EngineMaterials.Good64x64TilingNoiseHighFreq"
    ImageGrainNoiseTextureName="EngineMaterials.Good64x64TilingNoiseHighFreq"
    RandomAngleTextureName="EngineMaterials.RandomAngles"
    RandomNormalTextureName="EngineMaterials.RandomNormal2"
    RandomMirrorDiscTextureName="EngineMaterials.RandomMirrorDisc"
    WeightMapPlaceholderTextureName="EngineMaterials.WeightMapPlaceholderTexture"
    LightMapDensityTextureName="EngineMaterials.DefaultWhiteGrid"
    LightMapDensityNormalName="EngineMaterials.DefaultNormal"
    DefaultSoundName="EngineSounds.WhiteNoise"
    TimeBetweenPurgingPendingKillObjects=30.0000000
    MaxTimeBetweenPurgingPendingKillObjects=1000.0000000
    GarbageCollectionDelayMinimumMemoryMB=512
    MaxSmoothedFrameRate=62.0000000
    MinSmoothedFrameRate=22.0000000
    NumPawnsAllowedToBeSpawnedInAFrame=2
    C_WorldBox=(R=0,G=0,B=40,A=255)
    C_BrushWire=(R=192,G=0,B=0,A=255)
    C_AddWire=(R=127,G=127,B=255,A=255)
    C_SubtractWire=(R=255,G=192,B=63,A=255)
    C_SemiSolidWire=(R=127,G=255,B=0,A=255)
    C_NonSolidWire=(R=63,G=192,B=32,A=255)
    C_WireBackground=(R=0,G=0,B=0,A=255)
    C_ScaleBoxHi=(R=223,G=149,B=157,A=255)
    C_VolumeCollision=(R=149,G=223,B=157,A=255)
    C_BSPCollision=(R=149,G=157,B=223,A=255)
    C_OrthoBackground=(R=163,G=163,B=163,A=255)
    C_Volume=(R=255,G=196,B=255,A=255)
    C_BrushShape=(R=128,G=255,B=128,A=255)
    ScoutClassName="TgGame.TgAIScout"
    CameraRotationThreshold=45.0000000
    CameraTranslationThreshold=10000.0000000
    PrimitiveProbablyVisibleTime=8.0000000
    PercentUnoccludedRequeries=0.1250000
    MaxOcclusionPixelsFraction=0.1000000
    MaxFluidNumVerts=1048576
    FluidSimulationTimeLimit=30.0000000
    MaxParticleResize=1024
    MaxParticleResizeWarn=10240
    MaxParticleVertexMemory=131972
    BeginUPTryCount=200000
    NetClientTicksPerSecond=200.0000000
    MaxTrackedOcclusionIncrement=0.1000000
    TrackedOcclusionStepSize=0.1000000
    DefaultSelectedMaterialColor=(R=0.0400000,G=0.0200000,B=0.2400000,A=1.0000000)
    DefaultHoveredMaterialColor=(R=0.0200000,G=0.0200000,B=0.0200000,A=1.0000000)
    SelectedMaterialColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    UnselectedMaterialColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    IgnoreSimulatedFuncWarnings[0]="Tick"
}