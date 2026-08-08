class TgDevice_Whirlwind extends TgDevice_HitPulse
    native(ChampGrover)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function bool MustBeOnGroundToFire();  // Export UTgDevice_Whirlwind::execMustBeOnGroundToFire(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

native function bool CanFireIfLeftMouseDown();  // Export UTgDevice_Whirlwind::execCanFireIfLeftMouseDown(FFrame&, void* const)

simulated event bool CanBeInterrupted() { }

simulated event bool CanBeCanceled() { }

simulated event bool CanJumpWhileFiring() { }

simulated event bool CancelledByJumping() { }

simulated function PersistTimer() { }

state DeviceFiring {}

defaultproperties
{
    m_bAlwaysStartCooldown=false
    m_bDisableLagCompensation=true
}
