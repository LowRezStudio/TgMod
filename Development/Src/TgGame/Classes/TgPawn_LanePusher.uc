class TgPawn_LanePusher extends TgPawn_LanePusherBase
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

const TG_PROXIMITY_SPEED_MOD_RADIUS = 20.0f;

const TG_PROXIMITY_SPEED_MAGNITUDE = 20.0f;

const TG_PROXIMITY_SPEED_STACK_MAX = 5;

enum EDestroyedAnimStages {
    EngineDestruction_FullHealth_Idle,  // 0
    EngineDestruction_FirstDestruction,  // 1
    EngineDestruction_SecondDestruction,  // 2
};

var private bool m_bInIntroduction;
var bool r_bIsInsideBase;
var bool m_bHarvestTexturesForFadeMIC;
var bool m_bBroadcastDeath;
var TgPawn_LanePusher.EDestroyedAnimStages c_eDestroyedAnimStage;
var transient TgSpecialFx c_BeamFX;
var () float m_fBaseWheelSpeed;
var const int m_nMaxLevel;
var int m_nFriendlyFadeMaterialFXId;
var int m_nEnemyFadeMaterialFXId;
var array<MaterialInstanceConstant> m_FadeMICs;
var float m_fDamageScaleWhileTraveling;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bIsInsideBase;
}

native function SetInitialLevel();  // Export UTgPawn_LanePusher::execSetInitialLevel(FFrame&, void* const)

native function OnPawnDied();  // Export UTgPawn_LanePusher::execOnPawnDied(FFrame&, void* const)

native function DropHealthNugget(optional Vector SpawnVelocity, optional float fHealOverride=-1.0000000, optional float fHoTOverride=-1.0000000);  // Export UTgPawn_LanePusher::execDropHealthNugget(FFrame&, void* const)

native function DropHealthNuggetTeamOnly(int nTaskForce, optional Vector SpawnVelocity, optional float fHealOverride=-1.0000000, optional float fHoTOverride=-1.0000000);  // Export UTgPawn_LanePusher::execDropHealthNuggetTeamOnly(FFrame&, void* const)

native function PawnOnPreDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);  // Export UTgPawn_LanePusher::execPawnOnPreDamageMitigation(FFrame&, void* const)

native function ReapplyLevelEffectGroups(optional int nPrevLevel=0, optional int nCurrentLevel=0, optional bool bPreserveParams=false);  // Export UTgPawn_LanePusher::execReapplyLevelEffectGroups(FFrame&, void* const)

native function CalcDistanceFadeValue(float fDeltaTime);  // Export UTgPawn_LanePusher::execCalcDistanceFadeValue(FFrame&, void* const)

native function SetSpline(TgSplineActor NewSpline, optional bool bSnapToStart);  // Export UTgPawn_LanePusher::execSetSpline(FFrame&, void* const)

native function PostPawnSetupServer();  // Export UTgPawn_LanePusher::execPostPawnSetupServer(FFrame&, void* const)

native function bool IsImmuneToDamage();  // Export UTgPawn_LanePusher::execIsImmuneToDamage(FFrame&, void* const)

simulated function PostBeginPlay() { }

native function InitializeFadeInMaterial();  // Export UTgPawn_LanePusher::execInitializeFadeInMaterial(FFrame&, void* const)

native function UpdateMaterialFade();  // Export UTgPawn_LanePusher::execUpdateMaterialFade(FFrame&, void* const)

simulated function PlayInitialSpawnFX() { }

simulated function IntroTimer() { }

event ModifyHealthProp(int nDamage) { }

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp) { }

simulated function Tick(float DeltaSeconds) { }

simulated event ReceivedPropValues() { }

simulated function PlayDeathAnimation() { }

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

event int GetHPScalingValue() { }

event int GetPowerScalingValue() { }

simulated function OnDeviceFormStartFire(int nEquipSlot, float FireDuration, int nFireMode, optional int nAmmoRemaining) { }

simulated event Vector GetWeaponStartTraceLocation(optional Weapon CurrentWeapon) { }

simulated event Destroyed() { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

function ClearFromGRI() { }

defaultproperties
{}
