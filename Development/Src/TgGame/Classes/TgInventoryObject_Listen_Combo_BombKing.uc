class TgInventoryObject_Listen_Combo_BombKing extends TgInventoryObject_Listen_Combo
    native(Inventory)
    config(Engine);

const BOMBKING_COMBO_DEVICE_ID_AUTO = 14308;

const BOMBKING_COMBO_DEVICE_ID_DETONATOR = 14309;

struct StickyHitInfo {
    var Actor HitActor;
    var int NumHits;
    structdefaultproperties {}
};

var array<StickyHitInfo> m_HitActors;
