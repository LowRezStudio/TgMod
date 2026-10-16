class TgProj_BombKingStickyBomb extends TgProj_FreeGrenade
    native(ChampBombKing)
    hidecategories(Navigation)
    config(Engine);

var bool m_bExplodedOnShield;
var bool m_bExplodedOnDeployGeomtry;
var bool c_bReadyToHide;
var Actor m_CachedHitTarget;
var Vector m_vCachedHitLocation;
var Vector m_vCachedHitNormal;

native function TgDeployable SpawnDeployable(Vector vLocation, optional Actor TargetActor, optional Vector vNormal);  // Export UTgProj_BombKingStickyBomb::execSpawnDeployable(FFrame&, void* const)

simulated function Actor CalculateHitActor(Actor Target, Vector HitLocation, Vector HitNormal, out TraceHitInfo HitInfo) { }

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated function AltFireDetonate() { }

function bool ApplyTheHit(TgDeviceFire FireMode, ImpactInfo Impact, Actor DamageInstigator) { }

simulated function SpecialHideProjectile() { }

simulated function HideProjectile() { }

simulated function bool PredictStickToPlayerSocket(out Vector outSocketLocation, out Rotator outSocketRotation) { }

simulated event ClientExplodeSpecial(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated function HideForNonOwnerClient() { }

simulated function Destroyed() { }

simulated function ShutDown() { }

defaultproperties
{}
