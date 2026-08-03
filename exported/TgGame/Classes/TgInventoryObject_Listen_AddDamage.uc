class TgInventoryObject_Listen_AddDamage extends TgInvListener
    native(Inventory);

var bool m_bAutoProcOnInhand;
var bool m_bCheckIsValidTarget;

defaultproperties
{
    m_bCheckIsValidTarget=true
}