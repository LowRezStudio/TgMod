class TgDevice_ToggleInhand extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

var TgPawn m_CachedTgP;
var float m_fCurrentTransitionPct;
var int m_nProjectilesFired;

simulated function TgPawn GetCachedTgP() { }

native simulated function float GetBuildupTime();  // Export UTgDevice_ToggleInhand::execGetBuildupTime(FFrame&, void* const)

native simulated function float GetFiringPreHitDelay(optional int nMode=-1);  // Export UTgDevice_ToggleInhand::execGetFiringPreHitDelay(FFrame&, void* const)

native simulated function float GetFiringPostHitDelay(optional int nMode=-1);  // Export UTgDevice_ToggleInhand::execGetFiringPostHitDelay(FFrame&, void* const)

simulated function float GetBaseBuildupTime() { }

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

simulated function bool CanToggleDeviceStopFiring() { }

simulated event bool IsToggleDevice() { }

simulated function FireAmmunition() { }

simulated function StartIntroTimer(float fDuration) { }

simulated function StartOutroTimer(float fDuration) { }

simulated function IntroTimer() { }

simulated function OutroTimer() { }

simulated function InitialFirePreHitDelay() { }

reliable server event InterruptFiring() { }

reliable client simulated event ClientInterrupt() { }

simulated function StopFire(byte FireModeNum) { }

simulated event UpdateTransitionPct(optional float fDefaultPct=0.0000000) { }

state DeviceBuildup {}

state DeviceFiring {}
