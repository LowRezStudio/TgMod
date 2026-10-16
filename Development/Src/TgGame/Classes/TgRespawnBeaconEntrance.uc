class TgRespawnBeaconEntrance extends TgRespawnBeaconBase
    native
    hidecategories(Navigation,SkeletalMeshActor)
    config(Engine);

enum ERespawnBeaconChargingState {
    RBCS_Inactive,  // 0
    RBCS_Waiting,  // 1
    RBCS_BuildUp,  // 2
    RBCS_Active,  // 3
};

struct PendingTeleportInfo {
    var Actor PendingActor;
    var float TouchTimestamp;
    var bool HasPlayedPreTeleport;
    structdefaultproperties {}
};

var (BeaconEntrance) TgRespawnBeaconExit ExitBeacon;
var (BeaconEntrance) bool r_bEntranceActive;
var repnotify byte r_nPendingTeleport;
var transient TgRespawnBeaconEntrance.ERespawnBeaconChargingState c_LocalChargingState;
var repnotify TgRespawnBeaconEntrance.ERespawnBeaconChargingState r_ChargingState;
var export editinline TgParticleSystemComponent m_TeleportPSC;
var float m_fChargeDelay;
var float m_fTeleportDelay;
var float m_fPreTeleportFXTime;
var float s_fChargeStateTimeStamp;
var array<PendingTeleportInfo> s_PendingTeleports;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_ChargingState, r_bEntranceActive, r_nPendingTeleport;
}

simulated event ReplicatedEvent(name VarName) { }

simulated event PostBeginPlay() { }

simulated function ConnectToExit() { }

function OnBeaconEntranceSetActive(TgSeqAct_BeaconEntranceSetActive inAction) { }

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

function bool VerifyCanTeleport(TgPawn Other) { }

function bool AddPendingTeleport(Actor Other) { }

function bool RemovePendingTeleport(Actor Other) { }

native function Actor GetNextPendingTeleport();  // Export UTgRespawnBeaconEntrance::execGetNextPendingTeleport(FFrame&, void* const)

simulated event PostTouch(Actor Other) { }

simulated event UnTouch(Actor Other) { }

event FlashTeleportFx(TgPawn TgP) { }

simulated function ClientFlashTeleportFX() { }

simulated function ChargingStateChangedFX() { }

event SetChargingState(TgRespawnBeaconEntrance.ERespawnBeaconChargingState chargeState) { }

function BeaconSetActive() { }

function EnableBeaconSetupFX() { }

function DisableBeaconFX() { }

simulated event bool CanApplyEffects() { }

defaultproperties
{}
