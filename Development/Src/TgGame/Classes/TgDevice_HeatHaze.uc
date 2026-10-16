class TgDevice_HeatHaze extends TgDevice
    hidecategories(Navigation)
    config(Engine);

const InhandBow = 14891;

simulated function InhandFired() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_nLinkedDeviceIDs[0]=14891
}
