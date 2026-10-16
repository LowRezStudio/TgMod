class TgInventoryObject_Listen_Combo_BombKing extends TgInventoryObject_Listen_Combo
    native(Inventory);

const BOMBKING_COMBO_DEVICE_ID_AUTO = 14308;
const BOMBKING_COMBO_DEVICE_ID_DETONATOR = 14309;

struct native StickyHitInfo
{
    var Actor HitActor;
    var int NumHits;

    structdefaultproperties
    {
        HitActor=none
        NumHits=0
    }
};

var array<StickyHitInfo> m_HitActors;
