class TgInventoryObject_Listen_FirstShotDuringOrAfterStealth extends TgInvListener
    native(Inventory)
    config(Engine);

var bool m_bWasStealthed;
var float m_fLastStealthTime;

defaultproperties
{
    m_fLastStealthTime=10.0000000
}
