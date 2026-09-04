class GameTypes extends Object
    native;

const LOADING_MOVIE = "LoadingMovie";

enum EShakeParam
{
    ESP_OffsetRandom,               // 0
    ESP_OffsetZero,                 // 1
    ESP_MAX                         // 2
};

struct native ScreenShakeAnimStruct
{
    var CameraAnim Anim;
    var bool bUseDirectionalAnimVariants;
    var CameraAnim Anim_Left;
    var CameraAnim Anim_Right;
    var CameraAnim Anim_Rear;
    var float AnimPlayRate;
    var float AnimScale;
    var float AnimBlendInTime;
    var float AnimBlendOutTime;
    var bool bRandomSegment;
    var float RandomSegmentDuration;
    var bool bSingleInstance;

    structdefaultproperties
    {
        Anim=none
        bUseDirectionalAnimVariants=false
        Anim_Left=none
        Anim_Right=none
        Anim_Rear=none
        AnimPlayRate=1.0000000
        AnimScale=1.0000000
        AnimBlendInTime=0.2000000
        AnimBlendOutTime=0.2000000
        bRandomSegment=false
        RandomSegmentDuration=0.0000000
        bSingleInstance=false
    }
};

struct native ShakeParams
{
    var GameTypes.EShakeParam X;
    var GameTypes.EShakeParam Y;
    var GameTypes.EShakeParam Z;
    var const transient byte Padding;

    structdefaultproperties
    {
        X=EShakeParam.ESP_OffsetRandom
        Y=EShakeParam.ESP_OffsetRandom
        Z=EShakeParam.ESP_OffsetRandom
        Padding=0
    }
};

struct native ScreenShakeStruct
{
    var float TimeToGo;
    var float TimeDuration;
    var Vector RotAmplitude;
    var Vector RotFrequency;
    var Vector RotSinOffset;
    var ShakeParams RotParam;
    var Vector LocAmplitude;
    var Vector LocFrequency;
    var Vector LocSinOffset;
    var ShakeParams LocParam;
    var float FOVAmplitude;
    var float FOVFrequency;
    var float FOVSinOffset;
    var GameTypes.EShakeParam FOVParam;
    var name ShakeName;
    var bool bOverrideTargetingDampening;
    var float TargetingDampening;

    structdefaultproperties
    {
        TimeToGo=0.0000000
        TimeDuration=1.0000000
        RotAmplitude=(X=100.0000000,Y=100.0000000,Z=200.0000000)
        RotFrequency=(X=10.0000000,Y=10.0000000,Z=25.0000000)
        RotSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        RotParam=(X=EShakeParam.ESP_OffsetRandom,Y=EShakeParam.ESP_OffsetRandom,Z=EShakeParam.ESP_OffsetRandom,Padding=0)
        LocAmplitude=(X=0.0000000,Y=3.0000000,Z=5.0000000)
        LocFrequency=(X=1.0000000,Y=10.0000000,Z=20.0000000)
        LocSinOffset=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        LocParam=(X=EShakeParam.ESP_OffsetRandom,Y=EShakeParam.ESP_OffsetRandom,Z=EShakeParam.ESP_OffsetRandom,Padding=0)
        FOVAmplitude=2.0000000
        FOVFrequency=5.0000000
        FOVSinOffset=0.0000000
        FOVParam=EShakeParam.ESP_OffsetRandom
        ShakeName="None"
        bOverrideTargetingDampening=false
        TargetingDampening=0.0000000
    }
};

struct native TakeHitInfo
{
    var Vector HitLocation;
    var Vector Momentum;
    var Class<DamageType> DamageType;
    var Pawn InstigatedBy;
    var byte HitBoneIndex;
    var PhysicalMaterial PhysicalMaterial;
    var float Damage;
    var Vector RadialDamageOrigin;

    structdefaultproperties
    {
        HitLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Momentum=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        DamageType=none
        InstigatedBy=none
        HitBoneIndex=0
        PhysicalMaterial=none
        Damage=0.0000000
        RadialDamageOrigin=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

struct native GameSpecialMoveInfo
{
    var() name SpecialMoveName;
    var() Class<GameSpecialMove> SpecialMoveClass;
    var() GameSpecialMove SpecialMoveInstance;

    structdefaultproperties
    {
        SpecialMoveName="None"
        SpecialMoveClass=none
        SpecialMoveInstance=none
    }
};

struct native SpecialMoveStruct
{
    var name SpecialMoveName;
    var GamePawn InteractionPawn;
    var Actor InteractionActor;
    var int Flags;

    structdefaultproperties
    {
        SpecialMoveName="None"
        InteractionPawn=none
        InteractionActor=none
        Flags=0
    }
};

struct native AICmdHistoryItem
{
    var Class<GameAICommand> CmdClass;
    var float TimeStamp;
    var string VerboseString;

    structdefaultproperties
    {
        CmdClass=none
        TimeStamp=0.0000000
        VerboseString=""
    }
};

struct native NearbyDynamicItem
{
    var() Actor Dynamic;

    structdefaultproperties
    {
        Dynamic=none
    }
};

struct native CrowdSpawnerPlayerInfo
{
    var Vector ViewLocation;
    var Rotator ViewRotation;
    var Vector PredictLocation;
    var PlayerController PC;

    structdefaultproperties
    {
        ViewLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        ViewRotation=(Pitch=0,Yaw=0,Roll=0)
        PredictLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        PC=none
    }
};

struct native AgentArchetypeInfo
{
    var() Object AgentArchetype;
    var() float FrequencyModifier;
    var() int MaxAllowed;
    var transient int CurrSpawned;
    var() array<Object> GroupMembers;

    structdefaultproperties
    {
        AgentArchetype=none
        FrequencyModifier=1.0000000
        MaxAllowed=0
        CurrSpawned=0
        GroupMembers=none
    }
};

struct native CrowdSpawnInfoItem
{
    var SeqAct_GameCrowdPopulationManagerToggle SeqSpawner;
    var bool bSpawningActive;
    var float SpawnRate;
    var int SpawnNum;
    var float Remainder;
    var array<GameCrowdAgent> ActiveAgents;
    var array<AgentArchetypeInfo> AgentArchetypes;
    var float AgentFrequencySum;
    var float MaxSpawnDist;
    var float MaxSpawnDistSq;
    var float MinBehindSpawnDist;
    var float MinBehindSpawnDistSq;
    var float AgentWarmupTime;
    var bool bForceObstacleChecking;
    var bool bForceNavMeshPathing;
    var bool bEnableCrowdLightEnvironment;
    var bool bCastShadows;
    var LightingChannelContainer AgentLightingChannel;
    var() int NumAgentsToTickPerFrame;
    var int LastAgentTickedIndex;
    var array<GameCrowdDestination> PotentialSpawnPoints;
    var float SpawnPrioritizationInterval;
    var int PrioritizationIndex;
    var int PrioritizationUpdateIndex;
    var array<GameCrowdDestination> PrioritizedSpawnPoints;
    var float PlayerPositionPredictionTime;

    structdefaultproperties
    {
        SeqSpawner=none
        bSpawningActive=false
        SpawnRate=0.0000000
        SpawnNum=0
        Remainder=0.0000000
        ActiveAgents=none
        AgentArchetypes=none
        AgentFrequencySum=0.0000000
        MaxSpawnDist=0.0000000
        MaxSpawnDistSq=0.0000000
        MinBehindSpawnDist=0.0000000
        MinBehindSpawnDistSq=0.0000000
        AgentWarmupTime=3.0000000
        bForceObstacleChecking=false
        bForceNavMeshPathing=false
        bEnableCrowdLightEnvironment=false
        bCastShadows=false
        AgentLightingChannel=(bInitialized=false,BSP=false,Static=false,Dynamic=false,CompositeDynamic=false,Skybox=false,Unnamed_1=false,Unnamed_2=false,Unnamed_3=false,Unnamed_4=false,Unnamed_5=false,Unnamed_6=false,Cinematic_1=false,Cinematic_2=false,Cinematic_3=false,Cinematic_4=false,Cinematic_5=false,Cinematic_6=false,Cinematic_7=false,Cinematic_8=false,Cinematic_9=false,Cinematic_10=false,Gameplay_1=false,Gameplay_2=false,Gameplay_3=false,Gameplay_4=false,Crowd=false)
        NumAgentsToTickPerFrame=0
        LastAgentTickedIndex=0
        PotentialSpawnPoints=none
        SpawnPrioritizationInterval=0.4000000
        PrioritizationIndex=0
        PrioritizationUpdateIndex=0
        PrioritizedSpawnPoints=none
        PlayerPositionPredictionTime=0.0000000
    }
};
