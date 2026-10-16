class TgInventoryObject_Listen_BowlingBall extends TgInventoryObject_Listen_ActiveDuringAbility
    native(Inventory)
    config(Engine);

var float m_fRocketBootsEndTime;
var float m_fPostRocketBootsTime;

defaultproperties
{
    m_fRocketBootsEndTime=-4.0000000
    m_fPostRocketBootsTime=4.0000000
}
