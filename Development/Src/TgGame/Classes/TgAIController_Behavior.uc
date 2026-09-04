class TgAIController_Behavior extends TgAIController
    native(AI)
    config(Game)
    hidecategories(Navigation)
    dependson(TgAIBehaviorNode, TgObject);

const AIBOARD_BEHAVIOR_GOD = 0x01;

const AIBOARD_BEHAVIOR_MAPNPC = 0x02;

const AIBOARD_BEHAVIOR_PET = 0x04;

const AIBOARD_SQUAD = 0x08;

const AIBOARD_BEHAVIOR_LANENPC = 0x10;

enum EBotDifficultyLevel {
    AIDifficulty_Practice,  // 0
    AIDifficulty_Easy1,  // 1
    AIDifficulty_Easy2,  // 2
    AIDifficulty_Medium1,  // 3
    AIDifficulty_Medium2,  // 4
    AIDifficulty_Hard1,  // 5
    AIDifficulty_Hard2,  // 6
    AIDifficulty_Pro1,  // 7
    AIDifficulty_Pro2,  // 8
    AIDifficulty_Max,  // 9
};

enum ECombatTargetType {
    AICombatTarget_Any,  // 0
    AICombatTarget_God,  // 1
    AICombatTarget_Guardian,  // 2
    AICombatTarget_Minion,  // 3
    AICombatTarget_Tower,  // 4
    AICombatTarget_JungleCamp,  // 5
    AICombatTarget_Pet,  // 6
    AICombatTarget_Decoy,  // 7
    AICombatTarget_Deployable,  // 8
    AICombatTarget_GodBot,  // 9
    AICombatTarget_GodHuman,  // 10
    AICombatTarget_SiegeWall,  // 11
    AICombatTarget_Turret,  // 12
};

enum EJungleTargetType {
    AIJungleTarget_Attack,  // 0
    AIJungleTarget_Mana,  // 1
    AIJungleTarget_Speed,  // 2
    AIJungleTarget_BigXP,  // 3
    AIJungleTarget_LittleXP,  // 4
    AIJungleTarget_GoldFury,  // 5
    AIJungleTarget_Nearest,  // 6
};

enum EConsumableType {
    AIConsumable_HealthPotion,  // 0
    AIConsumable_ManaPotion,  // 1
    AIConsumable_MultiPotion,  // 2
    AIConsumable_Ward,  // 3
    AIConsumable_DamagePotion,  // 4
    AIConsumable_DefensePotion,  // 5
};

enum EActiveType {
    AIActive_Meditation,  // 0
    AIActive_HandOfGods,  // 1
    AIActive_Sprint,  // 2
    AIActive_Ward,  // 3
    AIActive_Aegis,  // 4
    AIActive_Beads,  // 5
};

enum EEffectGroupCategory {
    AIEffectCategory_None,  // 0
    AIEffectCategory_Slow,  // 1
    AIEffectCategory_Stun,  // 2
    AIEffectCategory_Frozen,  // 3
    AIEffectCategory_Knockback,  // 4
    AIEffectCategory_Root,  // 5
    AIEffectCategory_Silence,  // 6
    AIEffectCategory_Disarm,  // 7
    AIEffectCategory_Cripple,  // 8
    AIEffectCategory_Daze,  // 9
    AIEffectCategory_Fear,  // 10
    AIEffectCategory_Taunt,  // 11
    AIEffectCategory_Mesmerize,  // 12
};

enum ERangeType {
    RangeType_Short,  // 0
    RangeType_Mid,  // 1
    RangeType_Long,  // 2
    RangeType_None,  // 3
};

enum EUseDeviceAimType {
    AIDeviceAim_CombatTarget,  // 0
    AIDeviceAim_Self,  // 1
};

enum ESelectionArbitrator {
    ARBITRATE_FAIL,  // 0
    ARBITRATE_CLOSEST,  // 1
    ARBITRATE_RANDOM,  // 2
    ARBITRATE_FIRST,  // 3
};

enum ETargetSelector {
    TargetSelect_Closest,  // 0
    TargetSelect_Weakest,  // 1
    TargetSelect_Strongest,  // 2
    TargetSelect_LowestPercentHealth,  // 3
    TargetSelect_Random,  // 4
};

enum EAIAnnotationType {
    AIA_AssaultPoint,  // 0
    AIA_CoverPoint,  // 1
};

enum EUtilityType {
    UTIL_Function,  // 0
    UTIL_Filter,  // 1
};

struct DeferredNode {
    var float WorldTime;
    var Pointer CurrentNode;
    var Pointer CachedStatus;
    var Pointer StorageMemory;
    var Pointer WorkingMemory;
    structdefaultproperties {}
};

struct NavigationQueueEntry {
    var TgPawn TargetPawn;
    var Actor TargetActor;
    var Vector TargetLocation;
    var bool bNewEntry;
    var bool bCanCacheLOS;
    var bool bCachedLOS;
    var bool bLookAtTarget;
    var bool bMustHaveLOS;
    var bool bStopNavOnReachedDestination;
    var float DistanceTolerance;
    var int NodeToken;
    var int TeleportIndex;
    structdefaultproperties {}
};

struct FollowLaneState {
    var int LastLaneIndex;
    var bool bFinalApproach;
    var bool bLockedToMarker;
    structdefaultproperties {}
};

struct IncomingDamageEntry {
    var TgPawn attacker;
    var TgObject.TG_EQUIP_POINT DeviceSlot;
    var Vector SourceInitialLocation;
    var Rotator SourceInitialAim;
    var float ExpireTime;
    var float RemovalTime;
    var float Weight;
    structdefaultproperties {}
};

var init transient array<init DeferredNode> DeferredNodes;
var transient int BlackboardType;
var name BehaviorTreeAsName;
var native transient Pointer SensorTree;
var native transient Pointer SensorDynamicMemory;
var native transient Pointer SensorStaticMemory;
var native transient Pointer WorkerTree;
var native transient Pointer WorkerTreeCachedStatus;
var native transient Pointer WorkerDynamicMemory;
var native transient Pointer WorkerStaticMemory;
var transient int SensorNodeCount;
var transient int WorkerNodeCount;
var transient float LastUpdateTime;
var init transient array<init BehaviorStateData> CachedNodeData;
var float m_fCooldownModifier;
var float m_fLeadAccuracy;
var float m_fRefireSpeedModifier;
var float m_fDegreeMissedMagnitude;
var float m_fMissLikelihood;
var transient TgAILocalPositionSolver LocalRepulsorSolver;
var Class<TgAILocalPositionSolver> LocalRepulsorSolverClass;
var transient NavigationQueueEntry CurrentNavigation;
var transient float NavigationSearchModifier;
var float NavigationSearchModifier_Max;
var float NavigationSearchModifier_Min;
var FollowLaneState FollowLaneForwardState;
var FollowLaneState FollowLaneReverseState;
var transient bool bIsAlive;
var protected transient bool m_bPaused;
var transient bool bIsRotationLocked;
var transient bool bIsStunned;
var transient bool bInHostileAbility;
var transient bool bIsSafeToRecall;
var transient bool bInEnemyTowerRadius;
var transient bool bInFriendlyTowerRadius;
var transient bool bInEnemyMinotaurRadius;
var transient bool bInFriendlyMinotaurRadius;
var transient bool bIsTargetOfEnemyTowerOrMinotaur;
var transient bool bCombatTargetInEnemyTowerRadius;
var transient bool bCombatTargetInFriendlyTowerRadius;
var transient bool bCombatTargetInEnemyMinotaurRadius;
var transient bool bCombatTargetInFriendlyMinotaurRadius;
var transient bool bCombatTargetIsTargetOfFriendlyTowerOrMinotaur;
var transient bool bIsAtFortress;
var transient bool bIsAtEnemyFortress;
var transient bool bIsAtCachedRallyPoint;
var bool bBtDebugSpawnPaused;
var transient bool bBtDebugPaused;
var transient bool bBtDebugStep;
var transient bool bBtDebugClientOverlay;
var transient Vector NextFearDirection;
var transient float PawnCollisionHeight;
var transient float PawnCollisionRadius;
var transient float DeviceRanges[25];
var transient Actor CombatTarget;
var transient TgPawn CombatTargetAsPawn;
var transient int EnemyMinionsInEnemyTowerRadius;
var transient int FriendlyMinionsInEnemyTowerRadius;
var transient int EnemyMinionsInFriendlyTowerRadius;
var transient int FriendlyMinionsInFriendlyTowerRadius;
var transient int EnemyGodsInEnemyTowerRadius;
var transient int FriendlyGodsInEnemyTowerRadius;
var transient int EnemyGodsInFriendlyTowerRadius;
var transient int FriendlyGodsInFriendlyTowerRadius;
var transient float HealthOfNearestEnemyTower;
var transient float HealthOfNearestFriendlyTower;
var transient Actor LaneMoveTarget;
var init transient array<init Actor> VisibleActorsToAvoid;
var init transient array<init TgPawn> CachedTowers;
var init transient array<init TgPawn_Character> CachedGods;
var transient array<Controller> EnemyControllersInSightRadius;
var transient array<Controller> FriendlyControllersInSightRadius;
var transient TgAIController_Behavior.EBotDifficultyLevel Difficulty;
var transient TgAIController_Behavior.EUseDeviceAimType LastUseDeviceAimType;
var transient Vector TargetLastKnownLocation;
var transient TgAIAnnotation CurrentAssaultPoint;
var transient array<IncomingDamageEntry> IncomingDamage;
var transient TgAIVolume CachedRallyVolume;
var transient int RandomRallyPointIndex;
var transient TgPawn_SiegeWall FortressObjective;
var transient Vector AlliedFortressLookDir;
var transient Vector EnemyFortressLookDir;
var transient TgFortressVolume AlliedFortress;
var transient TgFortressVolume EnemyFortress;
var transient Vector StrafeDir;
var transient float LastStrafeDirUpdate;
var transient float StrafeDirUpdateTime;
var Class<TgAIUtilityHandle> UtilityHandleClass;
var transient TgAIUtilityHandle UtilityHandle;
var transient Actor EscortActor;
var transient float EscortMinDistance;
var transient float EscortMaxDistance;
var transient int m_nDevicesLockingInput;

event UpdatePawnDebug() { }

simulated function Debug_Pause() { }

simulated function Debug_Step() { }

simulated function Debug_Resume() { }

simulated function Debug_Reset() { }

native function SpawnDebuggerWindow();  // Export UTgAIController_Behavior::execSpawnDebuggerWindow(FFrame&, void* const)

native function CleanupBehaviorTree();  // Export UTgAIController_Behavior::execCleanupBehaviorTree(FFrame&, void* const)

native function ResetBehaviorTree();  // Export UTgAIController_Behavior::execResetBehaviorTree(FFrame&, void* const)

native function LoadBehaviorTree(optional name TreeName);  // Export UTgAIController_Behavior::execLoadBehaviorTree(FFrame&, void* const)

event PreBeginPlay() { }

event PostBeginPlay() { }

event Destroyed() { }

event Possess(Pawn inPawn, bool bVehicleTransition) { }

event ResetBlackboard() { }

native function bool HasVisibilityToPoint(const out Vector TestPoint);  // Export UTgAIController_Behavior::execHasVisibilityToPoint(FFrame&, void* const)

native function AddActorToNavigationQueue(int NodeToken, Actor TargetActor, bool bLookAtTarget, bool bMustHaveLOS, float DistanceTolerance, optional bool bStopNavOnReachedDestination=true);  // Export UTgAIController_Behavior::execAddActorToNavigationQueue(FFrame&, void* const)

native function AddLocationToNavigationQueue(int NodeToken, Vector TargetLocation, bool bLookAtTarget, bool bMustHaveLOS, float DistanceTolerance);  // Export UTgAIController_Behavior::execAddLocationToNavigationQueue(FFrame&, void* const)

native function ClearNavigation();  // Export UTgAIController_Behavior::execClearNavigation(FFrame&, void* const)

native function StopNavigation();  // Export UTgAIController_Behavior::execStopNavigation(FFrame&, void* const)

native function UpdateDeviceRanges();  // Export UTgAIController_Behavior::execUpdateDeviceRanges(FFrame&, void* const)

simulated function Stun(bool bStun, optional Controller.EStunType eType=0) { }

native function float GetCooldownIncrease();  // Export UTgAIController_Behavior::execGetCooldownIncrease(FFrame&, void* const)

native function Vector CalculateAim(bool bHeadShot);  // Export UTgAIController_Behavior::execCalculateAim(FFrame&, void* const)

event bool FireDevice(TgObject.TG_EQUIP_POINT DeviceSlot, bool bContinuousFire, optional TgAIController_Behavior.EUseDeviceAimType aimType=0) { }

event bool CancelFiring() { }

event bool StopFireDevice(TgObject.TG_EQUIP_POINT DeviceSlot, optional bool bForce) { }

event DeviceOnStopFire(TgDevice Dev, optional bool WasInterrupted=false) { }

function float GetAngleToTarget() { }

function float GetCooldownModifier() { }

function float GetLeadAccuracy() { }

function Rotator CalcUniformInaccuracy(float DegMissed) { }

function Rotator CalcGaussianInaccuracy(float StdDev) { }

function Rotator GetAdjustedAimFor(Weapon W, vector StartFireLoc) { }

function PawnDied(Pawn P) { }

function GameHasEnded(optional Actor EndGameFocus, optional bool bIsWinner) { }

event SetPaused(bool bPaused) { }

event bool IsPaused() { }

event PauseForDuration(float PauseDuration) { }

event UnpauseFromDuration() { }

auto state Idle {}

defaultproperties
{
    m_fCooldownModifier=1.0000000
    m_fLeadAccuracy=0.3000000
    m_fRefireSpeedModifier=1.0000000
    m_fDegreeMissedMagnitude=15.0000000
    m_fMissLikelihood=0.6500000
    CurrentNavigation=(TargetPawn=none,TargetActor=none,TargetLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000),bNewEntry=true,bCanCacheLOS=false,bCachedLOS=false,bLookAtTarget=false,bMustHaveLOS=false,bStopNavOnReachedDestination=true,DistanceTolerance=0.0000000,NodeToken=-1,TeleportIndex=0)
    FollowLaneForwardState=(LastLaneIndex=-1,bFinalApproach=false,bLockedToMarker=false)
    FollowLaneReverseState=(LastLaneIndex=-1,bFinalApproach=false,bLockedToMarker=false)
    Difficulty=AIDifficulty_Medium1
    StrafeDirUpdateTime=1.0000000
    EscortMinDistance=200.0000000
    EscortMaxDistance=250.0000000
    WalkingPhysics=PHYS_Walking
    TickGroup=TG_PostAsyncWork
    m_bHasThreadedWork=true
}
