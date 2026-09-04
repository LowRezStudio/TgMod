class TgInventoryObject_Listen_MendingSpiritsActive extends TgInventoryObject_Listen_AbilityProcBase
    native(Inventory)
    config(Engine);

const MENDING_SPIRITS_DEVICE_ID = 14822;

const MENDING_SPIRITS_EFFECT_GROUP_ID = 55837;

var array<TgPawn> m_PawnTargets;
var bool m_bEffectsAreActive;
