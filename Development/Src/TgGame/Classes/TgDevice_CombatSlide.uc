class TgDevice_CombatSlide extends TgDevice_Charge
    native(ChampLex)
    hidecategories(Navigation)
    config(Engine);

var (Slide) int m_nEyeheightAdjustmentWhileSliding;
var float m_fEyeHeightSmoothFactor;

simulated event bool ShouldInterruptReloadOnFire() { }

native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);  // Export UTgDevice_CombatSlide::execShouldBlockReload(FFrame&, void* const)

simulated event bool CanBeCanceled() { }

state DeviceFiring {}

defaultproperties
{
    m_fEyeHeightSmoothFactor=4.0000000
    m_eChargeState=CHARGE_NoTurn_RotPawn
    m_bCanLeftClickCancel=false
    m_bForce3PViewWhileFiring=false
    m_bMustBeOnGroundToFire=true
}
