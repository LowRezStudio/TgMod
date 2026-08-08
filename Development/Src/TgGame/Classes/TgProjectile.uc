class TgProjectile extends Projectile
    native(Projectiles)
    nativereplication
    hidecategories(Navigation)
    implements(TgSkinnableInterface,TgObserver_ViewTargetChanged)
    config(Engine)
    dependson(TgImpactFx, TgObject);

const PROJECTILE_LINE_TRACE_DISTANCE = 32;

enum SpawnDeployableOrientation {
    SDO_AlignUpToNormal,  // 0
    SDO_FaceRotation,  // 1
};

struct CollisionSettingsProjectile {
    var bool bPassThroughFriends;
    var bool bPassThroughEnemies;
    var bool bPassThroughShields;
    var bool bPassThroughBlocker;
    var bool bExplodeOnShields;
    var bool bExplodeOnBlockers;
    var bool bHitAndPassThrough;
    var bool bHitOnTick;
    var bool bOnlyHitOnceOnPassThrough;
    structdefaultproperties {}
};

struct TrackingSettings {
    var const bool bUsesTracking;
    var Actor mTarget;
    var float fTurnStrength;
    var float fVertTurnStrength;
    var bool bIgnoreNonTargets;
    var bool bIgnoreWorldIfSeeking;
    var bool bIgnoreWorldIfNotSeeking;
    structdefaultproperties {}
};

var TgDeviceFire s_LastDefaultMode;
var repnotify int r_nProjectileId;
var repnotify float r_fDuration;
var float m_fPostLandDuration;
var float m_fLandZThreshold;
var float m_fPersistTime;
var float m_fPersistHitPulse;
var int m_nTargetPhysicalType;
var export editinline MeshComponent c_Mesh;
var TgSpecialFx c_ExplosionFx;
var TgImpactFx c_ImpactFx;
var bool c_bRotationFollowsVelocity;
var bool m_bExplodeAtMaxRange;
var bool m_bDeployOnCharacter;
var bool m_bDeployOnTarget;
var bool m_bDeployOnGround;
var bool m_bAlwaysDeployUpwards;
var bool m_bStickToWalls;
var bool c_bIsAOE;
var bool m_bCountDirectHitForAOE;
var bool m_bUseAOEDirectHit;
var bool m_bHasExploded;
var bool m_bHitValidTarget;
var bool m_bIngoreBehindProjCollisions;
var bool m_bIsInitialized;
var bool m_bIsShutDown;
var bool m_bPIEInitialized;
var bool m_bHasPlayedFizzleFX;
var bool m_bHasPlayedHitWallFX;
var bool m_bHasPlayedHitTargetFX;
var bool m_bSuppressDeployableSpawn;
var bool m_bAltFireHit;
var bool m_bInvertTeam;
var bool m_bFirstShotAfterMovementAbility;
var bool m_bCanSpawnOnClientFirst;
var bool m_bTrackToWorldLocation;
var float r_fAccelRate;
var float m_fTossZ;
var float m_fFireAngle;
var Actor r_Owner;
var repnotify int r_nOwnerFireModeId;
var TgDeviceFire m_OwnerFireMode;
var array<TgDeviceFire> m_ExtraFireModes;
var float r_fRange;
var float m_fProximityDistance;
var TgCollisionProxy m_CollisionProxy;
var int s_nSpawnBotId;
var int s_nSpawnDeployableId;
var TgProjectile.SpawnDeployableOrientation m_DeployableSpawnOrientation;
var TgObject.TG_EQUIP_POINT r_eEquippedAt;
var float m_fDamageRadius;
var Vector r_vSpawnLocation;
var Vector m_vSpawnRotation;
var Vector m_vLocationLastTick;
var float m_fMinTravelRange;
var float s_fSpawnTime;
var int m_nPostRenderIcon;
var int m_nUniqueId;
var float m_fBaseDamageMultiplier;
var Vector c_vHitWallVelocity;
var () const editconst export editinline DynamicLightEnvironmentComponent LightEnvironment;
var Vector m_vSpawnPosition;
var export editinline ParticleSystemComponent m_DebugProximityDistancePSC;
var float m_fStandingStillPercent;
var int m_nTargetsHitCount;
var CollisionSettingsProjectile m_CollisionSettings;
var array<Actor> m_PassThroughTargets;
var TrackingSettings m_TrackingSettings;
var float m_fDelayTrackSeconds;
var float m_fExplosionOffsetDistance;
var float s_fAoeRewindTime;
var TgAkActorUnoccluded m_AkActorUnoccluded;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_Owner, r_eEquippedAt, r_fAccelRate, r_fDuration, r_fRange, r_nOwnerFireModeId, r_nProjectileId, r_vSpawnLocation;
}

native function float GetBuffedRange();  // Export UTgProjectile::execGetBuffedRange(FFrame&, void* const)

native function bool CheckPhysicality(int nPawnType);  // Export UTgProjectile::execCheckPhysicality(FFrame&, void* const)

native function CompleteInitialization();  // Export UTgProjectile::execCompleteInitialization(FFrame&, void* const)

native simulated function NativePostRenderFor(PlayerController PC, Canvas Canvas, vector CameraPosition, vector CameraDir);  // Export UTgProjectile::execNativePostRenderFor(FFrame&, void* const)

native function TgPawn SpawnBot(Vector vLocation, bool bPet);  // Export UTgProjectile::execSpawnBot(FFrame&, void* const)

native function bool GetBotSpawnLocationAndRotation(out Vector OutLocation, out Rotator OutRotation, Vector vLocation, Pointer botSetup);  // Export UTgProjectile::execGetBotSpawnLocationAndRotation(FFrame&, void* const)

native function TgDeployable SpawnDeployable(Vector vLocation, optional Actor TargetActor, optional Vector vNormal);  // Export UTgProjectile::execSpawnDeployable(FFrame&, void* const)

native function bool GetDeployLocationAndRotation(out Vector OutLocation, out Rotator OutRotation, Vector vLocation, optional Actor TargetActor, optional Vector vNormal);  // Export UTgProjectile::execGetDeployLocationAndRotation(FFrame&, void* const)

native function OnViewTargetChanged(optional Actor aNewViewTarget);  // Export UTgProjectile::execOnViewTargetChanged(FFrame&, void* const)

native function PostAkEvent(AkEvent InAkEvent);  // Export UTgProjectile::execPostAkEvent(FFrame&, void* const)

native function float GetTerminalVelocity();  // Export UTgProjectile::execGetTerminalVelocity(FFrame&, void* const)

event bool UseAOE() { }

simulated function PostBeginPlay() { }

event PostProjectileInitialize() { }

simulated function StartPulse() { }

simulated event ClientSetExplode() { }

simulated function TimerPulse() { }

simulated function TimerExplode() { }

simulated event Landed(vector HitNormal, actor FloorActor) { }

event Init(Vector Direction) { }

native function Vector CalculateInitialVelocity(Vector vAimDirection, bool bPlayerControlled);  // Export UTgProjectile::execCalculateInitialVelocity(FFrame&, void* const)

simulated function bool CheckProjectileRange(optional Vector vLocOverride) { }

function RangeReached() { }

simulated function UpdateSeekingDirection(float fDeltaTime) { }

simulated event Vector GetSeekLocation() { }

event SetTarget(Actor TargetActor, optional Vector TargetLocation) { }

simulated function bool IsValidTarget(Actor A) { }

simulated function GetHitLocationForProximityTouch(Actor Target, out Vector HitLocation, out Vector HitNormal) { }

simulated function bool ProximityReached(Actor A, Vector HitLocation, Vector HitNormal) { }

simulated function SetAcceleration() { }

simulated function bool IsOutsideMinRange(Vector HitLocation) { }

simulated event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp) { }

simulated event FellOutOfWorld(class<DamageType> dmgType) { }

simulated event ProcessTouchAsEvent(Actor Other, Vector HitLocation, Vector HitNormal) { }

function ShutdownAndNotifyClient() { }

simulated function bool HandleOnProjectileHitTarget(Actor Other, Vector HitLocation, Vector HitNormal) { }

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal) { }

simulated function bool ForcefieldExclusionCheck(Actor Other) { }

simulated function bool ShouldExplodeOnTouching(Actor Other) { }

simulated function HitPassThroughTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated event ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event ProxyUnTouch(Actor Other) { }

simulated function Tick(float DeltaSeconds) { }

simulated event bool CheckTeamPassThrough(Actor Other) { }

function bool ApplyTheHit(TgDeviceFire FireMode, ImpactInfo Impact, Actor DamageInstigator) { }

function bool ApplyHit(Actor Target, Vector HitLocation, Vector HitNormal, optional int HitItem) { }

simulated function Actor CalculateHitActor(Actor Target, Vector HitLocation, Vector HitNormal, out TraceHitInfo HitInfo) { }

simulated event Explode(vector HitLocation, vector HitNormal) { }

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated event Fizzle() { }

simulated function ParticleSystemComponent SpawnDebugProximityDistancePSC() { }

simulated event SpawnFlightEffects() { }

simulated function SpawnExplosionEffects(Vector HitLocation, Vector HitNormal, optional IMPACT_FX ImpactFx) { }

simulated function ShutDown() { }

event TornOff() { }

simulated function HideProjectile() { }

simulated function Destroyed() { }

simulated function MyOnParticleSystemFinished(ParticleSystemComponent PSC) { }

simulated function bool ProjectileCalcCamera(float fDeltaTime, out Vector out_CamLoc, out Rotator out_CamRot, out float out_FOV) { }

event ServerDetonate() { }

event ServerFizzle() { }

simulated event ReplicatedEvent(name VarName) { }

simulated function PlayFizzleFX(Vector HitNormal, bool bIsExplosionFizzle) { }

native simulated function PhysicalMaterial TraceWorldPhysicalGeometry(Vector StartLoc, Vector EndLoc, out Vector TraceHitLocation);  // Export UTgProjectile::execTraceWorldPhysicalGeometry(FFrame&, void* const)

simulated event PlayHitWallExplosionFX(Vector HitNormal, Vector HitLocation) { }

simulated function PlayHitTargetFX(Actor Target, Vector HitLocation, Vector HitNormal, bool bExploded) { }

simulated function bool SuppressHitTargetFX(Actor Target, Vector HitLocation, Vector HitNormal, bool bExploded) { }

simulated function PlayAdditionalHitFX(bool bSuccessfulHit, Vector FXLocation, Vector HitNormal, Vector ProjDir, out array<ParticleSysParam> ExplosionParams) { }

native function GetExplosionFXParams(out array<ParticleSysParam> Params);  // Export UTgProjectile::execGetExplosionFXParams(FFrame&, void* const)

simulated function AltFireDetonate() { }

simulated event Rotator AlignDeployableByMyRotation(Vector HitNormal) { }

native function float CheckOcclusion();  // Export UTgProjectile::execCheckOcclusion(FFrame&, void* const)

defaultproperties
{}
