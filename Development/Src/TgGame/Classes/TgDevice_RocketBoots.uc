class TgDevice_RocketBoots extends TgDevice_Charge
    native(ChampBarik)
    hidecategories(Navigation)
    config(Engine);

simulated function float GetChargeSpeed() { }

simulated event float GetChargeRange() { }

simulated event bool CanBeCanceled() { }

defaultproperties
{
    m_eChargeState=CHARGE_Turn
}
