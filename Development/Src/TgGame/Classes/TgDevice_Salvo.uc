class TgDevice_Salvo extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgDevice_DrogozInhand m_CachedInhand;

native function bool ShouldInterruptStealth();  // Export UTgDevice_Salvo::execShouldInterruptStealth(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_Salvo::execCanDeviceFireNow(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanBeInterrupted() { }

simulated event bool ShouldMountCancelFiring() { }

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim) { }

simulated function EndSalvo() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

state DeviceFiring {}

defaultproperties
{
    m_nLinkedDeviceTypes[0]=10828
}
