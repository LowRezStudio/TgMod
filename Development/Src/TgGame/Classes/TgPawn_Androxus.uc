class TgPawn_Androxus extends TgPawn_Character
    native(ChampAndroxus)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

const TGPAWN_ANDROXUS_SLOWFALL_FX_ID = 6824;

var bool m_bIsInSlowFall;
var bool m_bForceAccursedArmDevice;
var repnotify bool r_bAccursedArmFiring;
var bool m_bUltimateReadyDisplayGroupOn;
var float m_fAccursedArmSpeedModifier;
var TgDevice m_AccursedArmInHand;
var float m_fDefianceAirControl;
var float m_fAirHangGravityModifier;
var float m_fJumpHoldMaxFallSpeed;
var TgDevice_NetherStep m_NetherStepDevice;
var float r_fFeatherweightAirControl;
var float r_fLiftOffDrift;
var int m_nAccursedArmActiveFX;
var array<TgAnimNodeBlendBySlowFall> m_SlowFallAnimNodes;
var repnotify int r_nDesiredSlowFallAnimChild;
var TgSpecialFx m_SlowFallFX;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fFeatherweightAirControl, r_fLiftOffDrift;
}

native function bool InitializeSlowFallFX();  // Export UTgPawn_Androxus::execInitializeSlowFallFX(FFrame&, void* const)

native function float GetAirControl();  // Export UTgPawn_Androxus::execGetAirControl(FFrame&, void* const)

native function float GetGravityZ();  // Export UTgPawn_Androxus::execGetGravityZ(FFrame&, void* const)

native function bool ShouldForceHideOverlaysWeapon();  // Export UTgPawn_Androxus::execShouldForceHideOverlaysWeapon(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated event bool PostPawnSetup() { }

simulated function CacheMultiMeshAnimNodeReferences(TgSkeletalMeshComponent smcomp) { }

simulated event SetSlowFallAnimationIndex(int nIndex) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated function ApplyLiftOff() { }

function ToggleAccursedArm(bool bEnabled, optional float SpeedModifier=1.0000000) { }

simulated function PlayAccursedArmEffects(bool bEnabled) { }

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy) { }

simulated event PlaySlowFallFx() { }

simulated event StopSlowFallFx() { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

simulated function OnRespawn() { }

simulated event Stun(bool bStunController, optional Controller.EStunType eType) { }

defaultproperties
{}
