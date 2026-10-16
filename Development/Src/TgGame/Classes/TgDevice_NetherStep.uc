class TgDevice_NetherStep extends TgDevice_DoubleCharge
    native(ChampAndroxus)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_NetherStep::execGetTargetingAim(FFrame&, void* const)

native function bool ShouldInterruptStealth();  // Export UTgDevice_NetherStep::execShouldInterruptStealth(FFrame&, void* const)

native function SetFireMode(int nFireModeNum, optional bool ForceSet=false);  // Export UTgDevice_NetherStep::execSetFireMode(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function int GetTotalNumberOfShots() { }

simulated event bool CanFiringBeCanceledByLeftMouse() { }

simulated event bool CanFiringBeCanceledByRightMouse() { }

simulated event bool CanFiringBeCanceledByReactivation() { }

state DeviceFiring {}

defaultproperties
{
    m_nTotalNumShots=3
    m_bSetAsTargetingDeviceForMultiFire=false
    m_bStopOnHitType=CSHT_GodOnly
    m_bUsePhysFlying=true
    m_DeviceTimerBarType=DTBT_RefireTime
    s_bIgnoreReceivedAim=true
    m_bForce3PViewWhileFiring=false
}
