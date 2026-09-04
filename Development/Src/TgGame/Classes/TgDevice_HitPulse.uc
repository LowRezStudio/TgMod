class TgDevice_HitPulse extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var bool s_ShouldPayCostPerPulse;
var bool s_bCostPaid;
var bool m_bConsumeAmmoOnEachPulse;
var int m_CurrentPulseIndex;

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_HitPulse::execCanDeviceFireNow(FFrame&, void* const)

simulated function bool ApplyGlobalOffhandCooldown() { }

simulated function PersistTimer() { }

simulated event float GetRefireTime(optional int nMode=-1) { }

simulated function PulseHit() { }

simulated event float GetPersistTime(optional int nMode=-1) { }

simulated event float GetPersistPulseHitTime(optional int nMode=-1) { }

reliable server event InterruptFiring() { }

reliable client simulated event ClientInterrupt() { }

simulated function bool ShouldConsumePowerPoolOnStartFire() { }

simulated function bool ShouldConsumePowerPoolAfterFire() { }

simulated function int GetAmmoToConsume() { }

simulated function float GetLockoutExtensionTime() { }

state DeviceFiring {}

defaultproperties
{
    m_bAlwaysStartCooldown=true
}
