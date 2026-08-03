class TgInventoryObject_Listen_Marksman extends TgInvListener
    native(Inventory);

var int m_nHitCombo;
var int m_nComboToActivate;

defaultproperties
{
    m_nComboToActivate=3
}