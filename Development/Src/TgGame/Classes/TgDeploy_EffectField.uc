class TgDeploy_EffectField extends TgDeploy_MatchParentFireMode
    native(Deployable)
    placeable
    hidecategories(Navigation)
    config(Engine);

var float m_fEffectFieldHeight;
var repnotify float r_fRadiusScale;
var array<Actor> m_TouchingPawns;
var array<Actor> m_HitActors;
var bool m_bOnlyHitOnce;
var TgCollisionProxy_Cylinder m_CollisionProxy;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fRadiusScale;
}

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

function OnProxyUnTouch(Actor Other) { }

function ProxyTouchHit(Actor Other) { }

function ProxyUnTouchHit(Actor Other) { }

simulated event float GetCurrentRadius() { }

simulated event ClearAllTouched() { }

simulated event DestroyIt(optional bool bSkipFx) { }

simulated event Destroyed() { }

simulated event SpawnCollisionProxy() { }

event ScaleCollisionProxy() { }

defaultproperties
{}
