class TgPawn_Lex extends TgPawn_Character
    native(ChampLex)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

const MAX_THE_LAW_TARGETS = 5;

enum ETheLawTargetState {
    ETLTS_WontExecute,  // 0
    ETLTS_WillExecute,  // 1
    ETLTS_Firing,  // 2
};

var TgDevice_Vengeance_Lex m_VengeanceDevice;
var TgDevice_CombatSlide m_CombatSlideDevice;
var TgDevice_InPursuit m_InPursuitDevice;
var TgWeaponMeshActor_LexInhand m_WeaponMeshActorLexInhand;
var init array<init TgPawn_Character> m_TargetList;
var TgPawn m_Target;
var float m_MaxSlideCameraAngle;
var int m_PrevCameraYaw;
var bool c_bUltFiring;
var bool c_bPursuitFiring;
var bool m_bFireLeftWeapon;
var repnotify TgPawn_Character r_Targets[5];
var repnotify TgPawn_Lex.ETheLawTargetState r_TargetStates[5];
var repnotify int r_nInhandAmmoRemaining;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_TargetStates, r_Targets;
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_nInhandAmmoRemaining;
}

native function bool IsFiringAtMarkShotMark();  // Export UTgPawn_Lex::execIsFiringAtMarkShotMark(FFrame&, void* const)

native function GlobalOnPlayerDied(TgPawn_Character Player);  // Export UTgPawn_Lex::execGlobalOnPlayerDied(FFrame&, void* const)

native function TgDevice_Vengeance_Lex GetCachedVengeanceDevice();  // Export UTgPawn_Lex::execGetCachedVengeanceDevice(FFrame&, void* const)

native function float GetVengeanceLifesteal(TgPawn Target);  // Export UTgPawn_Lex::execGetVengeanceLifesteal(FFrame&, void* const)

native function Actor GetTargetActor();  // Export UTgPawn_Lex::execGetTargetActor(FFrame&, void* const)

native function bool GetTurnRotatorOverride(out int nYawOffset);  // Export UTgPawn_Lex::execGetTurnRotatorOverride(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

simulated event PostTimeLapse(bool bPlayOfTheGame) { }

simulated function OnRespawn() { }

simulated function InterceptInputDeltaRotation(out Rotator rDeltaRotation) { }

simulated function OnAmmoChange() { }

simulated function SetDualFireParity(bool bLeftFire) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated event ManageBeams() { }

defaultproperties
{}
