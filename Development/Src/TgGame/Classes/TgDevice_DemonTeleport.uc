class TgDevice_DemonTeleport extends TgDevice
    native(ChampDemon)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

var bool m_bCancelled;
var bool m_bPhaseApplied;
var float m_fTeleportDelayTimer;

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_DemonTeleport::execGetMoveSpeedMultiplier(FFrame&, void* const)

native function bool ShouldForce3P(TgDeviceForm DeviceForm, optional bool bOnlyCheckDeviceForm=false);  // Export UTgDevice_DemonTeleport::execShouldForce3P(FFrame&, void* const)

native function bool IsDeviceFiringForUI();  // Export UTgDevice_DemonTeleport::execIsDeviceFiringForUI(FFrame&, void* const)

simulated function bool ShouldTeleportOnTimeout() { }

simulated event bool ShouldCooldownAfterFire() { }

simulated function bool CanFiringBeCanceledByLeftMouse() { }

simulated function bool InterceptSlotPressed(TgPlayerController TgController) { }

simulated event bool CanBeInterrupted() { }

simulated event bool CanBeCanceled() { }

event OnDeployableDestroyed(TgDeployable deployable) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanTeleportNow() { }

simulated event DoTeleport() { }

reliable server function ServerTeleportToDeployable(Vector vDest) { }

simulated function TeleportToDeployable(Vector vDest) { }

simulated function StartPhaseIn() { }

simulated function FinishPhaseIn() { }

simulated event float GetCustomTimerBarCurrentTime() { }

simulated event float GetCustomTimerBarMaxTime() { }

state DeviceFiring {}

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
}
