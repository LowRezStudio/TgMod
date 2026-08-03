class TgAIController_Behavior extends TgAIController
    native(AI)
    config(Game)
    hidecategories(Navigation);

const AIBOARD_BEHAVIOR_GOD = 0x01;
const AIBOARD_BEHAVIOR_MAPNPC = 0x02;
const AIBOARD_BEHAVIOR_PET = 0x04;
const AIBOARD_SQUAD = 0x08;
const AIBOARD_BEHAVIOR_LANENPC = 0x10;

enum EBotDifficultyLevel
{
    AIDifficulty_Practice,          // 0
    AIDifficulty_Easy1,             // 1
    AIDifficulty_Easy2,             // 2
    AIDifficulty_Medium1,           // 3
    AIDifficulty_Medium2,           // 4
    AIDifficulty_Hard1,             // 5
    AIDifficulty_Hard2,             // 6
    AIDifficulty_Pro1,              // 7
    AIDifficulty_Pro2,              // 8
    AIDifficulty_Max                // 9
};

enum ECombatTargetType
{
    AICombatTarget_Any,             // 0
    AICombatTarget_God,             // 1
    AICombatTarget_Guardian,        // 2
    AICombatTarget_Minion,          // 3
    AICombatTarget_Tower,           // 4
    AICombatTarget_JungleCamp,      // 5
    AICombatTarget_Pet,             // 6
    AICombatTarget_Decoy,           // 7
    AICombatTarget_Deployable,      // 8
    AICombatTarget_GodBot,          // 9
    AICombatTarget_GodHuman,        // 10
    AICombatTarget_SiegeWall,       // 11
    AICombatTarget_Turret,          // 12
    AICombatTarget_MAX              // 13
};

enum EJungleTargetType
{
    AIJungleTarget_Attack,          // 0
    AIJungleTarget_Mana,            // 1
    AIJungleTarget_Speed,           // 2
    AIJungleTarget_BigXP,           // 3
    AIJungleTarget_LittleXP,        // 4
    AIJungleTarget_GoldFury,        // 5
    AIJungleTarget_Nearest,         // 6
    AIJungleTarget_MAX              // 7
};

enum EConsumableType
{
    AIConsumable_HealthPotion,      // 0
    AIConsumable_ManaPotion,        // 1
    AIConsumable_MultiPotion,       // 2
    AIConsumable_Ward,              // 3
    AIConsumable_DamagePotion,      // 4
    AIConsumable_DefensePotion,     // 5
    AIConsumable_MAX                // 6
};

enum EActiveType
{
    AIActive_Meditation,            // 0
    AIActive_HandOfGods,            // 1
    AIActive_Sprint,                // 2
    AIActive_Ward,                  // 3
    AIActive_Aegis,                 // 4
    AIActive_Beads,                 // 5
    AIActive_MAX                    // 6
};

enum EEffectGroupCategory
{
    AIEffectCategory_None,          // 0
    AIEffectCategory_Slow,          // 1
    AIEffectCategory_Stun,          // 2
    AIEffectCategory_Frozen,        // 3
    AIEffectCategory_Knockback,     // 4
    AIEffectCategory_Root,          // 5
    AIEffectCategory_Silence,       // 6
    AIEffectCategory_Disarm,        // 7
    AIEffectCategory_Cripple,       // 8
    AIEffectCategory_Daze,          // 9
    AIEffectCategory_Fear,          // 10
    AIEffectCategory_Taunt,         // 11
    AIEffectCategory_Mesmerize,     // 12
    AIEffectCategory_MAX            // 13
};

enum ERangeType
{
    RangeType_Short,                // 0
    RangeType_Mid,                  // 1
    RangeType_Long,                 // 2
    RangeType_None,                 // 3
    RangeType_MAX                   // 4
};

enum EUseDeviceAimType
{
    AIDeviceAim_CombatTarget,       // 0
    AIDeviceAim_Self,               // 1
    AIDeviceAim_MAX                 // 2
};

enum ESelectionArbitrator
{
    ARBITRATE_FAIL,                 // 0
    ARBITRATE_CLOSEST,              // 1
    ARBITRATE_RANDOM,               // 2
    ARBITRATE_FIRST,                // 3
    ARBITRATE_MAX                   // 4
};

enum ETargetSelector
{
    TargetSelect_Closest,           // 0
    TargetSelect_Weakest,           // 1
    TargetSelect_Strongest,         // 2
    TargetSelect_LowestPercentHealth,// 3
    TargetSelect_Random,            // 4
    TargetSelect_MAX                // 5
};

enum EAIAnnotationType
{
    AIA_AssaultPoint,               // 0
    AIA_CoverPoint,                 // 1
    AIA_MAX                         // 2
};

enum EUtilityType
{
    UTIL_Function,                  // 0
    UTIL_Filter,                    // 1
    UTIL_MAX                        // 2
};

struct native DeferredNode
{
    var float WorldTime;
    var native Pointer CurrentNode;
    var native Pointer CachedStatus;
    var native Pointer StorageMemory;
    var native Pointer WorkingMemory;

    structdefaultproperties
    {
        WorldTime=0.0000000
    }
};

struct native NavigationQueueEntry
{
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

    structdefaultproperties
    {
        TargetPawn=none
        TargetActor=none
        TargetLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        bNewEntry=false
        bCanCacheLOS=false
        bCachedLOS=false
        bLookAtTarget=false
        bMustHaveLOS=false
        bStopNavOnReachedDestination=false
        DistanceTolerance=0.0000000
        NodeToken=0
        TeleportIndex=0
    }
};

struct native FollowLaneState
{
    var int LastLaneIndex;
    var bool bFinalApproach;
    var bool bLockedToMarker;

    structdefaultproperties
    {
        LastLaneIndex=-1
        bFinalApproach=false
        bLockedToMarker=false
    }
};

struct native IncomingDamageEntry
{
    var TgPawn attacker;
    var TgObject.TG_EQUIP_POINT DeviceSlot;
    var Vector SourceInitialLocation;
    var Rotator SourceInitialAim;
    var float ExpireTime;
    var float RemovalTime;
    var float Weight;

    structdefaultproperties
    {
        attacker=none
        DeviceSlot=TG_EQUIP_POINT.EQP_NONE
        SourceInitialLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        SourceInitialAim=(Pitch=0,Yaw=0,Roll=0)
        ExpireTime=0.0000000
        RemovalTime=0.0000000
        Weight=0.0000000
    }
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

event UpdatePawnDebug()
{
    local TgPawn TgP;

    TgP = TgPawn(Pawn);
    // End:0x64
    if((!bBtDebugClientOverlay || TgP == none) || !TgP.r_bDebugShowAIDebug)
    {
        return;
    }
    TgP.r_sDebugName = string(Pawn);
    TgP.r_sDebugFactory = string(m_pFactory);
    TgP.r_nDebugSightRange = int(GetVisionDistance());
    TgP.r_nDebugHearingRange = int(Pawn.HearingThreshold);
    TgP.r_nDebugFOV = int(Pawn.PeripheralVision);
    TgP.r_aDebugTarget = CombatTarget;
    TgP.r_aDebugDestination = LaneMoveTarget;
    TgP.r_vDebugNextNavMeshPoint = GetDestinationPosition();
    TgP.r_vDebugSpreadoutLocation = SpreadLocation;
    // End:0x5F5
    if(!bIsPaused)
    {
        switch(CurrentNavigation.NodeToken)
        {
            // End:0x277
            case 1048579:
                TgP.r_sDebugAction = "Follow Combat Target";
                // End:0x5F2
                break;
            // End:0x2B6
            case 1048581:
                TgP.r_sDebugAction = "Move to Lane Target";
                // End:0x5F2
                break;
            // End:0x2EE
            case 1048578:
                TgP.r_sDebugAction = "Run To Spawn";
                // End:0x5F2
                break;
            // End:0x326
            case 1048601:
                TgP.r_sDebugAction = "Run To Owner";
                // End:0x5F2
                break;
            // End:0x35D
            case 1048602:
                TgP.r_sDebugAction = "Follow Lane";
                // End:0x5F2
                break;
            // End:0x39E
            case 1048619:
                TgP.r_sDebugAction = "Follow Lane - Reverse";
                // End:0x5F2
                break;
            // End:0x3E0
            case 1048597:
                TgP.r_sDebugAction = "Run to Spread Location";
                // End:0x5F2
                break;
            // End:0x41E
            case 1048700:
                TgP.r_sDebugAction = "Move to Lanepusher";
                // End:0x5F2
                break;
            // End:0x45F
            case 1048701:
                TgP.r_sDebugAction = "Move to Capture Point";
                // End:0x5F2
                break;
            // End:0x4A3
            case 1048623:
                TgP.r_sDebugAction = "Move to Assault Position";
                // End:0x5F2
                break;
            // End:0x4D5
            case 1048621:
                TgP.r_sDebugAction = "Strafe";
                // End:0x5F2
                break;
            // End:0x512
            case 1048622:
                TgP.r_sDebugAction = "Spread From Squad";
                // End:0x5F2
                break;
            // End:0x550
            case 1048628:
                TgP.r_sDebugAction = "Move to Deployable";
                // End:0x5F2
                break;
            // End:0x589
            case 1048624:
                TgP.r_sDebugAction = "Move to Cover";
                // End:0x5F2
                break;
            // End:0x5C7
            case 1048615:
                TgP.r_sDebugAction = "Run to Rally Point";
                // End:0x5F2
                break;
            // End:0xFFFF
            default:
                TgP.r_sDebugAction = "None";
                // End:0x5F2
                break;
                break;
        }        
    }
    else
    {
        TgP.r_sDebugAction = "PAUSED";
    }
    //return;    
}

simulated function Debug_Pause()
{
    bBtDebugPaused = true;
    //return;    
}

simulated function Debug_Step()
{
    // End:0x1B
    if(!bBtDebugPaused)
    {
        bBtDebugPaused = true;
    }
    bBtDebugStep = true;
    //return;    
}

simulated function Debug_Resume()
{
    bBtDebugPaused = false;
    bBtDebugStep = false;
    //return;    
}

simulated function Debug_Reset()
{
    Debug_Resume();
    ResetBlackboard();
    //return;    
}

// Export UTgAIController_Behavior::execSpawnDebuggerWindow(FFrame&, void* const)
native function SpawnDebuggerWindow();

// Export UTgAIController_Behavior::execCleanupBehaviorTree(FFrame&, void* const)
native function CleanupBehaviorTree();

// Export UTgAIController_Behavior::execResetBehaviorTree(FFrame&, void* const)
native function ResetBehaviorTree();

// Export UTgAIController_Behavior::execLoadBehaviorTree(FFrame&, void* const)
native function LoadBehaviorTree(optional name TreeName);

event PreBeginPlay()
{
    bIsAlive = true;
    super(AIController).PreBeginPlay();
    //return;    
}

event PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x31
    if(LocalRepulsorSolverClass != none)
    {
        LocalRepulsorSolver = new (self) LocalRepulsorSolverClass;
    }
    // End:0x58
    if(UtilityHandleClass != none)
    {
        UtilityHandle = new (self) UtilityHandleClass;
    }
    //return;    
}

event Destroyed()
{
    CleanupBehaviorTree();
    super.Destroyed();
    //return;    
}

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    local TgPawn TgP;
    local TgGame_Paladins ChaosGame;

    super.Possess(inPawn, bVehicleTransition);
    bBtDebugPaused = bBtDebugSpawnPaused;
    TgP = TgPawn(Pawn);
    // End:0x115
    if(TgP != none)
    {
        PawnCollisionRadius = TgP.GetCollisionRadius();
        PawnCollisionHeight = TgP.GetCollisionHeight();
        NavMeshPath_SearchExtent_Modifier.X = PawnCollisionRadius * 0.2500000;
        NavMeshPath_SearchExtent_Modifier.Y = NavMeshPath_SearchExtent_Modifier.X;
    }
    ChaosGame = TgGame_Paladins(WorldInfo.Game);
    // End:0x17E
    if(ChaosGame != none)
    {
        ChaosGame.UpdateTgPawnMetaGameState(TgP);
    }
    //return;    
}

event ResetBlackboard()
{
    ResetBehaviorTree();
    StopNavigation();
    CombatTarget = none;
    CombatTargetAsPawn = none;
    LaneMoveTarget = none;
    VisibleActorsToAvoid.Remove(0, VisibleActorsToAvoid.Length);
    CachedTowers.Remove(0, CachedTowers.Length);
    CachedGods.Remove(0, CachedGods.Length);
    EnemyControllersInSightRadius.Remove(0, EnemyControllersInSightRadius.Length);
    FriendlyControllersInSightRadius.Remove(0, FriendlyControllersInSightRadius.Length);
    CachedRallyVolume = none;
    //return;    
}

// Export UTgAIController_Behavior::execHasVisibilityToPoint(FFrame&, void* const)
native function bool HasVisibilityToPoint(const out Vector TestPoint);

// Export UTgAIController_Behavior::execAddActorToNavigationQueue(FFrame&, void* const)
native function AddActorToNavigationQueue(int NodeToken, Actor TargetActor, bool bLookAtTarget, bool bMustHaveLOS, float DistanceTolerance, optional bool bStopNavOnReachedDestination = true);

// Export UTgAIController_Behavior::execAddLocationToNavigationQueue(FFrame&, void* const)
native function AddLocationToNavigationQueue(int NodeToken, Vector TargetLocation, bool bLookAtTarget, bool bMustHaveLOS, float DistanceTolerance);

// Export UTgAIController_Behavior::execClearNavigation(FFrame&, void* const)
native function ClearNavigation();

// Export UTgAIController_Behavior::execStopNavigation(FFrame&, void* const)
native function StopNavigation();

// Export UTgAIController_Behavior::execUpdateDeviceRanges(FFrame&, void* const)
native function UpdateDeviceRanges();

simulated function Stun(bool bStun, optional Controller.EStunType eType = 0)
{
    m_eCurrentStunType = eType;
    bIsStunned = bStun;
    bPreciseDestination = false;
    // End:0xB0
    if((Pawn != none) && bStun)
    {
        Pawn.Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
        Pawn.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    }
    NextFearDirection = vect(0.0000000, 0.0000000, 0.0000000);
    //return;    
}

// Export UTgAIController_Behavior::execGetCooldownIncrease(FFrame&, void* const)
native function float GetCooldownIncrease();

// Export UTgAIController_Behavior::execCalculateAim(FFrame&, void* const)
native function Vector CalculateAim(bool bHeadShot);

event bool FireDevice(TgObject.TG_EQUIP_POINT DeviceSlot, bool bContinuousFire, optional TgAIController_Behavior.EUseDeviceAimType aimType = 0)
{
    local bool bFireSuccessful, bUseAltFire;
    local TgDevice DevToFire, AltFireSecondModeDev, Mount;
    local TgPawn aPawn;

    aPawn = TgPawn(Pawn);
    // End:0x33
    if(aPawn == none)
    {
        return false;
    }
    // End:0x49
    if(int(m_eCurrentStunType) != int(0))
    {
        return false;
    }
    DevToFire = aPawn.m_EquippedDevices[int(DeviceSlot)];
    // End:0x8E
    if(DevToFire == none)
    {
        return false;
    }
    // End:0xD6
    if(DevToFire.IsEquipping() || DevToFire.IsFiring())
    {
        return true;
    }
    LastUseDeviceAimType = aimType;
    // End:0x188
    if(DevToFire.ShouldInterruptMount())
    {
        Mount = aPawn.GetDeviceByEqPoint(23);
        // End:0x188
        if((Mount != none) && Mount.CanBeCanceled())
        {
            Mount.InterruptFiring();
        }
    }
    // End:0x25C
    if(int(DeviceSlot) == int(16))
    {
        AltFireSecondModeDev = aPawn.m_EquippedDevices[1];
        // End:0x25C
        if(((AltFireSecondModeDev != none) && AltFireSecondModeDev.m_bAltFireEnabled) && int(AltFireSecondModeDev.m_AltFireType) == int(1))
        {
            AltFireSecondModeDev.AltUse(true);
            bFireSuccessful = true;
            bUseAltFire = true;
        }
    }
    // End:0x28C
    if(bUseAltFire)
    {
        AltFireSecondModeDev.AltUse(false);        
    }
    else
    {
        bFireSuccessful = aPawn.StartAction(DevToFire);
        // End:0x33F
        if(bFireSuccessful && DevToFire.GetCurrentFire().m_bContinuousFire)
        {
            // End:0x33F
            if(!bContinuousFire)
            {
                aPawn.StopAction(DevToFire);
            }
        }
    }
    return bFireSuccessful;
    //return ReturnValue;    
}

event bool CancelFiring()
{
    local TgPawn P;
    local int I;
    local TgDevice Dev;

    P = TgPawn(Pawn);
    // End:0xD8
    if(P != none)
    {
        I = 0;
        J0x36:

        // End:0xD6 [Loop If]
        if(I < 33)
        {
            Dev = P.m_EquippedDevices[I];
            // End:0xC8
            if(Dev != none)
            {
                // End:0xC8
                if(Dev.CanFiringBeCanceledByRightMouse())
                {
                    Dev.InterruptFiring();
                }
            }
            ++I;
            // [Loop Continue]
            goto J0x36;
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

event bool StopFireDevice(TgObject.TG_EQUIP_POINT DeviceSlot, optional bool bForce)
{
    local TgDevice DevToFire, AltFireSecondModeDev;
    local TgPawn aPawn;

    aPawn = TgPawn(Pawn);
    // End:0x2E
    if(aPawn == none)
    {
        return false;
    }
    DevToFire = aPawn.m_EquippedDevices[int(DeviceSlot)];
    // End:0x73
    if(DevToFire == none)
    {
        return false;
    }
    // End:0x99
    if(!DevToFire.IsFiring())
    {
        return true;
    }
    // End:0x156
    if(int(DeviceSlot) == int(16))
    {
        AltFireSecondModeDev = aPawn.m_EquippedDevices[1];
        // End:0x156
        if(((AltFireSecondModeDev != none) && AltFireSecondModeDev.m_bAltFireEnabled) && int(AltFireSecondModeDev.m_AltFireType) == int(1))
        {
            AltFireSecondModeDev.InterruptFiring();
            return true;
        }
    }
    // End:0x1ED
    if(!(DevToFire.IsOffhand() || DevToFire.IsPurchasedAbility()) || DevToFire.IsFunctionallyToggleDevice())
    {
        aPawn.StopAction(DevToFire);        
    }
    else
    {
        // End:0x22E
        if(DevToFire.CanBeCanceled())
        {
            DevToFire.InterruptFiring();
        }
    }
    // End:0x27E
    if(bForce && DevToFire.IsFiring())
    {
        DevToFire.InterruptFiring();
    }
    return true;
    //return ReturnValue;    
}

event DeviceOnStopFire(TgDevice Dev, optional bool WasInterrupted = false)
{
    //return;    
}

function float GetAngleToTarget()
{
    local Vector vDiff, vRot;

    // End:0x5A
    if(CombatTarget != none)
    {
        vDiff = CombatTarget.Location - Pawn.Location;        
    }
    else
    {
        return -1.0000000;
    }
    vRot = Vector(Pawn.Rotation);
    vRot.Z = 0.0000000;
    vDiff.Z = 0.0000000;
    return Normal(vDiff) Dot Normal(vRot);
    //return ReturnValue;    
}

function float GetCooldownModifier()
{
    return m_fCooldownModifier;
    //return ReturnValue;    
}

function float GetLeadAccuracy()
{
    return m_fLeadAccuracy;
    //return ReturnValue;    
}

function Rotator CalcUniformInaccuracy(float DegMissed)
{
    local Rotator MissRot;
    local int MissSign;

    MissRot.Pitch = int((((DegMissed / 6.0000000) * FRand()) * float(65536)) / float(360));
    MissSign = Rand(2);
    // End:0x85
    if(MissSign == 1)
    {
        MissRot.Pitch *= -1.0000000;
    }
    MissRot.Yaw = int((((DegMissed / 2.0000000) * FRand()) * float(65536)) / float(360));
    MissSign = Rand(2);
    // End:0x10A
    if(MissSign == 1)
    {
        MissRot.Yaw *= -1.0000000;
    }
    MissRot.Roll = 0;
    return MissRot;
    //return ReturnValue;    
}

function Rotator CalcGaussianInaccuracy(float StdDev)
{
    local int NumRolls, Index;
    local float GaussianRand;
    local Rotator MissRot;
    local Vector RandVect;

    NumRolls = int((float(3) * StdDev) * StdDev);
    GaussianRand = 0.0000000;
    RandVect = VRand();
    Index = 0;
    J0x4C:

    // End:0x8C [Loop If]
    if(Index < NumRolls)
    {
        GaussianRand += ((2.0000000 * FRand()) - 1.0000000);
        Index++;
        // [Loop Continue]
        goto J0x4C;
    }
    RandVect *= FClamp(GaussianRand, 0.0000000, 2.0000000 * StdDev);
    MissRot.Pitch = int(((RandVect.Y / 2.0000000) * float(65536)) / float(360));
    MissRot.Yaw = int((RandVect.X * float(65536)) / float(360));
    MissRot.Roll = 0;
    return MissRot;
    //return ReturnValue;    
}

function Rotator GetAdjustedAimFor(Weapon W, Vector StartFireLoc)
{
    local Rotator AdjustedAim;

    AdjustedAim = ((Pawn != none) ? Pawn.GetBaseAimRotation(W) : Rotation);
    return AdjustedAim;
    //return ReturnValue;    
}

function PawnDied(Pawn P)
{
    StopNavigation();
    bIsAlive = false;
    super.PawnDied(P);
    //return;    
}

function GameHasEnded(optional Actor EndGameFocus, optional bool bIsWinner)
{
    Stun(true);
    //return;    
}

event SetPaused(bool bPaused)
{
    // End:0x3C
    if(!bPaused && IsTimerActive('UnpauseFromDuration'))
    {
        ClearTimer('UnpauseFromDuration');
    }
    m_bPaused = bPaused;
    //return;    
}

event bool IsPaused()
{
    return m_bPaused;
    //return ReturnValue;    
}

event PauseForDuration(float PauseDuration)
{
    // End:0x15
    if(PauseDuration <= 0.0000000)
    {
        return;
    }
    SetPaused(true);
    // End:0xA0
    if(IsTimerActive('UnpauseFromDuration'))
    {
        // End:0x72
        if((GetTimerRate('UnpauseFromDuration') - GetTimerCount('UnpauseFromDuration')) > PauseDuration)
        {            
        }
        else
        {
            ClearTimer('UnpauseFromDuration');
            SetTimer(PauseDuration, false, 'UnpauseFromDuration');
        }        
    }
    else
    {
        SetTimer(PauseDuration, false, 'UnpauseFromDuration');
    }
    //return;    
}

event UnpauseFromDuration()
{
    SetPaused(false);
    //return;    
}

auto state Idle
{    stop;    
}

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
    Difficulty=EBotDifficultyLevel.AIDifficulty_Medium1
    StrafeDirUpdateTime=1.0000000
    EscortMinDistance=200.0000000
    EscortMaxDistance=250.0000000
    WalkingPhysics=EPhysics.PHYS_Walking
    TickGroup=ETickingGroup.TG_PostAsyncWork
    m_bHasThreadedWork=true
}