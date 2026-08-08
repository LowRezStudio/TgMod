class TgDevice_AssertDominance extends TgDevice_Leap
    native(ChampFlak)
    hidecategories(Navigation)
    config(Engine);

native function float GetCachedFiringPostHitDelay();  // Export UTgDevice_AssertDominance::execGetCachedFiringPostHitDelay(FFrame&, void* const)

native function bool ShouldLiftInterrupt();  // Export UTgDevice_AssertDominance::execShouldLiftInterrupt(FFrame&, void* const)

reliable client simulated event ClientInterrupt() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool ShouldMountCancelFiring() { }

simulated function bool ShouldInterruptReloadOnFire() { }

simulated event DeliverHit(ImpactInfo Impact) { }

state DeviceFiring {}

defaultproperties
{
    m_bAbilityRequiresInhandResync=false
}
