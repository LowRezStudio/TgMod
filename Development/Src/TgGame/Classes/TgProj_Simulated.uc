class TgProj_Simulated extends TgProjectile
    native(Projectiles)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

const LERP_FROM_CLIENT_POSITION_DURATION = 0.2;

enum eSimProjEvent {
    Proj_Spawn,  // 0
    Proj_Exploded,  // 1
    Proj_ExplodedSpecial,  // 2
    Proj_Shutdown,  // 3
    Proj_Hit,  // 4
    Proj_Target,  // 5
    Proj_HitWall,  // 6
    Proj_HideProjectile,  // 7
    Proj_Fizzle,  // 8
};

var bool m_bHasFlashedShutdown;
var bool m_bHasFlashExploded;
var bool m_bIgnoreClientHits;
var bool m_bShouldQueueServerHits;
var bool m_bHasQueuedServerHit;
var bool m_bNeedsFrictionOverride;
var bool m_bFlashSpecialExplosion;
var bool m_bTrackProjectileForTimelapse;
var bool s_bTrackingInitialized;
var const bool m_bRequireAccurateTicksForPrediction;
var int m_nProjectileInstanceId;
var int m_nClientFireRequestId;
var Vector m_LerpFromClientOffset;
var float m_LerpTimeRemaining;
var Actor m_QueuedExplodeTarget;
var Vector m_QueuedExplodeLocation;
var Vector m_QueuedExplodeNormal;
var Vector m_vSpawnVelocity;
var Vector m_vSpawnAcceleration;
var Rotator m_rSpawnRotator;
var float m_fAllowedClientMovementTime;
var float m_fSpawnTimeStamp;
var float m_fGravityScale;
var float m_fFrictionOverride;
var array<TgPlayerController> s_InterestedPlayers;
var int m_nShadowFXID;
var TgSpecialFx m_ShadowFX;
var export editinline DecalComponent m_ShadowDecal;
var float m_fShadowBaseWidth;
var float m_fMaxDecalHeight;
var Rotator m_CachedRotation;
var float m_fTrackingUpdateRate;
var float s_fTrackingUpdateTimer;
var TgGameplayCurves m_GameplayCurves;
var int m_nDeployableOverlayDisplayMask;
var TgObject.DeployableOverlayIcon m_eDeployableOverlayIcon;
var TgObject.DeployableOverlayState m_eDeployableOverlayState;
var float m_fDeployableOverlayEnemyViewDist;
var float m_fDeployableActiveLifeTime;

native function CompleteInitialization();  // Export UTgProj_Simulated::execCompleteInitialization(FFrame&, void* const)

native function FlashNotifySpawn();  // Export UTgProj_Simulated::execFlashNotifySpawn(FFrame&, void* const)

native function FlashNotifyShutdown();  // Export UTgProj_Simulated::execFlashNotifyShutdown(FFrame&, void* const)

native function FlashNotifyFizzle();  // Export UTgProj_Simulated::execFlashNotifyFizzle(FFrame&, void* const)

native function FlashNotifyExploded(Actor Target, Vector HitLocation, Vector HitNormal);  // Export UTgProj_Simulated::execFlashNotifyExploded(FFrame&, void* const)

native function FlashNotifyExplodedSpecial(Actor Target, Vector HitLocation, Vector HitNormal);  // Export UTgProj_Simulated::execFlashNotifyExplodedSpecial(FFrame&, void* const)

native function FlashNotifyHit(Actor Target, Vector HitLocation, Vector HitNormal);  // Export UTgProj_Simulated::execFlashNotifyHit(FFrame&, void* const)

native function FlashNotifyHitWall(Actor Wall, Vector HitNormal, Vector HitLocation);  // Export UTgProj_Simulated::execFlashNotifyHitWall(FFrame&, void* const)

native function FlashNotifyTarget(Actor TargetActor, Vector TargetLocation);  // Export UTgProj_Simulated::execFlashNotifyTarget(FFrame&, void* const)

native function SetLocationFromServer(Vector InLocation);  // Export UTgProj_Simulated::execSetLocationFromServer(FFrame&, void* const)

native function bool CheckFirstWorldExplosion(Vector StartPos, Vector EndPos);  // Export UTgProj_Simulated::execCheckFirstWorldExplosion(FFrame&, void* const)

native function float GetGravityZ();  // Export UTgProj_Simulated::execGetGravityZ(FFrame&, void* const)

native function PredictStartLocationBasedOnPing(float Ping);  // Export UTgProj_Simulated::execPredictStartLocationBasedOnPing(FFrame&, void* const)

native function int GetIndexForTimelapseTracking();  // Export UTgProj_Simulated::execGetIndexForTimelapseTracking(FFrame&, void* const)

native function InitTrackingForTimelapse();  // Export UTgProj_Simulated::execInitTrackingForTimelapse(FFrame&, void* const)

native function ShutDownTrackingForTimelapse();  // Export UTgProj_Simulated::execShutDownTrackingForTimelapse(FFrame&, void* const)

simulated event HandleQueuedFirstWorldExplosion() { }

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal) { }

simulated function HitPassThroughTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated function SendExplodeToServer(Actor Other, Vector HitLocation, Vector HitNormal) { }

simulated event SendSpawnAckToServer() { }

simulated event Explode(vector HitLocation, vector HitNormal) { }

simulated event ClientExplode(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated event ClientExplodeSpecial(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated event SetShouldQueueServerHits(bool bShouldQueue) { }

simulated function FudgeProjectileHitLocationForShields(Actor Other, out Vector HitLocation, out Vector HitNormal) { }

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

event ClientHitUpdate(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated function ShutDown() { }

simulated event Fizzle() { }

simulated function Destroyed() { }

simulated function Tick(float DeltaSeconds) { }

simulated function CheckShieldPassthrough() { }

simulated function bool CheckProjectileRange(optional Vector vLocOverride) { }

function bool ApplyHit(Actor Target, Vector HitLocation, Vector HitNormal, optional int HitItem) { }

simulated event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp) { }

event ClientTargetUpdate(Actor TargetActor, Vector TargetLocation) { }

event SetTarget(Actor TargetActor, optional Vector TargetLocation) { }

simulated event DecalComponent SpawnShadowDecal() { }

native simulated function TickAhead(float tickAmount);  // Export UTgProj_Simulated::execTickAhead(FFrame&, void* const)

defaultproperties
{}
