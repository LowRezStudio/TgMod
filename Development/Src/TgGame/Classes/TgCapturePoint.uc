class TgCapturePoint extends Actor
    native(Game)
    placeable
    hidecategories(Navigation)
    config(Engine);

var TgCollisionProxy_Cylinder s_CollisionProxy;
var TgRepInfo_CapturePoint r_RepInfo;
var () const float m_fCollisionProxyRadius;
var () const float m_fCollisionProxyHeight;
var const float m_fBaseTransitionSpeed;
var const float m_fTransitionSpeedBuff;
var transient float m_fCurrentTransitionSpeed;
var transient TgSeqEvent_ControlPointOwnershipChange c_OwnershipChangedKismetNode;
var () TgBotFactory_PointCapture s_BotSpawners[2];
var transient TgBotFactory_PointCapture m_CurrentBotSpawners[2];
var () TgBotFactory_PointCapture s_NeutralBotSpawner;
var () const int m_CapturePointIndex;
var () const float s_fReplenishBotTime;
var private transient float s_fRemainingReplenishBotTime;
var float s_fFriendlyReplenishBuffPct;
var float m_fRegenUpdateTimer;
var const float m_fOwnedManaRegen;
var const float m_fOwnedHealthRegen;
var transient TgGame_Mission s_GameInfo;
var transient int m_nTF1Count;
var transient int m_nTF2Count;
var transient float m_fLastEnemyKillVoxTimestamp;
var () int m_nLaneNumber;
var () export editinline SpriteComponent m_WorldIconSprite;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_RepInfo;
}

native function AlertPointChanged();  // Export UTgCapturePoint::execAlertPointChanged(FFrame&, void* const)

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

function SpawnNeutralBot() { }

simulated event PreBeginPlay() { }

simulated event PostBeginPlay() { }

simulated event CollisionProxyOnTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event CollisionProxyOnUnTouch(Actor Other) { }

function NearbyPawnsUpdated() { }

event OnPointCaptureOwnershipChanged(int NewTaskForceOwner, int PreviousTaskForceOwner) { }

event OnPointReclaimed() { }

event OnBotDied(int DeadBotTaskForce) { }

event SpawnBotsForCurrentTaskForce() { }

simulated function int GetCapturePointIndex() { }

simulated function OnTaskForceControlChanged(int NewTaskForce) { }

simulated event Destroyed() { }

function OnNearbyEnemyPlayerDied(TgPawn DeadPawn) { }

simulated function OnToggle(SeqAct_Toggle Action) { }

simulated function UpdateLockEffects() { }

simulated function OnGetTaskForceNumber(TgSeqAct_GetTaskForceNumber Action) { }

defaultproperties
{}
