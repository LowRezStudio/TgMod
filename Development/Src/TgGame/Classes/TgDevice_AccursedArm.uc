class TgDevice_AccursedArm extends TgDevice_HitPulse
    native(ChampAndroxus)
    hidecategories(Navigation)
    config(Engine);

const TG_DEVICE_ACCURSED_ARM_GUN_ID = 13255;

const TG_DEVICE_NETHER_STEP_ID = 12658;

native function bool ShouldInterruptStealth();  // Export UTgDevice_AccursedArm::execShouldInterruptStealth(FFrame&, void* const)

simulated event bool CanBeCanceled() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function PersistTimer() { }

singular simulated function OnGunEmptied() { }

unreliable client simulated function ClientOnGunEmptied() { }

reliable server function ServerForcePersistTimer() { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PersistTime
    m_bPostFireShouldInterruptStealth=false
}
