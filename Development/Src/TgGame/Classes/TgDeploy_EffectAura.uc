class TgDeploy_EffectAura extends TgDeploy_MatchParentFireMode
    native(Deployable)
    placeable
    hidecategories(Navigation)
    config(Engine);

var repnotify float r_fRadiusScale;
var array<Actor> m_TouchingActors;
var array<Actor> m_AffectedActors;
var float m_fLastBlockedByBlockersTime;
var float m_fMinBlockedByBlockersTime;
var array<Actor> m_BlockedActors;
var TgCollisionProxy_Cylinder m_CollisionProxy;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fRadiusScale;
}

native function ApplyEffects(Actor Target);  // Export UTgDeploy_EffectAura::execApplyEffects(FFrame&, void* const)

native function RemoveEffects(Actor Target);  // Export UTgDeploy_EffectAura::execRemoveEffects(FFrame&, void* const)

native function float GetDistanceToTarget(Actor Target);  // Export UTgDeploy_EffectAura::execGetDistanceToTarget(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

function OnProxyUnTouch(Actor Other) { }

simulated event float GetCurrentRadius() { }

simulated event ClearAllTouched() { }

simulated event DestroyIt(optional bool bSkipFx) { }

simulated event Destroyed() { }

simulated event SpawnCollisionProxy() { }

event ScaleCollisionProxy() { }

simulated event ScaleFX() { }

defaultproperties
{}
