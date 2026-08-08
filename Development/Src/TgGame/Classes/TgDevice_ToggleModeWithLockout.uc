class TgDevice_ToggleModeWithLockout extends TgDevice_ToggleWithLockout
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_CachedInhand;

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

state DeviceFiring {}

defaultproperties
{
    m_nLinkedDeviceTypes[0]=11077
    m_nLinkedDeviceTypes[1]=10828
}
