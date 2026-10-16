class TgDevice_ChargeBackward extends TgDevice_Charge
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

defaultproperties
{
    m_ChargeTimingType=CFT_PostFire
    m_bChargeBackward=true
}
