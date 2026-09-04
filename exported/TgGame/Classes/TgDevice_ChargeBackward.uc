class TgDevice_ChargeBackward extends TgDevice_Charge
    native(Devices)
    hidecategories(Navigation);

defaultproperties
{
    m_ChargeTimingType=ChargeFiringType.CFT_PostFire
    m_bChargeBackward=true
}