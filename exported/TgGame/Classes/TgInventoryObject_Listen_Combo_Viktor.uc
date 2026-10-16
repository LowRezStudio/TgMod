class TgInventoryObject_Listen_Combo_Viktor extends TgInventoryObject_Listen_Combo
    native(Inventory);

struct native TimedMarkedTarget
{
    var Actor Target;
    var float EndTimestamp;

    structdefaultproperties
    {
        Target=none
        EndTimestamp=0.0000000
    }
};

var array<TimedMarkedTarget> m_MarkedTargets;
