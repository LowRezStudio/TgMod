class TgInventoryObject_Listen_MountShield extends TgInventoryObject_Listen_Mount
    native(Inventory);

var float m_fNextMountShieldTime;
var const float m_fMinMountShieldTime;

defaultproperties
{
    m_fMinMountShieldTime=10.0000000
}