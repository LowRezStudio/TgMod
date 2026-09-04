class TgDeploy_ShieldSiegeUnit extends TgDeployable
    native(ChampFlak)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var Rotator m_InitRotation;
var export editinline MeshComponent m_VFXCollisionMesh;
var TgCollisionProxy_Cylinder m_CollisionProxy;
var TgDeviceFire m_WatchtowerFiremode;
var TgDevice m_CachedWatchtowerCard;
var float m_GroundSpeed;
var bool m_bOnlyHitOnce;
var array<Actor> m_TouchingPawns;

simulated event Landed(vector HitNormal, actor FloorActor) { }

function OnProxyUnTouch(Actor Other) { }

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event SpawnCollisionProxy(TgDeviceFire FireMode) { }

simulated event DestroyIt(optional bool bSkipFx) { }

simulated event ClearAllTouched() { }

native simulated function bool IsFortressBreakerEquipped();  // Export UTgDeploy_ShieldSiegeUnit::execIsFortressBreakerEquipped(FFrame&, void* const)

simulated event name GetWhileAliveDisplayGroup() { }

simulated event name GetDestroyedDisplayGroup() { }

defaultproperties
{}
