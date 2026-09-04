class TgDevice_DoubleCharge extends TgDevice_Charge
    native(Devices)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var int m_nTotalNumShots;
var int m_nShotsFired;
var bool m_bSetAsTargetingDeviceForMultiFire;

native function UpdateTargetingModeStatus(const out AimData Aim);  // Export UTgDevice_DoubleCharge::execUpdateTargetingModeStatus(FFrame&, void* const)

simulated event bool CanBeCanceled() { }

simulated event bool Use() { }

simulated function bool RefireTimer(optional bool bRefire) { }

reliable server function bool ServerRefireTimer(optional bool bRefire, optional AimData ClientAim, optional float EndTraceX=-10000000.0000000, optional float EndTraceY=-10000000.0000000) { }

simulated function DeviceConsumePowerPool(byte FireModeNum) { }

simulated function int GetTotalNumberOfShots() { }

state DeviceFiring {}

defaultproperties
{
    m_nTotalNumShots=2
    m_bSetAsTargetingDeviceForMultiFire=true
    m_IndividualOffhandCooldownTime=0.0000000
}
