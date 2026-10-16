class TgDevice_Flutter extends TgDevice_Charge
    native(ChampFairy)
    hidecategories(Navigation);

// Export UTgDevice_Flutter::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

defaultproperties
{
    m_eChargeState=EChargeState.CHARGE_Fairy
    m_ChargeTimingType=ChargeFiringType.CFT_PostFire
    m_bUsePhysFlying=true
}