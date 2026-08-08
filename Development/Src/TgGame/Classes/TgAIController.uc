class TgAIController extends GameAIController
    native(AI)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

const AI_TEAM_PASSTHRU_DISTANCE = 100000;

const AI_DEFAULT_DISTANCE_OFFSET = 50;

const SMITE_MIDPOINT_ROUTE_THRESHOLD = 176.0f;

const SMITE_MINION_INTRASQUAD_SPAWN_DELAY = 0.5f;

struct ThreatStruct {
    var Actor Threatener;
    var float fThreat;
    structdefaultproperties {}
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
var transient float LastSeePawnCacheTime;
var transient float SeePawnClearTime;
var transient TgPawn m_pLastAttacker;
var transient TgAISquad m_Squad;
var transient float LastDamageTakenTime;
var transient Vector LastDamageTakenPosition;
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
var transient float LastCheckStuckTime;
var transient float CheckStuckTime;
var transient Vector LastCachedStuckPosition;
var transient float LastCheckFlungTime;
var transient float CheckFlungTime;
var transient Vector LastCachedFlungPosition;

native function bool AtLocation(Vector vLocation);  // Export UTgAIController::execAtLocation(FFrame&, void* const)

native function bool IsDeviceReady(TgObject.TG_EQUIP_POINT DeviceSlot);  // Export UTgAIController::execIsDeviceReady(FFrame&, void* const)

native function AddThreat(TgPawn attacker, float fAmount);  // Export UTgAIController::execAddThreat(FFrame&, void* const)

native function int GetTaskForceNumber();  // Export UTgAIController::execGetTaskForceNumber(FFrame&, void* const)

native function SetTaskForceNumber(int nTaskForce);  // Export UTgAIController::execSetTaskForceNumber(FFrame&, void* const)

native function bool LineCheckMovement(Actor pTarget, optional Actor pSource);  // Export UTgAIController::execLineCheckMovement(FFrame&, void* const)

native function bool LineCheckVisibility(Actor pTarget, optional Actor pSource);  // Export UTgAIController::execLineCheckVisibility(FFrame&, void* const)

native function bool LineCheck(Vector vLocation, Actor pTarget);  // Export UTgAIController::execLineCheck(FFrame&, void* const)

native function bool LineCheckEx(Vector vLocation, Actor pTarget, Vector vTarget);  // Export UTgAIController::execLineCheckEx(FFrame&, void* const)

native function bool LineCheckPassThrough(Vector vLocation, Actor pTarget, Vector vTarget);  // Export UTgAIController::execLineCheckPassThrough(FFrame&, void* const)

native function Vector CalculateLobIntersection(Vector targetPos, Vector targetVel, Vector sourcePos, Vector sourceVel, float projVel);  // Export UTgAIController::execCalculateLobIntersection(FFrame&, void* const)

native function float GetVisionDistance();  // Export UTgAIController::execGetVisionDistance(FFrame&, void* const)

native function float GetMaxDeviceRange();  // Export UTgAIController::execGetMaxDeviceRange(FFrame&, void* const)

native function UpdateTargetingList(array<ImpactInfo> ImpactList, byte EquipSlot);  // Export UTgAIController::execUpdateTargetingList(FFrame&, void* const)

native function SquadTargetChanged();  // Export UTgAIController::execSquadTargetChanged(FFrame&, void* const)

native function SquadEvade();  // Export UTgAIController::execSquadEvade(FFrame&, void* const)

native function Evade();  // Export UTgAIController::execEvade(FFrame&, void* const)

native function SetSpreadLocation(const out Vector SpreadLoc);  // Export UTgAIController::execSetSpreadLocation(FFrame&, void* const)

native function ClearSpreadLocation();  // Export UTgAIController::execClearSpreadLocation(FFrame&, void* const)

native function bool CanSpreadOut();  // Export UTgAIController::execCanSpreadOut(FFrame&, void* const)

event PostBeginPlay() { }

event Possess(Pawn inPawn, bool bVehicleTransition) { }

function InitPlayerReplicationInfo() { }

function CleanupPRI() { }

function Destroyed() { }

event Despawn() { }

event Suicide() { }

function PawnDied(Pawn P) { }

function OnTriggerBots(TgSeqAct_TriggerBots Action) { }

function OnSetTaskforce(TgSeqAct_SetTaskforce Action) { }

function SetActionlessPause(bool bOn) { }

function NotifyKilledBy(Controller Killer) { }

function NotifyTakeHit(Controller InstigatedBy, vector HitLocation, int Damage, class<DamageType> damageType, vector Momentum) { }

function OnExitCombat() { }

function OnEnterCombat() { }

event DeviceOnStartBuildup(TgDevice Dev) { }

event DeviceOnStopBuildup(TgDevice Dev, bool WasInterrupted) { }

event DeviceOnStartFire(TgDevice Dev) { }

event DeviceOnFire(TgDevice Dev) { }

event ProjectileOnFire(TgProjectile Proj) { }

event DeviceOnHit(TgDevice Dev, const out ImpactInfo Impact) { }

event DeviceOnStopFire(TgDevice Dev, optional bool WasInterrupted=false) { }

event NotifyDamagedTarget(TgPawn TargetPawn) { }

function NotifyWeaponFired(Weapon W, byte FireMode) { }

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
    NavigationHandleClass=Class'HavokNavigationHandle'
}
