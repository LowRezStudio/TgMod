class TgInventoryObject_Listen_Mount extends TgInventoryObject_Listen_ActiveDuringAbility
    native(Inventory)
    config(Engine);

defaultproperties
{
    m_eDuringType=DURINGABILITY_POSTFIRE
    m_nAbilityTypeRestriction=11077
}
