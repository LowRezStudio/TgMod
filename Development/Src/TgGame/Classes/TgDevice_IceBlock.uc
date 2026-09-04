class TgDevice_IceBlock extends TgDevice
    hidecategories(Navigation)
    config(Engine);

simulated event bool CanBeCanceled() { }

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
}
