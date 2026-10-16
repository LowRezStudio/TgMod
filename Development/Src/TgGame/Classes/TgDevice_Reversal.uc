class TgDevice_Reversal extends TgDevice
    native(ChampAndroxus)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var float m_fAccumulatedDamage;
var float m_fVengeanceDamage;

native function GetCachedAim(out AimData Aim);  // Export UTgDevice_Reversal::execGetCachedAim(FFrame&, void* const)

native function TgObject.DeviceTargetMode GetTargetingMode();  // Export UTgDevice_Reversal::execGetTargetingMode(FFrame&, void* const)

native function bool MustBeOnGroundToFire();  // Export UTgDevice_Reversal::execMustBeOnGroundToFire(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function TgDeviceFire GetFireModeForFiringProjectile() { }

simulated event float GetCurrentDamageAmount() { }

simulated function Projectile ProjectileFire() { }

simulated event bool CanBeInterrupted() { }

function InterruptFiringOnServerInternal(optional bool bSendClientInterrupt=true) { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bAimThroughReticule=true
    m_bForce3PViewWhileFiring=true
    m_fDeployZOffset=-30.0000000
}
