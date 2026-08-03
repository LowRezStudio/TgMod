class TgInventoryObject_Listen_Weaken extends TgInventoryObject_Listen_HitWithDevice
    native(Inventory);

var int m_nAppliedCategoryCodeToCheck;

defaultproperties
{
    m_nAppliedCategoryCodeToCheck=15071
    m_bAutoProcOnInhand=true
    m_bAutoProcOnAsIfInhand=true
    m_bSkipActiveCheck=true
    m_bSkipStartCooldown=true
}