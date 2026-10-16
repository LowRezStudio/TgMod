class TgPawn_LanePusherBase extends TgPawn_Biped
    abstract
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

const TGPM_REMEMBER_PLAYER_ATTACKED_TIME = 4;

struct ServerSplineSync {
    var TgSplineActor Spline;
    var float SplineDist;
    var bool bMoving;
    structdefaultproperties {}
};

var float s_fSpeedMultiplierToCatchUpToSquad;
var TgPawn_Character s_PlayerAttacker;
var float s_fMaxRelevancyDistanceSquared;
var const TgSplineActor r_StartSpline;
var repnotify const ServerSplineSync r_ServerSync;
var const bool m_bMoving;
var bool c_bServerSync;
var const bool m_bDoNotScaleCollisionBoxWithDatabase;
var const bool m_bApplySplinePitchToActor;
var const bool c_bApplySplinePitchToMesh;
var const bool m_bFullStopWhenNoDesiredSpeed;
var const bool s_bStopBackpeddlingAtCheckpoints;
var bool m_bAllowBackpeddling;
var bool m_bDestroyed;
var bool r_bAsleep;
var private TgSplineActor m_Spline;
var export editinline StaticMeshComponent m_CollisionBox;
var float m_fSplineDist;
var float c_fSplineDistCorrection;
var float c_fClientSideMovementFudgeFactor;
var float c_fClientCorrectionTolerance;
var float c_fClientCorrectionRate;
var float m_fGroundSpeedScaleLastTick;
var float r_fTrackGroundSpeed;
var float m_fAcceleration;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_ServerSync, r_StartSpline, r_bAsleep, r_fTrackGroundSpeed;
}

native function SetInitialLevel();  // Export UTgPawn_LanePusherBase::execSetInitialLevel(FFrame&, void* const)

native function PostPawnSetupServer();  // Export UTgPawn_LanePusherBase::execPostPawnSetupServer(FFrame&, void* const)

native function SetTargetActor(Actor Target);  // Export UTgPawn_LanePusherBase::execSetTargetActor(FFrame&, void* const)

native function SendPing();  // Export UTgPawn_LanePusherBase::execSendPing(FFrame&, void* const)

native function SetSpline(TgSplineActor NewSpline, optional bool bSnapToStart);  // Export UTgPawn_LanePusherBase::execSetSpline(FFrame&, void* const)

native function UpdateMoving();  // Export UTgPawn_LanePusherBase::execUpdateMoving(FFrame&, void* const)

native function UpdateServerSync();  // Export UTgPawn_LanePusherBase::execUpdateServerSync(FFrame&, void* const)

native function ReceiveServerSync();  // Export UTgPawn_LanePusherBase::execReceiveServerSync(FFrame&, void* const)

native function SnapToServerSync();  // Export UTgPawn_LanePusherBase::execSnapToServerSync(FFrame&, void* const)

native function bool IsImmuneToDamage();  // Export UTgPawn_LanePusherBase::execIsImmuneToDamage(FFrame&, void* const)

native function bool IsImmuneToHealing();  // Export UTgPawn_LanePusherBase::execIsImmuneToHealing(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

event Despawn() { }

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

function RememberPlayerAttackerExpired() { }

simulated event TargetActorUpdated() { }

simulated function ToggleAggroAlert(bool bOn) { }

simulated function PlayDeathAnimation() { }

simulated event ClientUpdateMoving() { }

simulated event PropertySet(int nPropertyId, float fPreviousValue, float fNewValue) { }

function SetMovementPhysics() { }

simulated function Tick(float DeltaTime) { }

simulated function DestroyIt(optional bool bSkipFx) { }

function float GetDistanceToEndOfSpline() { }

state Dying {}

defaultproperties
{}
