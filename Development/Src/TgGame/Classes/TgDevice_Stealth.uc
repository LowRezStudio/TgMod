class TgDevice_Stealth extends TgDevice
    native(ChampSkye)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var bool m_bIsInCombat;
var bool m_bCanFireInCombat;

native function bool ShouldInterruptStealth();  // Export UTgDevice_Stealth::execShouldInterruptStealth(FFrame&, void* const)

native function bool CanFireWhileMounted();  // Export UTgDevice_Stealth::execCanFireWhileMounted(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_Stealth::execCanDeviceFireNow(FFrame&, void* const)

simulated event bool ShouldInterruptReloadOnFire() { }

simulated event StartFire(byte FireModeNum) { }

simulated event bool CanBeCanceled() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function bool ShouldCancelStealth() { }

simulated function bool ShouldInterruptMount() { }

simulated event bool ShouldMountCancelFiring() { }

defaultproperties
{
    m_bCanFireInCombat=true
}
