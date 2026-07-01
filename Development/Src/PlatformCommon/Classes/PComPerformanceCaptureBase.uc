class PComPerformanceCaptureBase extends Object
    native
    config(Game);

enum EPComPerformanceCaptureState
{
    PPCS_WaitingToStart,
    PPCS_MoveToNode,
    PPCS_StartBasicStats,
    PPCS_StopBasicStats,
    PPCS_StartCycleStats,
    PPCS_StopCycleStats,
    PPCS_SaveAndExit,
    PPCS_LoadCharacters,
    PPCS_LoadCharactersOnly,
    PPCS_DestroyPawns
};

struct native PComPerformanceCaptureProfile
{
    var() name ProfileName;
    var() int ScalabilityBucket;
    var() int ResolutionX;
    var() int ResolutionY;
    var() int VsyncInterval;
    var() bool bFullScreen;

    structdefaultproperties
    {
        ProfileName="Default"
        ScalabilityBucket=5
        ResolutionX=1920
        ResolutionY=1080
        VsyncInterval=0
        bFullScreen=false
    }
};

struct native PComPerformanceCaptureStat
{
    var name StatName;
    var Double StatValue;

    structdefaultproperties
    {
        StatName="None"
        StatValue=()
    }
};

struct native PComPerformanceCaptureStatsPerNode
{
    var Actor Node;
    var array<PComPerformanceCaptureStat> Stats;

    structdefaultproperties
    {
        Node=none
        Stats=()
    }
};

struct native PComPerformanceCaptureStatsPerSkin
{
    var string CharacterName;
    var string SkinName;
    var string SkeletalMeshPathName;
    var string SkeletalMeshPathNameHead;
    var string SkeletalMeshPathNameBody;
    var string SkeletalMeshPathNameWeapon;
    var array<PComPerformanceCaptureStat> Stats;

    structdefaultproperties
    {
        CharacterName=""
        SkinName=""
        SkeletalMeshPathName=""
        SkeletalMeshPathNameHead=""
        SkeletalMeshPathNameBody=""
        SkeletalMeshPathNameWeapon=""
        Stats=()
    }
};

var config array<config name> StatsToCollect;
var native transient Array_Mirror StatIds;
var transient array<byte> StatTypes;
var config float FOV;
var config array<config PComPerformanceCaptureProfile> Profiles;
var config PComPerformanceCaptureProfile FallbackProfile;
var transient PComPerformanceCaptureProfile ActiveProfile;

// Export UPComPerformanceCaptureBase::execInitializePerformanceCaptureSettings(FFrame&, void* const)
native final function InitializePerformanceCaptureSettings();

// Export UPComPerformanceCaptureBase::execMoveCamera(FFrame&, void* const)
native final function MoveCamera(PlayerController PlayerController, Actor Node);

// Export UPComPerformanceCaptureBase::execEnableNonCycleStats(FFrame&, void* const)
native final function EnableNonCycleStats();

// Export UPComPerformanceCaptureBase::execEnableStatNotify(FFrame&, void* const)
native final function EnableStatNotify();

// Export UPComPerformanceCaptureBase::execGetPerformanceData(FFrame&, void* const)
native final function GetPerformanceData(out array<PComPerformanceCaptureStat> PerfStats);

// Export UPComPerformanceCaptureBase::execStopCycleStats(FFrame&, void* const)
native final function StopCycleStats(out array<PComPerformanceCaptureStat> PerfStats);

// Export UPComPerformanceCaptureBase::execGetMapNameAndTime(FFrame&, void* const)
native final function GetMapNameAndTime(out string MapNameStr, out string FormattedDate, out string FormattedTime);

// Export UPComPerformanceCaptureBase::execGetStatsToCollect(FFrame&, void* const)
native final function GetStatsToCollect(out string FileContents);

// Export UPComPerformanceCaptureBase::execGetPerfStats(FFrame&, void* const)
native final function GetPerfStats(const array<PComPerformanceCaptureStat> PerfStats, out string FileContents);

// Export UPComPerformanceCaptureBase::execCreateFileAndExit(FFrame&, void* const)
native final function CreateFileAndExit(string FileNameWithExtension, string FileContents, string SubfolderName);

defaultproperties
{
    // StatsToCollect(0)="STAT_MeshDrawCalls"
    // StatsToCollect(1)="STAT_StaticDrawListMeshDrawCalls"
    // StatsToCollect(2)="STAT_InitViewsTime"
    // StatsToCollect(3)="STAT_TotalSceneRenderingTime"
    // StatsToCollect(4)="STAT_VirtualAllocSize"
    // StatsToCollect(5)="STAT_StaticMeshTotalMemory"
    // StatsToCollect(6)="STAT_StaticMeshVertexMemory"
    // StatsToCollect(7)="STAT_StaticMeshIndexMemory"
    // StatsToCollect(8)="STAT_AnimationMemory"
    // StatsToCollect(9)="STAT_PixelShaderMemory"
    // StatsToCollect(10)="STAT_VertexShaderMemory"
    // StatsToCollect(11)="STAT_VertexLightingAndShadowingMemory"
    // StatsToCollect(12)="STAT_TextureMemory"
    // StatsToCollect(13)="STAT_TextureLightmapMemory"
    // StatsToCollect(14)="STAT_DepthDrawTime"
    // StatsToCollect(15)="STAT_BasePassDrawTime"
    // StatsToCollect(16)="STAT_TranslucencyDrawTime"
    // StatsToCollect(17)="STAT_ProjectedShadowDrawTime"
    // StatsToCollect(18)="STAT_GameEngineTick"
    // StatsToCollect(19)="STAT_TickTime"
    // StatsToCollect(20)="STAT_ParticleManagerUpdateData"
    // StatsToCollect(21)="STAT_UnrealScriptTime"
    // StatsToCollect(22)="STAT_KismetTime"
    // StatsToCollect(23)="STAT_RedrawViewports"
    // StatsToCollect(24)="STAT_AudioMemory"
    // StatsToCollect(25)="STAT_SkeletalMeshVertexMemory"
    // StatsToCollect(26)="STAT_SkeletalMeshIndexMemory"
    // StatsToCollect(27)="STAT_ProcessedPrimitives"
    // StatsToCollect(28)="STAT_DynamicPathMeshDrawCalls"
    // FOV=100.0000000
    // Profiles(0)=(ProfileName="Min0",ScalabilityBucket=1,ResolutionX=1366,ResolutionY=768,VsyncInterval=0,bFullScreen=false)
    // Profiles(1)=(ProfileName="Min1",ScalabilityBucket=1,ResolutionX=1366,ResolutionY=768,VsyncInterval=0,bFullScreen=false)
    // Profiles(2)=(ProfileName="Med2",ScalabilityBucket=3,ResolutionX=1600,ResolutionY=900,VsyncInterval=0,bFullScreen=false)
    // Profiles(3)=(ProfileName="Med3",ScalabilityBucket=3,ResolutionX=1600,ResolutionY=900,VsyncInterval=0,bFullScreen=false)
    // Profiles(4)=(ProfileName="Med4",ScalabilityBucket=3,ResolutionX=1600,ResolutionY=900,VsyncInterval=0,bFullScreen=false)
    // Profiles(5)=(ProfileName="Max5",ScalabilityBucket=5,ResolutionX=1920,ResolutionY=1080,VsyncInterval=0,bFullScreen=false)
    // Profiles(6)=(ProfileName="Max6",ScalabilityBucket=5,ResolutionX=1920,ResolutionY=1200,VsyncInterval=0,bFullScreen=false)
    // Profiles(7)=(ProfileName="Console",ScalabilityBucket=5,ResolutionX=1920,ResolutionY=1080,VsyncInterval=0,bFullScreen=false)
    // Profiles(8)=(ProfileName="XBox",ScalabilityBucket=5,ResolutionX=1920,ResolutionY=1080,VsyncInterval=0,bFullScreen=false)
    // Profiles(9)=(ProfileName="Switch",ScalabilityBucket=5,ResolutionX=1920,ResolutionY=1080,VsyncInterval=0,bFullScreen=false)
    //FallbackProfile=(ProfileName="Default",ScalabilityBucket=5,ResolutionX=1920,ResolutionY=1080,VsyncInterval=0,bFullScreen=false)
    ActiveProfile=(ProfileName="Default",ScalabilityBucket=5,ResolutionX=1920,ResolutionY=1080,VsyncInterval=0,bFullScreen=false)
}