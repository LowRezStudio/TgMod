class TgInventoryObject_Listen_CooldownDelayer extends TgInventoryObject_Listen_AbilityInstant
    native(Inventory);

enum TG_FIRE_FX_DUMMY_ON
{
    TARGET_NEVER,                   // 0
    TARGET_STARTFIRE,               // 1
    TARGET_STOPFIRE,                // 2
    TARGET_MAX                      // 3
};

var float m_fDelayTime;
var TgInventoryObject_Listen_CooldownDelayer.TG_FIRE_FX_DUMMY_ON m_FireFxDummyOn;

defaultproperties
{
    m_fDelayTime=-1.0000000
}