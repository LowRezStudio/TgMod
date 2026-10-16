class TgDevice_SpaceTime extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgCollisionProxy_Mesh m_BeamCollisionProxy;
var array<TgPawn> m_ActorsInRange;

simulated event bool CanBeCanceled() { }

simulated event bool IsFunctionallyToggleDevice() { }

simulated function bool ShouldStopActionOnOffhandSlotReleased() { }

simulated event DeliverHit(ImpactInfo Impact) { }

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim) { }

simulated function InterruptOtherDevices(TgPawn TgP) { }

simulated function FireAmmunition() { }

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

function OnProxyUnTouch(Actor Other) { }

simulated function ClearTouchedActors() { }

simulated event SpawnCollisionProxy() { }

simulated function DestroyCollisionProxy() { }

state DeviceFiring {}

defaultproperties
{
    m_bAimThroughReticule=true
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_nAimAssistPriorityWhileFiring=2
}
