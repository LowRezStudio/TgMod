class TgInventoryObject_Listen_Combo_Barik extends TgInventoryObject_Listen_Combo
    native(Inventory);

struct native ComboInfo
{
    var Actor Target;
    var Actor Instigator;
    var float fMarkTime;

    structdefaultproperties
    {
        Target=none
        Instigator=none
        fMarkTime=0.0000000
    }
};

struct native UIMarkInfo
{
    var Actor Target;
    var int nUIMarkCount;

    structdefaultproperties
    {
        Target=none
        nUIMarkCount=0
    }
};

struct native BurningMarkInfo
{
    var Actor Target;
    var int nMarkCount;

    structdefaultproperties
    {
        Target=none
        nMarkCount=0
    }
};

var array<ComboInfo> m_ComboInfoList;
var array<UIMarkInfo> m_UIMarkInfoList;
var array<BurningMarkInfo> m_BurningMarks;

// Export UTgInventoryObject_Listen_Combo_Barik::execTouchedBarricade(FFrame&, void* const)
native function TouchedBarricade(Actor Target, Actor barricade);

// Export UTgInventoryObject_Listen_Combo_Barik::execUpdateExpiredComboInfos(FFrame&, void* const)
native function UpdateExpiredComboInfos();

// Export UTgInventoryObject_Listen_Combo_Barik::execUpdateUIMarks(FFrame&, void* const)
native function UpdateUIMarks();

// Export UTgInventoryObject_Listen_Combo_Barik::execTriggerBurningMarks(FFrame&, void* const)
native function TriggerBurningMarks(Actor Target);
