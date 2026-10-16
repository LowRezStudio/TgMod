class TgDevice_InPursuit extends TgDevice
    native(ChampLex)
    hidecategories(Navigation)
    config(Engine);

var bool m_bRecalculateTarget;
var TgPawn_Character m_CurrentMark;
var Actor m_PursuitTarget;
var TgDevice_LexInhand m_CachedInhand;

native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);  // Export UTgDevice_InPursuit::execShouldBlockReload(FFrame&, void* const)

simulated event bool CanBeCanceled() { }

simulated function TruePostFire() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

state DeviceFiring {}

defaultproperties
{
    m_bRecalculateTarget=true
    m_nLinkedDeviceTypes[0]=10828
}
