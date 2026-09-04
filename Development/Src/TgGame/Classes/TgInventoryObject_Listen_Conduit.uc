class TgInventoryObject_Listen_Conduit extends TgInvListener
    native(Inventory)
    config(Engine);

var int m_nDeviceIdShockPulseMain;
var int m_nDeviceIdShockPulseSupport;
var array<Actor> m_EnemiesHitThisPulse;

defaultproperties
{
    m_nDeviceIdShockPulseMain=14475
    m_nDeviceIdShockPulseSupport=14476
}
