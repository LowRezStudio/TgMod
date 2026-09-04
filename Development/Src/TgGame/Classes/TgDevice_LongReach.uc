class TgDevice_LongReach extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

struct NuggetPullVals {
    var Actor nugget;
    var float fPullTime;
    var float fCheckTime;
    structdefaultproperties {}
};

var float m_fMinPullSpeed;
var float m_fMaxPullSpeed;
var float m_fTimeToMaxPullSpeed;
var float m_fPullSpeedInterpExp;
var TgPawn m_CachedTgP;
var array<NuggetPullVals> s_TouchingNuggets;
var float m_fBlockedByBlockersRecheckTime;
var TgCollisionProxy_Cylinder s_CollisionProxy;
var bool s_bIsAuraActive;
var bool m_bAutoActivateAura;

native function bool IsNuggetValid(Actor Target);  // Export UTgDevice_LongReach::execIsNuggetValid(FFrame&, void* const)

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

function OnProxyUnTouch(Actor Other) { }

function ClearAllTouched() { }

simulated function DeviceShutDown(optional bool bDeactiveMode, optional bool bResetCooldowns) { }

simulated event Destroyed() { }

event SpawnCollisionProxy() { }

event EnableAura() { }

event DisableAura() { }

defaultproperties
{
    m_fMinPullSpeed=256.0000000
    m_fMaxPullSpeed=1024.0000000
    m_fTimeToMaxPullSpeed=1.0000000
    m_fPullSpeedInterpExp=2.0000000
    m_fBlockedByBlockersRecheckTime=0.2500000
    m_bAutoActivateAura=true
}
