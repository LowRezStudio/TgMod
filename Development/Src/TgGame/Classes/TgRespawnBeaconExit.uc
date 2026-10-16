class TgRespawnBeaconExit extends TgRespawnBeaconBase
    native
    hidecategories(Navigation,SkeletalMeshActor)
    config(Engine);

enum ERespawnBeaconActiveState {
    RBAS_Inactive,  // 0
    RBAS_Carried,  // 1
    RBAS_Deploying,  // 2
    RBAS_Active,  // 3
};

var (BeaconExit) bool m_bChangesYaw;
var bool c_bHiddenToLocalPlayer;
var (BeaconExit) float m_fPercHealthPerSec;
var (BeaconExit) float m_fHealthRegenLockoutTime;
var int r_nRespawnTime;
var float m_fTimeUntilHealTick;
var Rotator m_rInitialRot;
var Vector m_vInitialPos;
var TgRepInfo_Player r_CarrierRepInfo;
var Actor m_SpawnPointOverride;
var TgVisibilityVolume r_CurrentVisibilityVolumes[2];
var TgRespawnBeaconExit.ERespawnBeaconActiveState c_LocalActiveState;
var repnotify TgRespawnBeaconExit.ERespawnBeaconActiveState r_ActiveState;
var repnotify byte r_nPlayTakeHit;
var transient array<TgRespawnBeaconEntrance> m_Entrances;
var transient array< delegate<BeaconStateChanged> > m_CarriedDel;
var transient array< delegate<BeaconStateChanged> > m_DestroyedDel;
var transient array< delegate<BeaconStateChanged> > m_DeployingDel;
var transient array< delegate<BeaconStateChanged> > m_ActiveDel;
var Vector r_nDeathLocation;
var Controller m_LastDamager;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_ActiveState, r_CarrierRepInfo, r_CurrentVisibilityVolumes, r_nDeathLocation, r_nPlayTakeHit, r_nRespawnTime;
}

simulated delegate BeaconStateChanged();

native function OnBeaconReset();  // Export UTgRespawnBeaconExit::execOnBeaconReset(FFrame&, void* const)

native function bool HasAnyEnabledEntrances();  // Export UTgRespawnBeaconExit::execHasAnyEnabledEntrances(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

function OnBeaconExitSetRespawn(TgSeqAct_BeaconExitSetRespawn inAction) { }

function AddVisibilityVolume(TgVisibilityVolume Vol) { }

function RemoveVisibilityVolume(TgVisibilityVolume Vol) { }

simulated event PostBeginPlay() { }

simulated event bool AcceptTeleport(TgPawn Incoming, TgRespawnBeaconEntrance Source) { }

function SetBeaconCollision(bool IsActive) { }

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event UnTouch(Actor Other) { }

simulated function bool IsValidTarget(TgPawn TgP) { }

simulated function bool CanBePickedUp(TgPawn TgP) { }

function bool Pickup(TgPawn TgP) { }

function Place(TgPawn TgP) { }

function PlaceFromDeploy(TgDeploy_RespawnBeacon TgD) { }

function PlaceAtLocation(Vector NewLocation, Rotator NewRotation) { }

function Deployed() { }

simulated function DestroyIt(optional bool bSkipFx) { }

function float GetDesiredLifeSpan() { }

function BeginRespawnTimer() { }

function UpdateRespawnTime() { }

function Respawn() { }

simulated function FXCarried() { }

simulated function FXDestroyed() { }

simulated function FXDeploying() { }

simulated function FXActive() { }

simulated function FXEndDeploying() { }

simulated function FXEndActive() { }

simulated function PlayTakeHitEffect() { }

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

simulated function SetActiveState(TgRespawnBeaconExit.ERespawnBeaconActiveState NewState) { }

simulated function ClientFlashTeleportFX() { }

simulated function SetPendingTeleportFx(bool bIsPendingTeleport) { }

defaultproperties
{}
