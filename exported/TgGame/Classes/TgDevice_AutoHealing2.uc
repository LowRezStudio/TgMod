class TgDevice_AutoHealing2 extends TgDevice
    native(Devices)
    hidecategories(Navigation);

var bool m_bIsApplied;
var bool m_bForceRemoval;
var TgPawn m_CachedPawnOwner;
var float m_fLastLowHealthSoundTime;
var float m_fPrevHealthPct;

// Export UTgDevice_AutoHealing2::execDeviceAdjustHeal(FFrame&, void* const)
native function DeviceAdjustHeal(const out ImpactInfo Impact, out float fHeal, int nPropertyId);

defaultproperties
{
    m_fLastLowHealthSoundTime=-100.0000000
}