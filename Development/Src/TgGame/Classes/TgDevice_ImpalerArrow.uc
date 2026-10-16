class TgDevice_ImpalerArrow extends TgDevice
    native(ChampLongbow)
    hidecategories(Navigation)
    config(Engine);

var TgPawn_Longbow m_CachedLongbow;

native function bool ShouldAltFireOnTick();  // Export UTgDevice_ImpalerArrow::execShouldAltFireOnTick(FFrame&, void* const)

native function bool IsDeviceFiringForUI();  // Export UTgDevice_ImpalerArrow::execIsDeviceFiringForUI(FFrame&, void* const)

simulated event bool ShouldCooldownAfterFire() { }

simulated event bool ShouldInterruptInhand() { }

simulated event bool HasCachedLongbow() { }

simulated function FireAmmunition() { }

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
}
