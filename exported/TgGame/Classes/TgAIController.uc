class TgAIController extends GameAIController
    native(AI)
    config(Game)
    hidecategories(Navigation);

const AI_TEAM_PASSTHRU_DISTANCE = 100000;
const AI_DEFAULT_DISTANCE_OFFSET = 50;
const SMITE_MIDPOINT_ROUTE_THRESHOLD = 176.0f;
const SMITE_MINION_INTRASQUAD_SPAWN_DELAY = 0.5f;

struct native ThreatStruct
{
    var Actor Threatener;
    var float fThreat;

    structdefaultproperties
    {
        Threatener=none
        fThreat=0.0000000
    }
};

var transient TgPawn m_pOwner;
var transient Vector m_vSpawnLocation;
var transient Rotator m_rSpawnDirection;
var transient TgBotFactory m_pFactory;
var transient int m_nFactorySpawnGroup;
var native const transient Pointer m_pBot;
var native const transient Pointer m_pSettings;
var native const transient Pointer m_pSkin;
var transient int m_iAssignedLane;
var init native map{VOID,VOID} m_SeePawnCache;
var transient float LastSeePawnCacheTime;
var transient float SeePawnClearTime;
var transient TgPawn m_pLastAttacker;
var transient TgAISquad m_Squad;
var transient float LastDamageTakenTime;
var transient Vector LastDamageTakenPosition;
var init native map{VOID,VOID} m_LoSCache;
var transient float LastLoSCacheTime;
var transient HavokNavigationHandle.EHavokNavigationMeshType m_eNavmeshType;
var Actor.EPhysics WalkingPhysics;
var float m_fAILevelUpSecs;
var float VisionDistance;
var float VisionDistanceBonus;
var bool bUsesObstacleAvoidance;
var transient bool bIsPaused;
var transient bool bIsAIFrozen;
var transient TgAIObstacleAvoidance ObstacleAvoidance;
var float ObstacleAvoidanceGridPointSize;
var float ObstacleAvoidanceGridExtents;
var transient Vector SpreadLocation;
var transient TgRepInfo_Player CachedPRI;
var init native map{VOID,VOID} DeviceTargetingCache;
var transient float LastCheckStuckTime;
var transient float CheckStuckTime;
var transient Vector LastCachedStuckPosition;
var transient float LastCheckFlungTime;
var transient float CheckFlungTime;
var transient Vector LastCachedFlungPosition;

// Export UTgAIController::execAtLocation(FFrame&, void* const)
native function bool AtLocation(Vector vLocation);

// Export UTgAIController::execIsDeviceReady(FFrame&, void* const)
native function bool IsDeviceReady(TgObject.TG_EQUIP_POINT DeviceSlot);

// Export UTgAIController::execAddThreat(FFrame&, void* const)
native function AddThreat(TgPawn attacker, float fAmount);

// Export UTgAIController::execGetTaskForceNumber(FFrame&, void* const)
native function int GetTaskForceNumber();

// Export UTgAIController::execSetTaskForceNumber(FFrame&, void* const)
native final function SetTaskForceNumber(int nTaskForce);

// Export UTgAIController::execLineCheckMovement(FFrame&, void* const)
native final function bool LineCheckMovement(Actor pTarget, optional Actor pSource);

// Export UTgAIController::execLineCheckVisibility(FFrame&, void* const)
native final function bool LineCheckVisibility(Actor pTarget, optional Actor pSource);

// Export UTgAIController::execLineCheck(FFrame&, void* const)
native final function bool LineCheck(Vector vLocation, Actor pTarget);

// Export UTgAIController::execLineCheckEx(FFrame&, void* const)
native final function bool LineCheckEx(Vector vLocation, Actor pTarget, Vector vTarget);

// Export UTgAIController::execLineCheckPassThrough(FFrame&, void* const)
native final function bool LineCheckPassThrough(Vector vLocation, Actor pTarget, Vector vTarget);

// Export UTgAIController::execCalculateLobIntersection(FFrame&, void* const)
native function Vector CalculateLobIntersection(Vector targetPos, Vector targetVel, Vector sourcePos, Vector sourceVel, float projVel);

// Export UTgAIController::execGetVisionDistance(FFrame&, void* const)
native function float GetVisionDistance();

// Export UTgAIController::execGetMaxDeviceRange(FFrame&, void* const)
native function float GetMaxDeviceRange();

// Export UTgAIController::execUpdateTargetingList(FFrame&, void* const)
native function UpdateTargetingList(array<ImpactInfo> ImpactList, byte EquipSlot);

// Export UTgAIController::execSquadTargetChanged(FFrame&, void* const)
native function SquadTargetChanged();

// Export UTgAIController::execSquadEvade(FFrame&, void* const)
native function SquadEvade();

// Export UTgAIController::execEvade(FFrame&, void* const)
native function Evade();

// Export UTgAIController::execSetSpreadLocation(FFrame&, void* const)
native function SetSpreadLocation(const out Vector SpreadLoc);

// Export UTgAIController::execClearSpreadLocation(FFrame&, void* const)
native function ClearSpreadLocation();

// Export UTgAIController::execCanSpreadOut(FFrame&, void* const)
native function bool CanSpreadOut();

event PostBeginPlay()
{
    super(Controller).PostBeginPlay();
    // End:0x6F
    if(bUsesObstacleAvoidance)
    {
        ObstacleAvoidance = new (self) Class'TgGame.TgAIObstacleAvoidance';
        // End:0x6F
        if(ObstacleAvoidance != none)
        {
            ObstacleAvoidance.Init(ObstacleAvoidanceGridPointSize, ObstacleAvoidanceGridExtents);
        }
    }
    //return;    
}

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super(Controller).Possess(inPawn, bVehicleTransition);
    // End:0x11D
    if(inPawn != none)
    {
        inPawn.WalkingPhysics = WalkingPhysics;
        inPawn.SetMovementPhysics();
        // End:0x11D
        if(((CachedPRI != none) && !CachedPRI.IsBot()) && TgInventoryManager(inPawn.InvManager) != none)
        {
            CachedPRI.UpdateBroadcastedItems(TgInventoryManager(inPawn.InvManager));
        }
    }
    //return;    
}

function InitPlayerReplicationInfo()
{
    super(Controller).InitPlayerReplicationInfo();
    CachedPRI = TgRepInfo_Player(PlayerReplicationInfo);
    //return;    
}

function CleanupPRI()
{
    CachedPRI = none;
    super(Controller).CleanupPRI();
    //return;    
}

function Destroyed()
{
    super.Destroyed();
    // End:0x45
    if(m_Squad != none)
    {
        m_Squad.RemoveMember(self, false);
        m_Squad = none;
    }
    //return;    
}

event Despawn()
{
    TgPawn(Pawn).Despawn();
    //return;    
}

event Suicide()
{
    Pawn.Suicide();
    //return;    
}

function PawnDied(Pawn P)
{
    local TgGame ActualGameInfo;

    // End:0x19
    if(P != Pawn)
    {
        return;
    }
    // End:0x65
    if(m_pFactory != none)
    {
        m_pFactory.BotDied(TgPawn(Pawn), self);
        m_pFactory = none;
    }
    // End:0xA0
    if(m_Squad != none)
    {
        m_Squad.RemoveMember(self, true);
        m_Squad = none;
    }
    ActualGameInfo = TgGame(WorldInfo.Game);
    // End:0x100
    if(ActualGameInfo != none)
    {
        ActualGameInfo.BotDied(self);
    }
    //return;    
}

function OnTriggerBots(TgSeqAct_TriggerBots Action)
{
    //return;    
}

function OnSetTaskforce(TgSeqAct_SetTaskforce Action)
{
    SetTaskForceNumber(Action.TaskForceNumber);
    //return;    
}

function SetActionlessPause(bool bOn)
{
    //return;    
}

function NotifyKilledBy(Controller Killer)
{
    //return;    
}

function NotifyTakeHit(Controller InstigatedBy, Vector HitLocation, int Damage, Class<DamageType> DamageType, Vector Momentum)
{
    local bool bIsEnemy;
    local TgPawn AttackedPawn;

    // End:0x1E
    if(InstigatedBy == none)
    {
        bIsEnemy = true;        
    }
    else
    {
        bIsEnemy = Pawn.IsEnemy(InstigatedBy.Pawn);
        AttackedPawn = TgPawn(InstigatedBy.Pawn);
    }
    // End:0x141
    if(bIsEnemy && AttackedPawn != none)
    {
        m_pLastAttacker = AttackedPawn;
        LastDamageTakenTime = WorldInfo.TimeSeconds;
        // End:0x12A
        if(Pawn != none)
        {
            LastDamageTakenPosition = Pawn.Location;            
        }
        else
        {
            LastDamageTakenPosition = vect(0.0000000, 0.0000000, 0.0000000);
        }
    }
    super(Controller).NotifyTakeHit(InstigatedBy, HitLocation, Damage, DamageType, Momentum);
    //return;    
}

function OnExitCombat()
{
    //return;    
}

function OnEnterCombat()
{
    //return;    
}

event DeviceOnStartBuildup(TgDevice Dev)
{
    //return;    
}

event DeviceOnStopBuildup(TgDevice Dev, bool WasInterrupted)
{
    //return;    
}

event DeviceOnStartFire(TgDevice Dev)
{
    //return;    
}

event DeviceOnFire(TgDevice Dev)
{
    //return;    
}

event ProjectileOnFire(TgProjectile Proj)
{
    //return;    
}

event DeviceOnHit(TgDevice Dev, const out ImpactInfo Impact)
{
    //return;    
}

event DeviceOnStopFire(TgDevice Dev, optional bool WasInterrupted = false)
{
    //return;    
}

event NotifyDamagedTarget(TgPawn TargetPawn)
{
    //return;    
}

function NotifyWeaponFired(Weapon W, byte FireMode)
{
    //return;    
}

defaultproperties
{
    m_iAssignedLane=-1
    SeePawnClearTime=0.2500000
    m_fAILevelUpSecs=180.0000000
    ObstacleAvoidanceGridPointSize=32.0000000
    ObstacleAvoidanceGridExtents=1024.0000000
    CheckStuckTime=1.5000000
    CheckFlungTime=0.5000000
    bIsPlayer=true
    NavigationHandleClass=Class'Engine.HavokNavigationHandle'
}