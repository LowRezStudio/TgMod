class TgInventoryObject_Listen_Combo_Viktor extends TgInventoryObject_Listen_Combo
    native(Inventory)
    config(Engine);

struct TimedMarkedTarget {
    var Actor Target;
    var float EndTimestamp;
    structdefaultproperties {}
};

var array<TimedMarkedTarget> m_MarkedTargets;
