class TgDevice_Thrust extends TgDevice_Charge
    native(ChampDrogoz)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_Thrust::execGetTargetingAim(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event float GetChargeRange() { }

simulated function bool ShouldInterruptReloadOnFire() { }

state DeviceFiring {}

defaultproperties
{
    m_bUsePhysFlying=true
    m_bIgnoreRange=true
    m_bForce3PViewWhileFiring=false
    m_bAbilityRequiresInhandResync=false
}
