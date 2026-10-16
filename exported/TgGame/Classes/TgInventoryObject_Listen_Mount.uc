class TgInventoryObject_Listen_Mount extends TgInventoryObject_Listen_ActiveDuringAbility
    native(Inventory);

defaultproperties
{
    m_eDuringType=EDuringAbilityType.DURINGABILITY_POSTFIRE
    m_nAbilityTypeRestriction=11077
}