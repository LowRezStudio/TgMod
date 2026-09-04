class TgPawn_Turret extends TgPawn_Pet
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var repnotify bool r_bLockdownIsOn;
var repnotify bool r_bHasHealingStation;
var bool m_bFirstAidNuggetOverride;
var int m_nLockdownPostureID;
var TgDevice m_SpawningDevice;
var AkEvent m_TargetingNotificationAkEvent;
var Actor m_PrevTargetActor;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bHasHealingStation, r_bLockdownIsOn;
}

native function PostPawnSetupServer();  // Export UTgPawn_Turret::execPostPawnSetupServer(FFrame&, void* const)

native function DropHealthNuggetTeamOnly(int nTaskForce, optional Vector SpawnVelocity, optional float fHealOverride=-1.0000000, optional float fHoTOverride=-1.0000000);  // Export UTgPawn_Turret::execDropHealthNuggetTeamOnly(FFrame&, void* const)

native function ToggleLockdownMode(bool bSetActive);  // Export UTgPawn_Turret::execToggleLockdownMode(FFrame&, void* const)

native function ToggleLockdownFX();  // Export UTgPawn_Turret::execToggleLockdownFX(FFrame&, void* const)

native function ToggleHealingStationFX();  // Export UTgPawn_Turret::execToggleHealingStationFX(FFrame&, void* const)

native function SetTargetActor(Actor Target);  // Export UTgPawn_Turret::execSetTargetActor(FFrame&, void* const)

native function PlayTargetingSound();  // Export UTgPawn_Turret::execPlayTargetingSound(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated function PlayDeathAnimation() { }

simulated function RagdollPawn() { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

state Intro {}

defaultproperties
{}
