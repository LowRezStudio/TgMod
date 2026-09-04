class TgInventoryObject_Listen_DuringAbility extends TgInventoryObject_Listen_AbilityProcBase
    abstract
    native(Inventory)
    config(Engine);

enum EDuringAbilityType {
    DURINGABILITY_PREFIRE,  // 0
    DURINGABILITY_FIRE,  // 1
    DURINGABILITY_POSTFIRE,  // 2
};

var bool m_bAbilityInActiveState;
var bool m_bIsActive;
var const TgInventoryObject_Listen_DuringAbility.EDuringAbilityType m_eDuringType;

defaultproperties
{
    m_eDuringType=DURINGABILITY_FIRE
}
