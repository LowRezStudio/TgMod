class TgInventoryObject_Listen_AddDamage extends TgInvListener
    native(Inventory)
    config(Engine);

var bool m_bAutoProcOnInhand;
var bool m_bCheckIsValidTarget;

defaultproperties
{
    m_bCheckIsValidTarget=true
}
