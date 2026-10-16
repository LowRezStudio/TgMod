class TgDevice_Mount extends TgDevice_Toggle
    native(Devices)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

const TG_DOT_GUARD_MOUNTING = false;

var bool m_bForceFireDueToRespawn;
var bool m_bPostureChange;
var bool m_bDismountProtection;
var () float m_fZoomDurationOverride;
var int m_nAutoReloadTransactionID;
var TgDevice m_CachedInhand;
var float m_fAutoMountDismountProtectionDuration;

native function float GetFiringPreHitDelay(optional int nMode=-1);  // Export UTgDevice_Mount::execGetFiringPreHitDelay(FFrame&, void* const)

native function bool IsDeviceFiringLockedForUI();  // Export UTgDevice_Mount::execIsDeviceFiringLockedForUI(FFrame&, void* const)

native function bool MustBeOnGroundToFire();  // Export UTgDevice_Mount::execMustBeOnGroundToFire(FFrame&, void* const)

native function bool RequiresAmmoToFire();  // Export UTgDevice_Mount::execRequiresAmmoToFire(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_Mount::execCanDeviceFireNow(FFrame&, void* const)

native function bool IsAnyDeviceOverridingDismount(int DamageAmt);  // Export UTgDevice_Mount::execIsAnyDeviceOverridingDismount(FFrame&, void* const)

simulated function OnOwnerRespawn() { }

function SetAllowMountServerTimer() { }

function AllowMountServer() { }

reliable client simulated function ClientStartMount() { }

event ServerForceMount() { }

function DismountOnDamage(int DamageAmt) { }

simulated function EndDismountProtection() { }

simulated event bool CanBeCanceled() { }

simulated event bool CanFiringBeCanceledByReactivation() { }

simulated event bool CanBeInterrupted() { }

simulated function bool IsItemShopVolumeBlockingDismounting() { }

simulated event bool CanFiringBeCanceledByRightMouse() { }

simulated event bool ShouldMountCancelFiring() { }

simulated function FireAmmunition() { }

simulated function OnStartFireRequestSent() { }

simulated function OnInterruptEvent() { }

simulated function bool IsOwnerOnGround() { }

function AuthStartCooldown(optional int nMode=-1, optional float fCooldownTimeOverride=-1.0000000) { }

simulated function AutoDismount() { }

simulated function OutroLockoutTime() { }

simulated function SetMountedCollision(bool IsActive) { }

simulated function EndEnteringMount(optional bool bEndingFireLoop) { }

simulated function InterruptOtherDevices(TgPawn TgP) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

state DeviceBuildup {}

state DeviceFiring {}

defaultproperties
{
    m_bPostureChange=true
    m_fZoomDurationOverride=0.1000000
    m_fAutoMountDismountProtectionDuration=2.0000000
    m_bAlwaysStartCooldown=true
    m_bMustBeOnGroundToFire=true
    m_bUsesOutroLockout=true
    m_nLinkedDeviceTypes[0]=10828
    m_fOutroLockoutTime=0.3000000
}
