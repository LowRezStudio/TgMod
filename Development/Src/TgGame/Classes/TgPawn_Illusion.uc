class TgPawn_Illusion extends TgPawn_Ying
    native(ChampYing)
    config(Game)
    hidecategories(Navigation)
    implements(TgInterface_YingIllusion)
    dependson(TgObject);

const MAX_ILLUSION_TARGETS = 2;

const HEAL_BEAM_FX_ID = 7224;

enum EDecoyAIState {
    DAIS_Normal,  // 0
    DAIS_Shatter,  // 1
    DAIS_Rift,  // 2
};

var TgPawn_Illusion.EDecoyAIState m_eAIState;
var repnotify TgObject.INITIALIZEABLE_BOOL r_eLifelike;
var float m_fDamageScale;
var float m_fDamageAccumulator;
var float m_fDamageAccumulatorReductionRatePerSec;
var float m_fFlickerDamageMin;
var float m_fFlickerDamageMax;
var float m_fDamageAccumulatorCap;
var float m_fPrevFrameHealth;
var const float m_fTimedDestroyedFXDuration;
var const float m_fTimedDestroyedFXMeshHiddenTime;
var const float m_fEarlyShatterRecheckTime;
var const bool m_bCanShatterEarly;
var bool m_bUsingReplacementMIC;
var bool m_bSpringBloomFlag;
var bool c_BeamsCreated;
var repnotify float r_fShatterDelay;
var TgDevice m_CachedShatterDevice;
var array<MaterialInstanceConstant> m_replacementMICs;
var array<MaterialInstanceConstant> m_headReplacementMICs;
var array<MaterialInstanceConstant> m_weaponReplacementMICs;
var const MaterialInstanceConstant m_ShatterMaterialLocal;
var const MaterialInstanceConstant m_ShatterMaterialFriendly;
var const MaterialInstanceConstant m_ShatterMaterialEnemy;
var const MaterialInstanceConstant m_HitMaterialLocal;
var const MaterialInstanceConstant m_HitMaterialFriendly;
var const MaterialInstanceConstant m_HitMaterialEnemy;
var const MaterialInstanceConstant m_DestroyMaterialLocal;
var const MaterialInstanceConstant m_DestroyMaterialFriendly;
var const MaterialInstanceConstant m_DestroyMaterialEnemy;
var array< delegate<DestroyedEvent> > s_OnDeathDelegates;
var repnotify TgPawn_Character r_Targets[2];
var array<TgBeamHelper> c_Beams;
var repnotify int r_nBeamSpawnIterator;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_Targets, r_fShatterDelay;
}

delegate DestroyedEvent(Actor destroyedActor);

native function SetPetOwner(TgPawn petOwner);  // Export UTgPawn_Illusion::execSetPetOwner(FFrame&, void* const)

native function SpawnGuard();  // Export UTgPawn_Illusion::execSpawnGuard(FFrame&, void* const)

native function DropHealthNugget(optional Vector SpawnVelocity, optional float fHealOverride=-1.0000000, optional float fHoTOverride=-1.0000000);  // Export UTgPawn_Illusion::execDropHealthNugget(FFrame&, void* const)

native function DropHealthNuggetTeamOnly(int nTaskForce, optional Vector SpawnVelocity, optional float fHealOverride=-1.0000000, optional float fHoTOverride=-1.0000000);  // Export UTgPawn_Illusion::execDropHealthNuggetTeamOnly(FFrame&, void* const)

native function InitializeInhandWeapon(int DeviceID);  // Export UTgPawn_Illusion::execInitializeInhandWeapon(FFrame&, void* const)

native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);  // Export UTgPawn_Illusion::execDeviceAdjustDamage(FFrame&, void* const)

native function DeviceOnHit(TgDevice Dev, const out ImpactInfo Impact);  // Export UTgPawn_Illusion::execDeviceOnHit(FFrame&, void* const)

native function PostPawnSetupServer();  // Export UTgPawn_Illusion::execPostPawnSetupServer(FFrame&, void* const)

native function ReplaceMaterial(MaterialInstanceConstant materialToUse, optional float ParamValue=0.0000000);  // Export UTgPawn_Illusion::execReplaceMaterial(FFrame&, void* const)

native function ClearReplacementMaterial();  // Export UTgPawn_Illusion::execClearReplacementMaterial(FFrame&, void* const)

native function ReplaceWithShatterMaterial();  // Export UTgPawn_Illusion::execReplaceWithShatterMaterial(FFrame&, void* const)

native function ReplaceWithHitOverlayMaterial();  // Export UTgPawn_Illusion::execReplaceWithHitOverlayMaterial(FFrame&, void* const)

native function ReplaceWithDestroyedMaterial();  // Export UTgPawn_Illusion::execReplaceWithDestroyedMaterial(FFrame&, void* const)

native function CheckEarlyShatter();  // Export UTgPawn_Illusion::execCheckEarlyShatter(FFrame&, void* const)

native function bool IsStatTrackable();  // Export UTgPawn_Illusion::execIsStatTrackable(FFrame&, void* const)

native function bool ShouldPawnMeshBeHiddenThisTick();  // Export UTgPawn_Illusion::execShouldPawnMeshBeHiddenThisTick(FFrame&, void* const)

native function bool ShouldInHandDeviceBeHiddenThisTick();  // Export UTgPawn_Illusion::execShouldInHandDeviceBeHiddenThisTick(FFrame&, void* const)

native function bool IsNonCombat();  // Export UTgPawn_Illusion::execIsNonCombat(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated event UpdateWeaponMesh() { }

event bool ShouldScoreKill() { }

simulated function PlayInitialSpawnFX() { }

simulated event ConsiderCreateBeams() { }

simulated event UpdateBeamAttachments() { }

simulated function CreateBeams() { }

simulated function int GetNumNeededBeams() { }

simulated function PlayDyingEffects() { }

function bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

event CacheShatterDevice() { }

simulated function TimedDestroyedFX() { }

simulated function TriggerShatter(float fDelay) { }

function ApplyStartShatterEffects() { }

event Suicide() { }

event Shatter() { }

function ClearDimensionalLink() { }

function AddOnDestroyDelegate(delegate<DestroyedEvent> delDestroy) { }

native function Actor GetActorFromInterface();  // Export UTgPawn_Illusion::execGetActorFromInterface(FFrame&, void* const)

native function bool IsNotDestroyed();  // Export UTgPawn_Illusion::execIsNotDestroyed(FFrame&, void* const)

simulated function PlayDimensionalLinkFX() { }

simulated function bool AllowRagdoll() { }

function TgPawn_Ying GetOwningYing() { }

state Intro {}

defaultproperties
{}
