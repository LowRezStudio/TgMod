class TgDevice_ChargeBurst extends TgDevice
    native(ChampLazarus)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_ChargeBurst::execCanDeviceFireNow(FFrame&, void* const)

state DeviceFiring {}

defaultproperties
{
    m_bCarryPreFireToPostFire=false
    m_bUsesBurstFire=true
    m_nBurstTotalShots=1
}
