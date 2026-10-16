class TgDevice_LongbowPlanted extends TgDevice_Stim
    hidecategories(Navigation)
    config(Engine);

var TgPawn_Longbow m_CachedLongbow;
var TgDevice_LongbowInhand m_CachedInhand;

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function TransitionOut() { }

simulated function bool HasCachedLongbow() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated function bool RequireMovementForAimAssist() { }

state DeviceFiring {}

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_nLinkedDeviceTypes[0]=10828
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_nAimAssistPriorityWhileFiring=2
}
