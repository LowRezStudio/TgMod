class TgDevice_MinigunSpinUp extends TgDevice
    hidecategories(Navigation)
    config(Engine);

var TgDevice_RuckusInhand m_cachedRuckusInhand;

simulated function bool IsToggleDevice() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function StartSpinningInhand() { }

simulated function StopSpinningInhand() { }

simulated function CacheRuckusInhand() { }

state DeviceFiring {}

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
}
