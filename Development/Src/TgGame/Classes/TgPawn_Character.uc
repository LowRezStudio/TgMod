class TgPawn_Character extends TgPawn_Biped
    native(Pawns)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject, TgPawn);

const TGC_REMEMBER_PLAYER_ATTACKED_TIME = 2;

const TGC_KILL_COMBO_MAX_TIME = 5;

const TG_MAX_DISTANCE_FOR_SHARED_VISIBILITY_SQ = 2560000;

const TG_HIT_INDICATOR_POINTS_TO_INSTIGATOR = 1;

const TG_MAX_PLAYER_STUCK_BOMBS = 6;

const TG_ROLE_DAMAGE = 10601;

const TG_ROLE_FLANKER = 10541;

const TG_ROLE_FRONTLINE = 10542;

const TG_ROLE_SUPPORT = 15060;

enum EUITargeters {
    TARGETER_KINESSA,  // 0
    TARGETER_TYRA,  // 1
    TARGETER_TORVALD,  // 2
    TARGETER_ORACLE,  // 3
    TARGETER_ASTRO,  // 4
    TARGETER_YING,  // 5
};

struct WeaponDOF {
    var bool IsActive;
    var DOFAndBloomEffect.EDOFType DOFType;
    var float Falloff;
    var float BlurKernelSize;
    var DOFEffect.EFocusType FocusType;
    var float FocusInnerRadius;
    var float FocusDistance;
    var float MaxNearBlurAmount;
    var float MinBlurAmount;
    var float MaxFarBlurAmount;
    structdefaultproperties {}
};

struct ForceFaceTargetActor {
    var Actor TargetActor;
    var float HeightOffset;
    var Quat InitialQuat;
    var float InterpTime;
    var float StartTime;
    var float Duration;
    var Object ForceRotationInstigator;
    structdefaultproperties {}
};

struct TeleportParams {
    var Vector vTargetLocation;
    var Rotator rTargetRotation;
    var bool bPlayFx;
    var bool bDoBackTrace;
    var Vector vBackTraceDir;
    var float fBackTraceIncrement;
    var float fBackTraceMaxDist;
    var bool bLookForGround;
    var float fGroundSearchHeight;
    var float fGroundSearchRayRadius;
    var bool bCheckLineOfSight;
    var float fMovementCorrectionDisableTime;
    var int nTeleportEnterState;
    var int nTeleportExitState;
    var bool bFakeTeleport;
    structdefaultproperties {}
};

var bool c_bUpdatePlayerStatUI;
var bool m_bInHandFiring;
var bool r_bNearCapturePoint;
var bool r_bNearPayload;
var bool r_bNearSiegeMonster;
var bool r_bVisibleToEnemies;
var bool s_bAmmoReloadCheat;
var bool s_bAutomountProtection;
var bool m_bAttemptingAirJump;
var bool m_bDelayingStopSpecialJumpFx;
var bool m_bPendingBounce;
var bool s_bInitiatingJoin;
var const bool s_bReplicateInhandAmmo;
var transient float m_fLastCapturePointReclaimedTime;
var float m_fMinReclaimPointTime;
var transient float m_fInHandStartFireTime;
var transient float m_fInHandStopFireTime;
var float m_fWallDamagePercent;
var float m_fSiegeDamagePercent;
var repnotify float r_fZoomAmt;
var repnotify byte r_nCriticalHit;
var () float m_fMountZoomOverride;
var TgDeploy_BombKingStickyBomb r_StuckBombs[6];
var int m_nCharacterRole;
var () export editinline TgCustomCharacterComponent m_CustomCharacterComponent;
var () export editinline PrimitiveComponent m_MountedCollisionComponent;
var () export editinline PrimitiveComponent m_MeshEncompassingCollisionComponent;
var array<TgDeviceInterface_MoveSpeedMultiplier> m_CachedMoveSpeedModDevices;
var int m_nAirJumps;
var (Blades) float m_fAirJumpZSpeed;
var Vector m_vBounceVelocity;
var TgPawn_Character m_JoinTargetLocal;
var TgPawn_Character m_JoinSourceLocal;
var repnotify TgPawn_Character r_JoinTarget;
var Vector r_vJoinSourceLocation;
var Vector r_vJoinTargetLocation;
var float r_fJoinTweenDuration;
var repnotify TgPawn_Character r_JoinSource;
var array<ForceFaceTargetActor> m_ForceFaceActors;
var repnotify int r_nInHandCurrentAmmo;
var repnotify int r_nInHandMaxAmmo;

replication {
    if(bNetDirty) r_JoinSource, r_JoinTarget, r_bNearCapturePoint, r_bNearPayload, r_bVisibleToEnemies, r_fJoinTweenDuration, r_nInHandCurrentAmmo, r_nInHandMaxAmmo, r_vJoinSourceLocation, r_vJoinTargetLocation;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_StuckBombs, r_nCriticalHit;
}

native function bool ApplyPawnSetup();  // Export UTgPawn_Character::execApplyPawnSetup(FFrame&, void* const)

native function SetSpawnMana();  // Export UTgPawn_Character::execSetSpawnMana(FFrame&, void* const)

native function LoadDisconnectedPlayerState();  // Export UTgPawn_Character::execLoadDisconnectedPlayerState(FFrame&, void* const)

native function OnHealingWell(bool bTouched);  // Export UTgPawn_Character::execOnHealingWell(FFrame&, void* const)

native function ReapplyLoadoutEffects(optional bool bKeepFiringMount);  // Export UTgPawn_Character::execReapplyLoadoutEffects(FFrame&, void* const)

native function bool ApplyItemEffects(TgInventoryObject pItem, bool bRemove);  // Export UTgPawn_Character::execApplyItemEffects(FFrame&, void* const)

native function bool ApplyMonsterRewardEffects(TgInventoryObject pItem, bool bRemove);  // Export UTgPawn_Character::execApplyMonsterRewardEffects(FFrame&, void* const)

native function OnPawnDied();  // Export UTgPawn_Character::execOnPawnDied(FFrame&, void* const)

native function SpawnGuard();  // Export UTgPawn_Character::execSpawnGuard(FFrame&, void* const)

native function PlayMatchStartCue();  // Export UTgPawn_Character::execPlayMatchStartCue(FFrame&, void* const)

native function GlobalOnPlayerDied(TgPawn_Character Player);  // Export UTgPawn_Character::execGlobalOnPlayerDied(FFrame&, void* const)

native function PawnOnDamaged(out OnDamagedParams Params);  // Export UTgPawn_Character::execPawnOnDamaged(FFrame&, void* const)

native function PawnOnHealed(out OnHealedParams Params);  // Export UTgPawn_Character::execPawnOnHealed(FFrame&, void* const)

native function PawnOnKilled(Actor pVictim);  // Export UTgPawn_Character::execPawnOnKilled(FFrame&, void* const)

native function PawnOnAssisted(Actor pVictim);  // Export UTgPawn_Character::execPawnOnAssisted(FFrame&, void* const)

native function PawnOnRevive();  // Export UTgPawn_Character::execPawnOnRevive(FFrame&, void* const)

native function PawnOnEnterCombat();  // Export UTgPawn_Character::execPawnOnEnterCombat(FFrame&, void* const)

native function PawnOnExitCombat();  // Export UTgPawn_Character::execPawnOnExitCombat(FFrame&, void* const)

native function PawnOnGetHealthNugget(TgDeploy_HealthNugget nugget);  // Export UTgPawn_Character::execPawnOnGetHealthNugget(FFrame&, void* const)

native function PawnOnEnterCapturePoint(TgChaosCapturePoint capturePoint);  // Export UTgPawn_Character::execPawnOnEnterCapturePoint(FFrame&, void* const)

native function PawnOnLeaveCapturePoint(TgChaosCapturePoint capturePoint);  // Export UTgPawn_Character::execPawnOnLeaveCapturePoint(FFrame&, void* const)

native function PawnOnTeleported(TgSpawnTeleporterEntrance From, TgSpawnTeleporterExit To, Vector OriginalPawnLocation);  // Export UTgPawn_Character::execPawnOnTeleported(FFrame&, void* const)

native function DeviceOnStartBuildup(TgDevice Dev);  // Export UTgPawn_Character::execDeviceOnStartBuildup(FFrame&, void* const)

native function DeviceOnStopBuildup(TgDevice Dev, optional bool WasInterrupted=false);  // Export UTgPawn_Character::execDeviceOnStopBuildup(FFrame&, void* const)

native function DeviceOnFire(TgDevice Dev);  // Export UTgPawn_Character::execDeviceOnFire(FFrame&, void* const)

native function ProjectileOnFire(TgProjectile Proj);  // Export UTgPawn_Character::execProjectileOnFire(FFrame&, void* const)

native function DeviceOnStartFire(TgDevice Dev);  // Export UTgPawn_Character::execDeviceOnStartFire(FFrame&, void* const)

native function DeviceOnStopFire(TgDevice Dev, optional bool WasInterrupted=false);  // Export UTgPawn_Character::execDeviceOnStopFire(FFrame&, void* const)

native function DeviceOnHit(TgDevice Dev, const out ImpactInfo Impact);  // Export UTgPawn_Character::execDeviceOnHit(FFrame&, void* const)

native function DeviceOnHitSpecial(TgDevice Dev, const out ImpactInfo Impact, int nHitSpecialSituationalType);  // Export UTgPawn_Character::execDeviceOnHitSpecial(FFrame&, void* const)

native function DeviceOnDamaged(out OnDamagedParams Params);  // Export UTgPawn_Character::execDeviceOnDamaged(FFrame&, void* const)

native function DeviceOnHealed(out OnHealedParams Params);  // Export UTgPawn_Character::execDeviceOnHealed(FFrame&, void* const)

native function DeviceOnKilled(TgDevice Dev, const out ImpactInfo Impact, float fDamage);  // Export UTgPawn_Character::execDeviceOnKilled(FFrame&, void* const)

native function DeviceOnReload(TgDevice Dev);  // Export UTgPawn_Character::execDeviceOnReload(FFrame&, void* const)

native function DeviceOnMiss(TgDevice Dev);  // Export UTgPawn_Character::execDeviceOnMiss(FFrame&, void* const)

native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);  // Export UTgPawn_Character::execDeviceAdjustDamage(FFrame&, void* const)

native function DeviceAdjustHeal(const out AdjustHealParams Params, out float fHeal);  // Export UTgPawn_Character::execDeviceAdjustHeal(FFrame&, void* const)

native function DropHealthNugget(optional Vector SpawnVelocity, optional float fHealOverride=-1.0000000, optional float fHoTOverride=-1.0000000);  // Export UTgPawn_Character::execDropHealthNugget(FFrame&, void* const)

native function DropHealthNuggetTeamOnly(int nTaskForce, optional Vector SpawnVelocity, optional float fHealOverride=-1.0000000, optional float fHoTOverride=-1.0000000);  // Export UTgPawn_Character::execDropHealthNuggetTeamOnly(FFrame&, void* const)

native function float GetBaseSpeed();  // Export UTgPawn_Character::execGetBaseSpeed(FFrame&, void* const)

native function bool OverrideDistanceFadeRange();  // Export UTgPawn_Character::execOverrideDistanceFadeRange(FFrame&, void* const)

native function int GetDefaultHeadMeshId();  // Export UTgPawn_Character::execGetDefaultHeadMeshId(FFrame&, void* const)

native function int GetRole();  // Export UTgPawn_Character::execGetRole(FFrame&, void* const)

native function TakeHealthDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);  // Export UTgPawn_Character::execTakeHealthDamage(FFrame&, void* const)

native function QueueBounce(const out Vector vBounceVelocity);  // Export UTgPawn_Character::execQueueBounce(FFrame&, void* const)

native function bool FindGround(const out Vector vSourceLocation, out Vector vGroundLocation, out Vector vGroundNormal, const optional float fCheckDist=500.0000000, const optional float fCheckRadius=0.0000000, const optional Vector vRayDir=vect(0.0000000, 0.0000000, -1.0000000));  // Export UTgPawn_Character::execFindGround(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated function PrepareIntro() { }

simulated function PlayIntroAnims() { }

simulated function PlaySpawnFx() { }

simulated function PlayAnnouncerMatchStartCue() { }

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

function ResetKillCombo() { }

simulated function CharacterPawnControllerSet() { }

simulated function OnRespawn() { }

simulated event bool PostPawnSetup() { }

simulated function ShowHeadMesh() { }

simulated function HideHeadMesh() { }

simulated event ReceivedPropValues() { }

simulated function bool IsViewPawn() { }

simulated event ReplicatedEvent(name VarName) { }

simulated function Tick(float DeltaSeconds) { }

function PossessedBy(Controller C, bool bVehicleTransition) { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

simulated exec function ComposeCharacter(optional int Idx=-1, optional int MeshAsmId=-1) { }

simulated event SetMountedCollision(bool IsActive) { }

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration) { }

simulated function bool AllowRagdoll() { }

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event ForceUpdateAmmoAnim() { }

simulated function SetWeaponZoom(optional float fZoomAmt=0.0000000) { }

simulated function UpdateWeaponZoomEffects(optional float fZoomAmt=0.0000000) { }

simulated function StartWeaponZoomInterpolation(float fZoomAmt, float fInterpTime) { }

simulated function OnStartTimelapseNewDeviceState() { }

simulated event PreTimeLapse(bool bPlayOfTheGame) { }

simulated event OnBecameSpectatorViewTarget() { }

simulated event OnCeaseSpectatorViewTarget() { }

event RemoveStickyBombs() { }

event StartAutomountProtectionTimer() { }

function AutomountProtectionTimer() { }

function bool CannotJumpNow() { }

function bool CheckPhysicsStateForJumping() { }

function bool CanAirJump() { }

function bool DoJump(bool bUpdating) { }

simulated function FlashJumpEffects() { }

simulated event StopSpecialJumpFx() { }

simulated event int GetNumAirJumps() { }

simulated function bool CanAddForcedViewTarget() { }

reliable client simulated function ClientAddForcedViewTarget(Actor TargetActor, float InterpTime, float Duration, Object ForceRotationInstigator, optional float HeightOffset=0.0000000) { }

simulated function AddForcedViewTarget(Actor TargetActor, float InterpTime, float Duration, Object ForceRotationInstigator, optional float HeightOffset=0.0000000) { }

reliable client simulated function ClientRemoveForcedViewTarget(Object ForceRotationInstigator) { }

simulated function RemoveForcedViewTarget(Object ForceRotationInstigator) { }

simulated function ClearOldForcedViewTargets() { }

simulated function bool HasForcedRotation() { }

simulated event UpdateForcedRotation(float DeltaTime) { }

function bool IsJoined() { }

function AbortJoin() { }

simulated event StartPhysTween(Vector Target, float fTime, TgPawn.ETweenState tweenState, optional bool bCollideWithWorld=false, optional bool bRotateTowardsTarget=false) { }

function JoinToTarget(TgPawn_Character Target, Vector SourceLocation, Vector TargetLocation, float TweenDuration) { }

function UnjoinFromTarget() { }

simulated function ClientJoinToTarget() { }

simulated function ClientUnjoinFromTarget() { }

simulated function TweenForJoin() { }

simulated function TweenForJoinFinished() { }

simulated function AddJoinForcedView(TgPawn_Character Source, TgPawn_Character Target) { }

simulated function RemoveJoinForcedView(TgPawn_Character Source, TgPawn_Character Target) { }

simulated function UpdateJoinSourceLocal() { }

simulated event bool AdvancedTeleport(const out TeleportParams Params, optional out Vector vTeleportLocation, optional bool bFakeTeleport=false) { }

defaultproperties
{}
