class TgInventoryObject_Listen_ActiveWhileDeployableInactive extends TgInventoryObject_Listen_ActiveWhileOffCooldown
    native(Inventory)
    config(Engine);

var int m_nActiveDeployableCount;

defaultproperties
{
    m_nActiveDeployableCount=-1
}
