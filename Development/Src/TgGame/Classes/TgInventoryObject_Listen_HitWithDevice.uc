class TgInventoryObject_Listen_HitWithDevice extends TgInventoryObject_Listen_AbilityProcBase
    native(Inventory)
    config(Engine);

var bool m_bIgnoreChildDevice;
var bool m_bAutoProcOnInhand;
var bool m_bAutoProcOnAsIfInhand;
var bool m_bSkipActiveCheck;
var bool m_bSkipStartCooldown;
var bool m_bUseAllyTargets;
