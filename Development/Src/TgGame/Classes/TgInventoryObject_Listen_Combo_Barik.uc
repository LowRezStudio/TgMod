class TgInventoryObject_Listen_Combo_Barik extends TgInventoryObject_Listen_Combo
    native(Inventory)
    config(Engine);

struct ComboInfo {
    var Actor Target;
    var Actor Instigator;
    var float fMarkTime;
    structdefaultproperties {}
};

struct UIMarkInfo {
    var Actor Target;
    var int nUIMarkCount;
    structdefaultproperties {}
};

struct BurningMarkInfo {
    var Actor Target;
    var int nMarkCount;
    structdefaultproperties {}
};

var array<ComboInfo> m_ComboInfoList;
var array<UIMarkInfo> m_UIMarkInfoList;
var array<BurningMarkInfo> m_BurningMarks;

native function TouchedBarricade(Actor Target, Actor barricade);  // Export UTgInventoryObject_Listen_Combo_Barik::execTouchedBarricade(FFrame&, void* const)

native function UpdateExpiredComboInfos();  // Export UTgInventoryObject_Listen_Combo_Barik::execUpdateExpiredComboInfos(FFrame&, void* const)

native function UpdateUIMarks();  // Export UTgInventoryObject_Listen_Combo_Barik::execUpdateUIMarks(FFrame&, void* const)

native function TriggerBurningMarks(Actor Target);  // Export UTgInventoryObject_Listen_Combo_Barik::execTriggerBurningMarks(FFrame&, void* const)
