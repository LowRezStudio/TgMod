class TgInventoryObject_Listen_Marksman extends TgInvListener
    native(Inventory)
    config(Engine);

var int m_nHitCombo;
var int m_nComboToActivate;

defaultproperties
{
    m_nComboToActivate=3
}
