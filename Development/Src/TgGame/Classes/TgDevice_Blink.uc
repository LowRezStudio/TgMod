class TgDevice_Blink extends TgDevice
    native(ChampEvie)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine)
    dependson(TgObject);

var Vector r_vPreviousLocation;
var bool c_bWaitingForServerTeleport;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_vPreviousLocation;
}

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_Blink::execGetTargetingAim(FFrame&, void* const)

native function bool CanBeCrippled();  // Export UTgDevice_Blink::execCanBeCrippled(FFrame&, void* const)

native function bool MustBeOnGroundToFire();  // Export UTgDevice_Blink::execMustBeOnGroundToFire(FFrame&, void* const)

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_Blink::execGetMoveSpeedMultiplier(FFrame&, void* const)

simulated function DeviceRestart() { }

function AuthStartCooldown(optional int nMode=-1, optional float fCooldownTimeOverride=-1.0000000) { }

simulated function InterruptOtherDevices(TgPawn TgP) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

function RequireHardReset() { }

native function bool CanFireIfLeftMouseDown();  // Export UTgDevice_Blink::execCanFireIfLeftMouseDown(FFrame&, void* const)

simulated function int GetAimAssistPriority() { }

simulated event bool CanDeviceStartFiringNow(byte FireModeNum, AimData Aim, bool bDebugRelevant, optional out TgObject.EDeviceFailType failType) { }

simulated function OnServerTeleportTimeout() { }

reliable client simulated event ClientOnServerTeleported() { }

state DeviceFiring {}

defaultproperties
{
    m_fDeployZForgiveness=580.0000000
    m_fBottomlessPitCheck=5000.0000000
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
}
