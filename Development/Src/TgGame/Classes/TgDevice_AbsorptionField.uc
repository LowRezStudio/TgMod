class TgDevice_AbsorptionField extends TgDevice
    native(ChampLazarus)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine)
    dependson(TgObject);

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_AbsorptionField::execGetMoveSpeedMultiplier(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_AbsorptionField::execCanDeviceFireNow(FFrame&, void* const)

state DeviceFiring {}

defaultproperties
{
    m_bIsFireHoldDevice=true
    m_fDeployZOffset=46.0000000
}
