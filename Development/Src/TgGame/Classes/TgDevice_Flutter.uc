class TgDevice_Flutter extends TgDevice_Charge
    native(ChampFairy)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_Flutter::execGetTargetingAim(FFrame&, void* const)

defaultproperties
{
    m_eChargeState=CHARGE_Fairy
    m_ChargeTimingType=CFT_PostFire
    m_bUsePhysFlying=true
}
