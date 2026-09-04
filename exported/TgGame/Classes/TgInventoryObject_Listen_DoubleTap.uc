class TgInventoryObject_Listen_DoubleTap extends TgInvListener
    native(Inventory);

var float m_fBaseWeaponDamage;
var float m_fDoubleTapDelay;
var array<Actor> m_PendingDoubleTapActors;
var array<float> m_PendingDoubleTapTimes;

defaultproperties
{
    m_fDoubleTapDelay=0.2000000
}