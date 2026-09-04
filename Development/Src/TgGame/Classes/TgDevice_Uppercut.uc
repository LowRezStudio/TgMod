class TgDevice_Uppercut extends TgDevice_Charge
    native(ChampDemon)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_Uppercut::execGetTargetingAim(FFrame&, void* const)

simulated function bool IsUltActive() { }

simulated event DeliverHit(ImpactInfo Impact) { }

simulated event bool CanBeInterrupted() { }

state DeviceFiring {}

defaultproperties
{
    m_bStopOnHitType=CSHT_GodOnly
    m_ChargeTimingType=CFT_PreFire
    m_bApplyHitOnTouch=false
    m_bForce3PViewWhileFiring=false
}
