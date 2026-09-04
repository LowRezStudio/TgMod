class TgInventoryObject_Listen_EnergyCharge extends TgInvListener
    native(Inventory)
    config(Engine);

var TgPawn m_CachedTgPawn;
var float m_fChargeMultiplierDamageDealt;
var float m_fChargeMultiplierDamageTaken;
var float m_fChargeMultiplierPetDamage;

defaultproperties
{
    m_fChargeMultiplierDamageDealt=1.0000000
    m_fChargeMultiplierDamageTaken=1.0000000
    m_fChargeMultiplierPetDamage=1.0000000
}
