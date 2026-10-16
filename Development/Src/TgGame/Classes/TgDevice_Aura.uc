class TgDevice_Aura extends TgDevice
    abstract
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

var repnotify float r_fRadiusScale;
var array<Actor> m_TouchingActors;
var array<Actor> m_AffectedActors;
var bool m_bIsAuraActive;
var float m_fLastBlockedByBlockersTime;
var float m_fMinBlockedByBlockersTime;
var array<Actor> m_BlockedActors;
var TgCollisionProxy_Cylinder m_CollisionProxy;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fRadiusScale;
}

native function SetFireMode(int nFireModeNum, optional bool ForceSet=false);  // Export UTgDevice_Aura::execSetFireMode(FFrame&, void* const)

native function ApplyEffects(Actor Target);  // Export UTgDevice_Aura::execApplyEffects(FFrame&, void* const)

native function RemoveEffects(Actor Target);  // Export UTgDevice_Aura::execRemoveEffects(FFrame&, void* const)

native function float GetCurrentRadius();  // Export UTgDevice_Aura::execGetCurrentRadius(FFrame&, void* const)

native function float GetDistanceToTarget(Actor Target);  // Export UTgDevice_Aura::execGetDistanceToTarget(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

function OnProxyUnTouch(Actor Other) { }

simulated event ClearAllAffected() { }

simulated event ClearAllTouched() { }

simulated function DeviceShutDown(optional bool bDeactiveMode, optional bool bResetCooldowns) { }

simulated event Destroyed() { }

event SpawnCollisionProxy() { }

event ScaleCollisionProxy() { }

event EnableAura() { }

event DisableAura() { }

simulated event bool CanJumpWhileFiring() { }

defaultproperties
{
    r_fRadiusScale=1.0000000
    m_fLastBlockedByBlockersTime=-0.2500000
    m_fMinBlockedByBlockersTime=0.2500000
}
