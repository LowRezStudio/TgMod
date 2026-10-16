class TgDevice_HeroicLeap extends TgDevice_Leap
    hidecategories(Navigation)
    config(Engine);

simulated function SetLeapParams(out float scaleLateral, out float scaleVertical, out float additiveLateral, out float additiveVertical) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool ShouldMountCancelFiring() { }

simulated function bool ShouldInterruptReloadOnFire() { }

defaultproperties
{
    m_bAlwaysStartCooldown=true
    m_bForce3PViewWhileFiring=false
    m_bAbilityRequiresInhandResync=false
}
