class TgDevice_Emote extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

var TgPawn m_CachedPawnOwner;
var bool m_bAccelerationInterruptsDevice;
var bool m_bJumpingInterruptsDevice;
var Class<TgCameraModule> m_DefaultCameraModuleClass;
var Class<TgCameraModule_ThirdPersonVariableHeight> m_FiringCameraModuleClass;
var TgCameraModule m_FiringCameraModule;
var float m_fCameraTweenInTime;
var float m_fCameraTweenOutTime;
var Vector m_vFiringCameraOffset;

native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);  // Export UTgDevice_Emote::execShouldBlockReload(FFrame&, void* const)

native function bool MustBeOnGroundToFire();  // Export UTgDevice_Emote::execMustBeOnGroundToFire(FFrame&, void* const)

native function bool CanFiringBeLocked();  // Export UTgDevice_Emote::execCanFiringBeLocked(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanJumpWhileFiring() { }

simulated event bool CanFiringBeCanceledByRightMouse() { }

simulated event bool CanFiringBeCanceledByReactivation() { }

simulated event bool CanBeFiredWhileTweening() { }

simulated function bool ShouldInterruptMount() { }

simulated event bool ShouldInterruptReloadOnFire() { }

simulated event bool CanBeInterrupted() { }

simulated event bool CanBeCanceled() { }

simulated function TurnOnSpecialCamera() { }

simulated function TurnOffSpecialCamera() { }

simulated function TgPawn GetCachedPawnOwner() { }

simulated function Tick(float DeltaSeconds) { }

state DeviceBuildup {}

state DeviceFiring {}

defaultproperties
{
    m_bAccelerationInterruptsDevice=true
    m_bJumpingInterruptsDevice=true
    m_FiringCameraModuleClass=Class'TgCameraModule_ThirdPersonVariableHeight'
    m_fCameraTweenInTime=0.1000000
    m_fCameraTweenOutTime=0.1000000
    m_bForce3PViewWhileFiring=true
}
