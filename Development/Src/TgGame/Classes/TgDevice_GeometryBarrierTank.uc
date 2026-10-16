class TgDevice_GeometryBarrierTank extends TgDevice
    native(ChampBarrierTank)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

const IMPASSE_POST_TARGET_LOCKOUT_TIME = 0.7f;

var float r_fTremorsCooldownReduction;
var float m_fCachedWallHealthPercent;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fTremorsCooldownReduction;
}

native function GetGroundTargetAim(out AimData Aim);  // Export UTgDevice_GeometryBarrierTank::execGetGroundTargetAim(FFrame&, void* const)

native function bool MustBeOnGroundToFire();  // Export UTgDevice_GeometryBarrierTank::execMustBeOnGroundToFire(FFrame&, void* const)

native function bool ShouldAltFireOnTick();  // Export UTgDevice_GeometryBarrierTank::execShouldAltFireOnTick(FFrame&, void* const)

native function UpdateTargetingModeStatus(const out AimData Aim);  // Export UTgDevice_GeometryBarrierTank::execUpdateTargetingModeStatus(FFrame&, void* const)

simulated function bool InterceptSlotPressed(TgPlayerController TgController) { }

simulated function bool InterceptSlotReleased(TgPlayerController TgController) { }

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController) { }

simulated event EndCustomTargeting() { }

reliable server function ServerEndCustomTargeting() { }

simulated event bool CanFireWithoutAimResult() { }

simulated event OnDeployableSpawned(TgDeployable deployable) { }

event OnDeployableDestroyed(TgDeployable deployable) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanBeCanceled() { }

simulated function int GetAimAssistPriority() { }

state DeviceBuildup {}

state DeviceFiring {}

defaultproperties
{
    r_fTremorsCooldownReduction=-1.0000000
    m_fCachedWallHealthPercent=-1.0000000
    m_DeviceEmoteAt=DEA_StartFire
    m_bAimThroughReticule=true
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
}
