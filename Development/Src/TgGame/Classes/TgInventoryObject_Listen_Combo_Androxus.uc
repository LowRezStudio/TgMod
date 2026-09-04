class TgInventoryObject_Listen_Combo_Androxus extends TgInventoryObject_Listen_Combo
    native(Inventory)
    config(Engine);

var int m_DefianceHitCount;
var int m_DefianceHitsToActivate;

defaultproperties
{
    m_DefianceHitsToActivate=3
}
