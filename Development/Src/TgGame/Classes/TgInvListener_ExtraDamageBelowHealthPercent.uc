class TgInvListener_ExtraDamageBelowHealthPercent extends TgInventoryObject_Listen_AddDamage
    native(Inventory)
    config(Engine);

defaultproperties
{
    m_bAutoProcOnInhand=true
}
